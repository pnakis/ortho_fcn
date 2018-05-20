function [g] = nearest_int(im,i,j,n)

if (i<1) || (j<1) || (i>size(im,1)) || (j>size(im,2))  
    
    g = 0;
    
else
    
    y = round(i);
    x = round(j);
	
    g = im(y,x,n);
    
end
    




