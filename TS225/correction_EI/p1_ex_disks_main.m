%% "Vraies" couleurs

clear all
close all
clc

size=255;
radius=70;
dist=45;

[R,G,B] = p1_ex_disks(size,radius,dist);
img = uint8(cat(3,R,G,B)*255); %Image 3D c=3 = Image RGB

figure, 
imagesc(img)
title('Vraies couleurs');
pause(1)

%% Couleurs indexées

img = uint8(R+2*G+4*B); %Chaque intersection a une intensité unique

map=[0 0 0;1 0 0;0 1 0;1 1 0;0 0 1;1 0 1;0 1 1;1 1 1];

figure, 
imagesc(img)
title('Palette par défaut, couleurs indéxées');
pause(1)

figure, imagesc(img)
colormap(map)
title('Couleurs indexées avec palette personnalisée');
