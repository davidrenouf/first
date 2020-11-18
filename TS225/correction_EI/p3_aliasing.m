clear; close all; clc;


im = double(imread('../img/barbara.bmp'))/255;


figure(1),
imshow(im);
title('image originale');

facteur = 3;
im_sousech = im(1:facteur:end,1:facteur:end,:);

figure(2);
hAxes1=subplot(131);
imshow(im_sousech);
title('im sous éch');


sigma = 2.5;
Hf = 20;
Wf = Hf;
[X,Y] = meshgrid(-Wf/2:Wf/2,-Hf/2:Hf/2);
G = exp(-(0.5/(sigma^2))*(X.^2+Y.^2));
G = G/sum(sum(G));

figure(3);

mod_tf_im = fftshift(log10(abs(fft2(im(:,:,1)))));
[h,w] = size(mod_tf_im);
fx=linspace(-0.5,0.5-1/w,w);
fy=linspace(-0.5,0.5-1/h,h);
subplot(232);
imagesc(fx,fy,mod_tf_im);
title('log TF im');


mod_tf_G = fftshift(abs(fft2(G)));
[h,w] = size(mod_tf_G);
fx=linspace(-0.5,0.5-1/w,w);
fy=linspace(-0.5,0.5-1/h,h);
subplot(231);
imagesc(fx,fy,mod_tf_G);
title('TF G');

im_passebas = convn(im, G, 'same');

im_passebas_sousech = im_passebas(1:facteur:end,1:facteur:end,:);


mod_tf_im_passebas = fftshift(log10(abs(fft2(im_passebas(:,:,1)))));
[h,w] = size(mod_tf_im_passebas);
fx=linspace(-0.5,0.5-1/w,w);
fy=linspace(-0.5,0.5-1/h,h);
subplot(233);
imagesc(fx,fy,mod_tf_im_passebas);
title('log TF im passe-bas');

mod_tf_im_sousech = fftshift(log10(abs(fft2(im_sousech(:,:,1)))));
[h,w] = size(mod_tf_im_sousech);
fx=linspace(-0.5,0.5-1/w,w);
fy=linspace(-0.5,0.5-1/h,h);
subplot(234);
imagesc(fx,fy,mod_tf_im_sousech);
title('log TF im sous-éch');

mod_tf_im_passebas_sousech = fftshift(log10(abs(fft2(im_passebas_sousech(:,:,1)))));
[h,w] = size(mod_tf_im_passebas_sousech);
fx=linspace(-0.5,0.5-1/w,w);
fy=linspace(-0.5,0.5-1/h,h);
subplot(235);
imagesc(fx,fy,mod_tf_im_passebas_sousech);
title('log TF im passe-bas sous-éch');

figure(2);
hAxes2=subplot(132);
imshow(im_passebas_sousech);
title('im passe-bas + sous éch');


im_imresize = imresize(im_passebas,1/facteur);
hAxes3=subplot(133);
imshow(im_imresize);
title('fonction imresize');

linkaxes([hAxes1,hAxes2,hAxes3], 'xy');

figure(3);
mod_tf_im_imresize = fftshift(log10(abs(fft2(im_imresize(:,:,1)))));
[h,w] = size(mod_tf_im_imresize);
fx=linspace(-0.5,0.5-1/w,w);
fy=linspace(-0.5,0.5-1/h,h);
subplot(236);
imagesc(fx,fy,mod_tf_im_imresize);
title('log TF im imresize');
