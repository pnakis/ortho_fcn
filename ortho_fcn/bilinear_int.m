function [g] = bilinear_int(im,i,j,n)

if (i<1) || (j<1) || (i>size(im,1)) || (j>size(im,2))  
    
    g = 0;
    
elseif (i==1) || (j==1) || (i==size(im,1)) || (j==size(im,2))
    
    [g] = nearest_int(im,i,j,n);

else
    
    y = floor(i);
    x = floor(j);

    p1 = im(y,x,n);
    p2 = im(y,x+1,n);
    p3 = im(y+1,x,n);
    p4 = im(y+1,x+1,n);

    Dy = i-y;
    Dx = j-x;

    g = (1-Dy)*(1-Dx)*p1 + (1-Dy)*Dx*p2 + Dy*(1-Dx)*p3 + Dy*Dx*p4;
    
end
  

    



   