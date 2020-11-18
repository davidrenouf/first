clear;
close;
clc;

%% Paramètres
img = imread('street.png');
r=img(:,:,1);
g=img(:,:,2);
b=img(:,:,3);
[h,w,z] = size(img);
figure, imshow(img);
H = 1/9.*ones(3,3);
R = 20;
inputs = 6;

%% Meshgrid
[X,Y] = meshgrid(1:w, 1:h);
[x , y]=ginput(inputs);
x = floor(x);
y = floor(y);

%% Flou

flou_r = uint8(conv2(img(:,:,1), H, 'same')); 
flou_g = uint8(conv2(img(:,:,2), H, 'same')); 
flou_b = uint8(conv2(img(:,:,3), H, 'same')); 
flou = cat(3,flou_r,flou_g,flou_b);

%% Masque
masque =  zeros(h,w);

for i = 1 : inputs
    masque = masque |((X-x(i)).^2 + (Y-y(i)).^2 <=R.^2);
end

masque_inv = uint8(~masque);

r=r.*masque_inv +floue_r.*uint8(masque);
g=g.*masque_inv +floue_g.*uint8(masque); %on floute les cercles 
b=b.*masque_inv +floue_b.*uint8(masque);

imagesc(cat(3,r,g,b)); 