clear;
close;
clc;

%%
s = load('challenge.mat');

%%
%Chargement d’image (format uint8)
% [img,palette] = imread('lena.bmp');
% 
% [h,w,c] = size(img);
% 
% b = colormap(jet);
% 
% figure,imshow(img,colormap(jet)); %différentes palettes : hsv, cool, hot, bone, copper, pink, flag, jet
% figure,imshow(img,palette);

%%
% 
% I = s.A; %Baboon
% figure, imshow(uint8(I));
% 
% I = I/max(I(:));
% figure, imshow(I); %deux méthodes pour afficher

%%
% 
% I = s.C;
% 
% figure, imagesc(I);
% m = max(I(:));
% imagesc(I, [100,135]);

%%

% I = s.D;
% figure, imagesc(I);
% colormap(jet);

%%



I = s.E;
figure, imagesc(I); %[0.1529,0.5882,0.9216]

map = [0.2784 0.3412 0.9686; 0.9333 0.5098 0.9333; 0.0941 0.749 0.7098; 0 0 0; 0 0 0; 0 0 0; 0 0 0]
colormap(map);
