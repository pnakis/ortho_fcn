function [x,y] = collinearity_radial(X,Y,Z,io,eo)

xo = io(1);
yo = io(2);
c = io(3);
k1 = io(4);
k2 = io(5);

Xo = eo(1);
Yo = eo(2);
Zo = eo(3);
omega = eo(4);
phi = eo(5);
kappa = eo(6);

[R] = angles_matrix(omega,phi,kappa);

x = xo - c*((X-Xo)*R(1,1) + (Y-Yo)*R(1,2) + (Z-Zo)*R(1,3)) / ((X-Xo)*R(3,1) + (Y-Yo)*R(3,2) + (Z-Zo)*R(3,3));

y = yo - c*((X-Xo)*R(2,1) + (Y-Yo)*R(2,2) + (Z-Zo)*R(2,3)) / ((X-Xo)*R(3,1) + (Y-Yo)*R(3,2) + (Z-Zo)*R(3,3));

r = sqrt((x-xo)^2+(y-yo)^2);
dr = k1*r^3 + k2*r^5;
dx = dr*((x-xo)/r);
dy = dr*((y-xo)/r);
x = x + dx;
y = y + dy;

