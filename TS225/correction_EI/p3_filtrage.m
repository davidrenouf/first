clear all, close all, clc

img = imread('../img/barbara_awgn_noise.png');

%Filtre moyenneur rectangle uniforme
H = [1 1 1 ; 1 1 1; 1 1 1] / 9;
H = ones(3)/9; %équivalents
img_f = conv2(img, H);

figure, 
ll(1) = subplot(121); imagesc(img); title('Image initiale');
ll(2) = subplot(122); imagesc(img_f); title('Image filtrée (moyenneur)');
linkaxes(ll);
colormap(gray)
%Avec le moyenneur, on perd les textures

%% Gaussien

H = fspecial('gaussian', [7 7], 1.25); 
figure, surf(H); 
title('Filtre gaussien');

img_f = conv2(img, H);

figure, 
mm(1) = subplot(121); imagesc(img); title('Image initiale');
mm(2) = subplot(122); imagesc(img_f); title('Image filtrée (Gaussien)');
linkaxes(mm);
colormap(gray)
%Avec le Gaussien, un peu mieux mais pas des miracles

%Les deux filtrages échouent sur un bruit poivre et sel ('cameraman_sp_noise.png');

%% Filtrage médian

img = imread('../img/cameraman_sp_noise.png');
figure, subplot(121); imagesc(img); title('Image initiale');

[h,w,c] = size(img);
v = 1; %Demi taille du voisinage (2v+1)*(2v+1)

I_f = zeros(h,w);
for i=1+v:h-v
    for j=1+v:w-v
        window = img(i-v:i+v, j-v:j+v);
        I_f(i,j) = median(window(:));
    end
end

subplot(122); imagesc(I_f); title('Image filtrée (médian)');
colormap(gray);





