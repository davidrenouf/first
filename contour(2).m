clear;
clc;
close;

img = imread('cameraman.tif');

%%
Sx = [1 0 -1; 2 0 -2; 1 0 -1];
Sy = Sx';

filtre = Sx*Sy;

img_f = conv2(img,filtre,'same');

figure, imagesc(img_f);
colormap(gray);

%%
P = -10:10;
[X,Y] = meshgrid(P,P);

sig = 0.05;
Gx = -X/(2*pi*sig^4).*exp(-(X.^2+Y.^2)/(2*sig^2));
Gy = -Y/(2*pi*sig^4).*exp(-(X.^2+Y.^2)/(2*sig^2));

figure, surf(Gx), shading interp;

img_fx = conv2(img,Gx,'same');
img_fy = conv2(img,Gy,'same');

Nimgx = sqrt(imgfx.^2);
Nimgy = sqrt(imgfy.^2);