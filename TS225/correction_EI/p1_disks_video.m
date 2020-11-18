clear all
close all

size=255;
radius=70;
dist=45;

[R,G,B] = p1_ex_disks(size,radius,dist);

%Conversion au format uint8 [0, 255]
C1=uint8(R*255);
C2=uint8(G*255);
C3=uint8(B*255);

%Créer l'objet vidéo avec VideoWriter
% v = VideoWriter('disk.avi');  %Avec compression par défaut - 700Ko
v = VideoWriter('disk.avi','Uncompressed AVI'); %Sans compression - 19.7Mo

%Définir le frame rate (vitesse de lecture)
v.FrameRate = 5;

%Ouvrir de l'objet vidéo
open(v)
    
for n=1:100
    
    q=mod(n,3);
    
    switch q
        case 0  %C1=Rouge-C2=Vert-C3=Bleu
            img = cat(3,C1,C2,C3);
        case 1  %C3,C1,C2 (à compléter)
            img = cat(3,C3,C1,C2);
        case 2  %C2,C3,C1 (à compléter)
            img = cat(3,C2,C3,C1);
    end
    
    %Ajout du frame dans la vidéo
    writeVideo(v,img);
        
end
%Fermeture de l'objet vidéo
close(v)