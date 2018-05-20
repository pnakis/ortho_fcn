function [AffCoe,so,Residuals,CoeError] = affine_trans(xy,ij)
%This function calculates the 6 affine transformation coefficients

    
for i = 1:size(xy,1)
    
    %A and b matrix
    A(2*i-1,1) = ij(i,1);
    A(2*i-1,2) = ij(i,2);
    A(2*i-1,3) = 1;
    A(2*i,4) = ij(i,1);
    A(2*i,5) = ij(i,2);
    A(2*i,6) = 1;
        
    b(2*i-1,1) = xy(i,1);
    b(2*i,1) = xy(i,2);
        
end

%6 coefficients
AffCoe = inv(A'*A)*(A'*b);
% xy residuals
V = b-A*AffCoe;
%standard deviation
so = sqrt((V'*V)/(size(xy,1)*2-6));
VX = so^2*inv(A'*A);
Residuals = V;

for i = 1:size(AffCoe,1)
    
    %coefficient errors        
    CoeError(i,1) = sqrt(VX(i,i));
        
end      
