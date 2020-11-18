clear all
close all
clc

img = double(imread('../img/moon.png'));
%img = double(imread('cameraman.tif'));
H = [1 1 1; 1 -8 1; 1 1 1]; %Filtre isotrope de détecteur de contours
C = conv2(img, H, 'same'); %option 'same' pour avoir la taille de l'image 
beta = 5;
res = img - beta*C; %réhaussement des contrastes

%Normalisation
res(res>255) = 255;
res(res<0) = 0;

figure, 
imagesc(C); title('Contrastes');

figure, 
subplot(121)
imagesc(img); 
title('Image initiale');
subplot(122)
imagesc(res);
title(sprintf('Image réhaussée I-%ddI', beta));
colormap(gray)