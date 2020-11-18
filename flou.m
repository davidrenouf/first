clear;
close;
clc;

img = imread('barbara.bmp');

figure,
imagesc(img);

if(abs(x1-x2)>abs(y1-y2))
    
    p = img(y1,x1:x2);
    
else 
    
    p = img(y1:y2,x1);
    
end

plot(p);