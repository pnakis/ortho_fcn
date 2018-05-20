function save_affine(savefpname,AffCoe,CoeError,so,Residuals)

fid = fopen(savefpname, 'w');

fprintf(fid, 'Affine Transformation Coefficients:\r\n');
fprintf(fid, '\r\n');
for i=1:6
    
    fprintf(fid, 'a%i= %f ± %f\r\n' ,i,AffCoe(i),CoeError(i));
    
end
fprintf(fid, '\r\n');
fprintf(fid, 'sigma= %f\r\n',so);
fprintf(fid, '\r\n');
fprintf(fid, 'Residuals:\r\n');
fprintf(fid, '\r\n');
for i=1:size(Residuals,1)/2
    
    fprintf(fid, '%i= %f %f\r\n',i,Residuals(2*i-1),Residuals(2*i));
    
end

fclose(fid);