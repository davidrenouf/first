clear all
close all
clc

%% %%%%%%%%%%% Format numérique %%%%%%%%%%%%%%%%%
s = load('../img/challenge.mat');
I = s.A; %Baboon

figure, imshow(I)
figure, imagesc(I)
%% RGB uint8 veut du [0,255], RGB double veut du [0,1]
% donc soit on repasse en uint8, soit on normalise pour être entre [0,1] 
figure, imshow(uint8(I)) 
figure, imshow(I/255)
figure, imagesc(uint8(I))
figure, imagesc(I/255)



%% %%%%%%%%%%% Ratio Largeur/Hauteur %%%%%%%%%%%%%%%%%
I = s.B; %Formula
figure, imagesc(I)
figure, imshow(I)
%%
figure, imagesc(I), 
axis image %Option qui permet de respecter les proportions
%s'applique au dernier affichage effectué


%% %%%%%%%%%%% Intervalles d'intensité %%%%%%%%%%%%%%%%%
I = s.C; %Radio
figure, imagesc(I)
figure, imagesc(I), colormap(gray(256))
figure, imagesc(I, [100 130]), colormap(gray(256))



%% %%%%%%%%%%% Palette continue %%%%%%%%%%%%%%%%%
I = s.D; %Chess
figure, imagesc(I), colormap(hsv(256)) %Pas trop adaptée
figure, imagesc(I), colormap(jet(256)) %Adaptée
figure, imagesc(I), colormap(flag(256)) %Pas adaptée



%% %%%%%%%%%%% Format numérique %%%%%%%%%%%%%%%%%
I = s.E; %World map
figure, imagesc(I)

%On crée une palette couleur manuellement qui map les intensités
% entre 0 et 7 sur ces triplets RGB
map = [1 1 1;1 0 0;0 1 0;0 0 1;1 1 0;1 0 1;0 1 1];
figure, imagesc(I), 
colormap(map)









