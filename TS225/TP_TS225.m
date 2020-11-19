%David Renouf TS225%
clear;
close;
clc;

%% Espaces de representation des couleurs

img = imread('pool.tif');
[h,w,z] = size(img);

R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);

ycbcr = rgb2ycbcr(img);

Cb = ycbcr(:,:,2);
Cr = ycbcr(:,:,3);

figure,
subplot(131);
imagesc(R),title('R');
subplot(132);
imagesc(G),title('G');
subplot(133);
imagesc(B),title('B');

figure,
subplot(121);
imagesc(Cb),title('Cb');
subplot(122);
imagesc(Cr),title('Cr');

%% Insertion

img = imread('people.jpg');
fond = imread('metro.jpg');

[h,w,z] = size(img);
[h2,w2,z2] = size(fond);

R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);

ycbcr = rgb2ycbcr(img);

Cb = ycbcr(:,:,2);
Cr = ycbcr(:,:,3);

mask = zeros(h,w);

mask = Cb > 150;

final = img.*uint8(1-mask) + fond.*uint8(mask);

figure,
subplot(221)
imagesc(B),title('B');
subplot(222)
imagesc(Cb),title('CB');
subplot(223)
imagesc(mask),title('Mask');
subplot(224)
imagesc(final),title('Img_Finale');

%Ycbcr permet d'eliminer les couleurs parasite et d'obtenir une mask plus
%précis

%% Filtrage bilateral

%img = imread('cameraman.tif');
%img = imread('barbara_awgn_noise.png');
img = imread('face.png');
%img = imresize(img,1/4);
[h,w,z] = size(img);
%Parametres (a faire varier)

v_size = 5; 
sigma_s = 3; 
sigma_c = 1;
img_bf = double(img*0);
%final = zeros(h,w);
%Parcours de tous les pixels p de l’image
for i = 1:h
    i
    for j = 1:w
        sum_1 = 0;
        sum_2 = 0;
        %Selection d une fenetre (2*v size+1)x(2*v size+1) ajustee 
        for ii = max(i-v_size,1):min(i+v_size,h)
            for jj = max(j-v_size,1):min(j+v_size,w)
                ws = exp(-sqrt( (i-ii)^2 + (j-jj)^2 ) / (2*(sigma_s)^2));
                wc = exp(-sqrt(sum((img(i,j,:) - img(ii,jj,:)).^2))/(2*sigma_c^2));
                %autres possibilites
                %ws = exp(-(norm([i-ii, j-jj])/(2*(sigma_s)^2));
                % wc = exp(-norm(img(i,j,:) - img(ii,jj,:))/(2*sigma_c^2));
                w2 = ws.*wc;
                sum_1 = sum_1 + w2*double(img(ii,jj,:));
                sum_2 = sum_2 + w2;
            end
        end
        img_bf(i,j,:) = squeeze(sum_1/sum_2);
    end
end

img_bf = uint8(img_bf);

figure,
subplot(121)
imagesc(img),title('Sans_filtre');
subplot(122)
imagesc(img_bf),title('Avec_filtre');

%% Filtrage frequentiel
clear all
close all

img = imread('pise_ext.bmp');
[h,w,z] = size(img);

TF=log10(abs(fft2(img)));
fx=linspace(0,1-1/w,w);
fy=linspace(0,1-1/h,h);

figure, 
subplot(131)
imagesc(img),title('Img + bruit');
colormap(gray(256))

subplot(132)
imagesc(fx,fy,TF),title('TF');
colormap(jet(256))

fx=linspace(-0.5,0.5-1/w,w);
fy=linspace(-0.5,0.5-1/h,h);

subplot(133)
imagesc(fx,fy,fftshift(TF)),title('TF + Shift');
colormap(jet(256))

%Debruitage de l image

h1 = fspecial('average');
h2 = fspecial('disk');
h3 = fspecial('gaussian');

average = conv2(img, h1, 'same');
TFaverage = fftshift(log10(abs(fft2(average))));

disk = conv2(img, h2, 'same');
TFdisk = fftshift(log10(abs(fft2(disk))));

gaussian = conv2(img, h3, 'same');
TFgaussian = fftshift(log10(abs(fft2(gaussian))));

figure, 
subplot(231)
imagesc(average),title('Img fAverage');
colormap(gray(256))

subplot(232)
imagesc(disk),title('Img fDisk');
colormap(gray(256))

subplot(233)
imagesc(gaussian),title('Img fGaussian');
colormap(gray(256))

subplot(234)
imagesc(fx,fy,TFaverage),title('Img fAverage');
colormap(gray(256))

subplot(235)
imagesc(fx,fy,TFdisk),title('Img fDisk');
colormap(gray(256))

subplot(236)
imagesc(fx,fy,TFgaussian),title('Img fGaussian');
colormap(gray(256))

%Creation du filtre

size = 10;
sigma = 3;
[X, Y] = meshgrid(-size:size, -size:size);
f_x = 0.25;
f_y = -0.25;

%Etape 1

g = 1/(2*pi*sigma^2)*(exp(-(X.^2+Y.^2)/(2*sigma^2)));
G = abs(fftshift(fft2(g)));

figure,
subplot(121)
surf(g),title('g');
subplot(122)
surf(G),title('G');

%Etape 2

A = 2*cos(2*pi*(f_x.*X + f_y.*Y));

gpb = g.*A;
Gpb = abs(fftshift(fft2(gpb)));

figure,
subplot(121)
surf(gpb),title('gpb');
subplot(122)
surf(Gpb),title('Gpb');

%Etape 3

dirac = zeros(21,21);
dirac(11,11) = 1;

gcb = dirac - gpb;
Gcb = abs(fftshift(fft2(gcb)));

figure,
subplot(131)
surf(gcb),title('gcb');
subplot(132)
surf(Gcb),title('Gcb');
subplot(133)
surf(dirac),title('Dirac');

final = conv2(img,gcb,'same');

figure, 
subplot(121)
imagesc(img),title('Bruit');
subplot(122)
imagesc(final),title('Sans bruit');
colormap(gray(256));

%condition de non repliement : 3/sigma < sqrt(fx^2 + fy^2) (visible en
%faisant un graphe fx en abcsisse et fy en ordonné, on place f_x et f_y
%avec un cerle de rayon 3/sugma autour et on compare la distance des
%deux point pour que les deux cercle ne se croisent pas == recouvrement) 

%% Rotation d une image

theta = pi/4;

img = imread('cameraman.tif');
[h,w] = size(img);

[X Y] = meshgrid(1:w,1:h);

R = [cos(theta) -sin(theta); cos(theta) sin(theta)];

X2 = cos(theta).*(X-w/2) - sin(theta).*(Y-h/2);
Y2 = sin(theta).*(X-w/2) + cos(theta).*(Y-h/2);

X2 = X2 + w/2;
Y2 = Y2 + h/2;

img_f = interp2(double(img),X2,Y2);

figure,
subplot(121)
imagesc(img),title('Sans rotation');
subplot(122)
imagesc(img_f),title('Avec rotation');
colormap(gray(256));