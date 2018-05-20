function [x_new,y_new] = apply_affine(x,y,AffCoe)
         
x_new = AffCoe(1)*x + AffCoe(2)*y + AffCoe(3);
y_new = AffCoe(4)*x + AffCoe(5)*y + AffCoe(6);
    