function [world_file,ortho_im] = orthorectification(im,DTM,io,eo,d,AffCoe,DTM_Ymax,DTM_Xmin,DTM_D,int_method)
wb = waitbar(0,'Orthorectification in progress. Please wait...','CreateCancelBtn','setappdata(gcbf,''canceling'',1)');
canceled = 0;
%---------------------- Image limits ----------------------
if (size(DTM,2) == 3)
    % X Y Z - DTM    
    DTM_Xmax = max(DTM(:,1));
    DTM_Xmin = min(DTM(:,1));
    DTM_Ymax = max(DTM(:,2));
    DTM_Ymin = min(DTM(:,2));
    
    % Delaunay Triangulation   
    % DTM X,Y,Z column
    
    dt = DelaunayTri(DTM(:,1),DTM(:,2));
    F = TriScatteredInterp(dt,DTM(:,3));
    
else
    % Grid - DTM
    n = size(DTM,1);	% y
    m = size(DTM,2);	% x 

    DTM_Xmax = (m-1)*DTM_D + DTM_Xmin;
    DTM_Ymin = DTM_Ymax - (n-1)*DTM_D;

end

ortho_height = round((DTM_Ymax-DTM_Ymin)/d);
ortho_width = round((DTM_Xmax-DTM_Xmin)/d);

ortho_im = zeros(ortho_height,ortho_width,size(im,3));

%---------------------- Image limits end ----------------------

%---------------------- Orthorectification --------------------

for r = 1:ortho_height
    %waitbar 
    waitbar(r / ortho_height)
    if getappdata(wb,'canceling') % cancel button check
        canceled = 1;
        break
    elseif ~ishandle(wb) % [x] button check
        canceled = 1;
        break
    end
    %waitbar end
    for c = 1:ortho_width 
        
        X = DTM_Xmin + (c-1) * d + d/2;
        Y = DTM_Ymax - (r-1) * d - d/2;
        
        if (size(DTM,2) == 3)
            % Z Calculation from Delaunay 
            Z = F(X,Y);
            
        else
        
            Z = DTM_int(X,Y,DTM,DTM_Xmax,DTM_Xmin,DTM_Ymax,DTM_Ymin,DTM_D);

        end
        
        if isnan(Z)
            
            ortho_im(r,c) = 0;
            
        else
            
            [x,y] = collinearity_radial(X,Y,Z,io,eo);
            
            [j,i] = apply_affine(x,y,AffCoe);
            
            switch int_method    

                case {'Nearest'}                    
                    if size(im,3)>1
                        for n = 1:3
                            [g] = nearest_int(im,i,j,n);
                            ortho_im(r,c,n) = g;
                        end
                        
                    else
                        [g] = nearest_int(im,i,j,1);
                        ortho_im(r,c) = g;
                        
                    end
                    
                case {'Bilinear'}
                    if size(im,3)>1
                        for n = 1:3
                            [g] = bilinear_int(im,i,j,n);
                            ortho_im(r,c,n) = g;
                        end
                        
                    else
                        [g] = bilinear_int(im,i,j,1);
                        ortho_im(r,c) = g;
                    end

                case {'Bicubic'}
                    if size(im,3)>1
                        for n = 1:3
                            [g] = bicubic_int(im,i,j,n);
                            ortho_im(r,c,n) = g;
                        end
                        
                     else
                         [g] = bicubic_int(im,i,j,1);
                         ortho_im(r,c) = g;
                    end
            end
        end
    end
end
%---------------------- Orthorectification end -----------------
if canceled == 1
    msgbox('Orthorectification Canceled.','','error');
    ortho_im = [];
    world_file = [];
else
    
    world_file(1,1) = d;
    world_file(2,1) = 0;
    world_file(3,1) = -0;
    world_file(4,1) = -d;
    world_file(5,1) = DTM_Xmin + d/2;
    world_file(6,1) = DTM_Ymax - d/2;
    
    ortho_im = uint8(ortho_im);
    figure
    imshow(ortho_im)
    msgbox('Orthorectification Completed.');
end

delete(wb) 