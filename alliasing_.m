clear;
close;
clc;

img = imread("barbara.bmp");

img_f = conv2(img,fspecial('gaussian',3,1,'same'));

figure,
imagesc(img);
imagesc(img(1:4:end,1:4:end));
imagesc(img_f(1:4:end,1:4:end));
imagesc(imresize(img,1/4));
colormap(gray)
