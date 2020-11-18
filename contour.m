clear;
close;
clc;

img = imread('home.jpg');
%[h,w,z] = size(img);

%I = edge(img);
alpha = 100;
beta =25;

ycbcr = rgb2ycbcr(img);

C = my_edge(ycbcr(:,:,1));

%figure,
%imagesc(C)

Y = (255-alpha)*(1-C) + beta; 
cb = ycbcr(:,:,2);
cr = ycbcr(:,:,3);

%r = 0.5;

%cb_r = imresize(imresize(cb,r),[h,w]);
%cr_r = imresize(imresize(cr,r),[h,w]);

%ycbcr(:,:,2) = cb_r;
%ycbcr(:,:,3) = cr_r;

img_f = ycbcr2rgb(ycbcr);

figure,
imagesc(img_f)

%figure,
%subplot(121)
%imagesc(img)
%subplot(122)
%imagesc(img_r);
%title(sprintf('%3.f',r));


