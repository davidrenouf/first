clear;
close;
clc;

%%

s = 201;
d = 30;
R = 40;

[X,Y] = meshgrid(1:s);

cB = [s/2+d s/2];
%yB = s/2+d;
%xB = s/2;
B = (X - cB(2)).^2 + (Y - cB(1)).^2 <= R^2;

figure, 
imagesc(B)
