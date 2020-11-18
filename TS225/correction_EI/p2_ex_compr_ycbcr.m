
clear all
close all
clc
pkg load image

A = imread('../img/pool.tif');
[h,w,c] = size(A);
figure, imagesc(A), 
title('Initial pool.tif');

ycbcr = rgb2ycbcr(A);
cb = ycbcr(:,:,2);
cr = ycbcr(:,:,3);

r = 0.5; 
cb_r = imresize(imresize(cb,r),[h w]); %On perd la dimension originale avec l'arrondi
cr_r = imresize(imresize(cr,r),[h w]);
ycbcr(:,:,2) = cb_r;
ycbcr(:,:,3) = cr_r;
A_r = ycbcr2rgb(ycbcr);

figure, imagesc(A_r), 
title(sprintf('Compressed pool.tif - ratio %1.3f',r));



