clear;
close;
clc;

img = imread('pool.tif');
[h,w,z] = size(img);

ycbcr = rgb2ycbcr(img);

cb = ycbcr(:,:,2);
cr = ycbcr(:,:,3);

r = 0.5;

cb_r = imresize(imresize(cb,r),[h,w]);
cr_r = imresize(imresize(cr,r),[h,w]);

ycbcr(:,:,2) = cb_r;
ycbcr(:,:,3) = cr_r;

img_r = ycbcr2rgb(ycbcr);

figure,
subplot(121)
imagesc(img)
subplot(122)
imagesc(img_r);
title(sprintf('%3.f',r));


