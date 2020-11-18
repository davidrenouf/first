clear;
clc;
close;

img = imread('moon');

f = 1/2.^[1 1 1; 1 -8 1; 1 1 1];
F = f*f';

imf_f = conv2(img, F, 'same');

figure, imagesc(img_f);


