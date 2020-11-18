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

