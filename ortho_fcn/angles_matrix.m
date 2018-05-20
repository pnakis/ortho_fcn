function [R] = angles_matrix(omega,phi,kappa)

%degrees to rad
omega = omega*(pi/180);
phi = phi*(pi/180);
kappa = kappa*(pi/180);


R = [cos(phi)*cos(kappa) cos(omega)*sin(kappa)+sin(omega)*sin(phi)*cos(kappa) sin(omega)*sin(kappa)-cos(omega)*sin(phi)*cos(kappa);
     -cos(phi)*sin(kappa) cos(omega)*cos(kappa)-sin(omega)*sin(phi)*sin(kappa) sin(omega)*cos(kappa)+cos(omega)*sin(phi)*sin(kappa);
     sin(phi) -sin(omega)*cos(phi) cos(omega)*cos(phi)];