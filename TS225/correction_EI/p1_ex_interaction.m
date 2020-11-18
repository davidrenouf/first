clear all
close all
clc

A=imread('../img/cameraman.tif'); %Image que Matlab connaît
A=imread('../img/pool.tif'); %Image que Matlab connaît
[h,w,c] = size(A);
figure, imshow(A)

[x,y] = ginput(2); %!! Renvoie des doubles parfois !!
x=round(x);
y=round(y);

if abs(x(2)-x(1))>abs(y(2)-y(1))
    profil = A(y(1),min(x):max(x),:);
    y(2) = y(1);
else
    profil = A(min(y):max(y),x(1),:);
    x(2) = x(1);
end
line(x,y) %Affiche un segment sur l'image

figure, hold on
if (c == 1) % Image intensité h*w
    plot(profil)
else % c == 3, Image RGB h*w*c
    plot(profil(:,:,1),'r')
    plot(profil(:,:,2),'g')
    plot(profil(:,:,3),'b')
end
xlabel('Segment');
ylabel('Intensité');


