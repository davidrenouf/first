
function [R,G,B] = p1_ex_disks(s,radius,d)

[X,Y] = meshgrid(1:s);

cb = [s/2+d s/2];
cr = [s/2 s/2] + d*[-sin(pi/6) cos(pi/6)];
cg = [s/2 s/2] + d*[-sin(pi/6) -cos(pi/6)];

B = (X-cb(2)).^2 + (Y-cb(1)).^2 <= radius^2;
R = (X-cr(2)).^2 + (Y-cr(1)).^2 <= radius^2;
G = (X-cg(2)).^2 + (Y-cg(1)).^2 <= radius^2;


end