function save_georef(savefpname,imfilename,dtmfilename,iofilename,eofilename,DTM_Xmin,DTM_Ymax,DTM_Xmax,DTM_Ymin,DTM_D,d,int_method,AffCoe,io,eo,pixelsize)


fid = fopen(savefpname, 'w');

fprintf(fid, 'Files used:\r\n');
fprintf(fid, 'Source image: %s\r\n',imfilename);
fprintf(fid, 'DTM: %s\r\n',dtmfilename);
fprintf(fid, 'Interior Orientation: %s\r\n',iofilename);
fprintf(fid, 'Exterior Orientation: %s\r\n',eofilename);
fprintf(fid, '-----------------------------------\r\n');
fprintf(fid, '\r\n');
fprintf(fid, 'First pixel coordinates:\r\n');
fprintf(fid, 'X(m): %f\r\n',DTM_Xmin + d/2);
fprintf(fid, 'Y(m): %f\r\n',DTM_Ymax - d/2);
fprintf(fid, 'Groundel(m): %f\r\n',d);
fprintf(fid, '-----------------------------------\r\n');
fprintf(fid, '\r\n');
fprintf(fid, 'Interpolation method: %s\r\n',int_method);
if ~isempty(pixelsize)
    fprintf(fid, 'Image type: Digital \r\n');
else
    fprintf(fid, 'Image type: Analog \r\n');
end
fprintf(fid, '\r\n');
fprintf(fid, 'DTM information:\r\n');
fprintf(fid, 'DTM_Xmin(m): %f\r\n',DTM_Xmin);
fprintf(fid, 'DTM_Xmax(m): %f\r\n',DTM_Xmax);
fprintf(fid, 'DTM_Ymin(m): %f\r\n',DTM_Ymin);
fprintf(fid, 'DTM_Ymax(m): %f\r\n',DTM_Ymax);
if ~isempty(DTM_D)
    fprintf(fid, 'DTM_D(m): %f\r\n',DTM_D);
end
fprintf(fid, '\r\n');
fprintf(fid, 'Exterior Orientation:\r\n');
fprintf(fid, 'X(m): %f\r\n',eo(1));
fprintf(fid, 'Y(m): %f\r\n',eo(2));
fprintf(fid, 'Z(m): %f\r\n',eo(3));
fprintf(fid, 'omega(deg): %f\r\n',eo(4));
fprintf(fid, 'phi(deg): %f\r\n',eo(5));
fprintf(fid, 'kappa(deg): %f\r\n',eo(6));
fprintf(fid, '\r\n');
fprintf(fid, 'Interior Orientation:\r\n');
fprintf(fid, 'xo(mm): %f\r\n',io(1));
fprintf(fid, 'yo(mm): %f\r\n',io(2));
fprintf(fid, 'c(mm): %f\r\n',io(3));
fprintf(fid, 'k1: %f\r\n',io(4));
fprintf(fid, 'k2: %f\r\n',io(5));
fprintf(fid, '\r\n');
fprintf(fid, 'Affine Coefficients:\r\n');
fprintf(fid, 'a1: %f\r\n',AffCoe(1));
fprintf(fid, 'b1: %f\r\n',AffCoe(2));
fprintf(fid, 'dx: %f\r\n',AffCoe(3));
fprintf(fid, 'a2: %f\r\n',AffCoe(4));
fprintf(fid, 'b2: %f\r\n',AffCoe(5));
fprintf(fid, 'dy: %f\r\n',AffCoe(6));
if ~isempty(pixelsize)
    fprintf(fid, '\r\n');
    fprintf(fid, 'Sensor pixel size(mm): %f\r\n',pixelsize);
end
fclose(fid); 