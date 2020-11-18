clear all
close all
clc
pkg load image

img = imread('../img/home.jpg');
img_ycbcr = rgb2ycbcr(uint8(img));

C = edge(img_ycbcr(:,:,1)); 
%%edge veut du h*w, pas du h*w*3, donc on lui donne par exemple le canal de
%%luminance Y
%	P = -10:0.1:10;
%	[X,Y] = meshgrid(P,P);
%% 2) On retrouve l’expression des dérivées en x et y de g(x,y) pour leur fournir les cartes du meshgrid et obtenir deux filtres détecteurs de contours Gx Gy :
%	sig = 0.05;
%	Gx = -X/(2*pi*sig^4).*exp(-(X.^2+Y.^2)/(2*sig^2));
%	Gy = -Y/(2*pi*sig^4).*exp(-(X.^2+Y.^2)/(2*sig^2));
%	figure, surf(Gx), shading interp;
%% 3) Calculer la norme des deux réponses pour obtenir une détection de contours :
%	Ix = conv2(img_ycbcr(:,:,1),Gx,'same');
%	Iy = conv2(img_ycbcr(:,:,1),Gy,'same');
%	
%    figure, 
%    imagesc(Ix); title('X');
%    figure, imagesc(Iy); title('Y');
%    
%    
%    delta_I = sqrt(Ix.^2 + Iy.^2);
%    delta_I = delta_I / max(delta_I(:));   
%    
%%     figure, imagesc(delta_I)
%    
%    C = delta_I;
    %%
figure, imagesc(C); title('Carte de contours');

alpha = 36;
beta = 16;
img_ycbcr(:,:,1) = (255-alpha)*(1-C) + beta;
img_esquisse = ycbcr2rgb(img_ycbcr);

figure,
imagesc(img_esquisse);
title('Résultat pencil skecth.png');
