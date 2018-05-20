function [g] = bicubic_int(im,i,j,n)

if (i<=2) || (j<=2) || (i>=size(im,1)-1) || (j>=size(im,2)-1)
    
    [g] = bilinear_int(im,i,j,n);
    
else

y = floor(i);
x = floor(j);

p1 = im(y-1,x-1,n);
p2 = im(y-1,x,n);
p3 = im(y-1,x+1,n);
p4 = im(y-1,x+2,n);
p5 = im(y,x-1,n);
p6 = im(y,x,n);
p7 = im(y,x+1,n);
p8 = im(y,x+2,n);
p9 = im(y+1,x-1,n);
p10 = im(y+1,x,n);
p11 = im(y+1,x+1,n);
p12 = im(y+1,x+2,n);
p13 = im(y+2,x-1,n);
p14 = im(y+2,x,n);
p15 = im(y+2,x+1,n);
p16 = im(y+2,x+2,n);

P = [p1 p2 p3 p4;
     p5 p6 p7 p8;
     p9 p10 p11 p12;
     p13 p14 p15 p16];

Dy = i-y;
Dx = j-x;

w1_Sy = (-Dy^3+2*Dy^2-Dy)/2;
w2_Sy = (3*Dy^3-5*Dy^2+2)/2;
w3_Sy = (-3*Dy^3+4*Dy^2+Dy)/2;
w4_Sy = (Dy^3-Dy^2)/2;

w1_Sx = (-Dx^3+2*Dx^2-Dx)/2;
w2_Sx = (3*Dx^3-5*Dx^2+2)/2;
w3_Sx = (-3*Dx^3+4*Dx^2+Dx)/2;
w4_Sx = (Dx^3-Dx^2)/2;

WSy = [w1_Sy w2_Sy w3_Sy w4_Sy];
WSx = [w1_Sx w2_Sx w3_Sx w4_Sx]';

g = double(WSy)*double(P)*double(WSx);

end