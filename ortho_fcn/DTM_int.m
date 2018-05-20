function [Z] = DTM_int(X,Y,DTM,DTM_Xmax,DTM_Xmin,DTM_Ymax,DTM_Ymin,D)
 % [Z Z Z Z .... Z;...] style DTM
 
x = size(DTM,2);
y = size(DTM,1);

if (X>DTM_Xmax) || (X<DTM_Xmin) || (Y>DTM_Ymax) || (Y<DTM_Ymin)
    
	Z = NaN;
    return
    
elseif (Y==DTM_Ymin) && (X==DTM_Xmax)
    
    Z = DTM(y,x);
    return
    
elseif (Y==DTM_Ymin)
    
	m = (DTM_Ymax - Y)/D + 1;
    n = (X - DTM_Xmin)/D + 1;
    
    Zp1 = DTM(floor(m),floor(n));
    Zp2 = DTM(floor(m),floor(n)+1);    
    Zp3 = DTM(floor(m)-1,floor(n));
    Zp4 = DTM(floor(m)-1,floor(n)+1);
   
elseif (X==DTM_Xmax)
    
	m = (DTM_Ymax - Y)/D + 1;
    n = (X - DTM_Xmin)/D + 1;
    
	Zp1 = DTM(floor(m),floor(n));
    Zp2 = DTM(floor(m),floor(n)-1);
    Zp3 = DTM(floor(m)+1,floor(n)-1);
    Zp4 = DTM(floor(m)+1,floor(n));
        
else

    m = (DTM_Ymax - Y)/D + 1;
    n = (X - DTM_Xmin)/D + 1;

    Zp1 = DTM(floor(m),floor(n));
    Zp2 = DTM(floor(m),floor(n)+1);
    Zp3 = DTM(floor(m)+1,floor(n));
    Zp4 = DTM(floor(m)+1,floor(n)+1);
   
end

Sp1 = sqrt((floor(m)-m)^2 + (floor(n)-n)^2);
Sp2 = sqrt((floor(m)-m)^2 + (floor(n)+1-n)^2);
Sp3 = sqrt((floor(m)+1-m)^2 + (floor(n)-n)^2);
Sp4 = sqrt((floor(m)+1-m)^2 + (floor(n)+1-n)^2);

Wp1 = 1/Sp1^2;
Wp2 = 1/Sp2^2;
Wp3 = 1/Sp3^2;
Wp4 = 1/Sp4^2;

if (Sp1==0)
    
    Z = Zp1;
    
else
    
    Z = (Wp1*Zp1 + Wp2*Zp2 + Wp3*Zp3 + Wp4*Zp4)/(Wp1 + Wp2 + Wp3 + Wp4);
    
end
