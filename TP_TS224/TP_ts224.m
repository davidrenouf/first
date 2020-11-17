%David Renouf TS224%
clear;
close;
clc;

%% Variables
N = 512;
f = -1/2:1/N:1/2-1/N;

%% Cas general
R = 0.95;       %module
th = pi/3;      %argument

p1 = R*exp(1i*th);
p2 = R*exp(-1i*th);

a1 = -(p1 + p2);
a2 = p1.*p2;

a = [1, a1, a2];

r = 0;      %module
th2 = 1;    %argument

z1 = r*exp(1i*th2);
z2 = r*exp(-1i*th2);

b1 = -(z1 + z2);
b2 = z1.*z2;

b = [1 b1 b2];

%% Variation de theta
R = 0.95;       %module
th = [ 0 , pi/3, pi/2, 3*pi/2, pi ];  %liste argument

p1 = R*exp(1i*th);
p2 = R*exp(-1i*th);

a1 = -(p1 + p2);
a2 = p1.*p2;

a = [1, a1, a2];

r = 0;      %module 
th2 = 1;    %arg

z1 = r*exp(1i*th2);
z2 = r*exp(-1i*th2);

b1 = -(z1 + z2);
b2 = z1.*z2;

b = [1 b1 b2];

%% variations de R
R = 0.05:0.1:0.95;
th = pi/3;

p1 = R*exp(1i*th);
p2 = R*exp(-1i*th);

a1 = -(p1 + p2);
a2 = p1.*p2;

a = [ones(9,1); a1'; a2'];

r = 0;
th2 = 1;

z1 = r*exp(1i*th2);
z2 = r*exp(-1i*th2);

b1 = -(z1 + z2);
b2 = z1.*z2;

b = [1 b1 b2];

%% Etape 1

% Poles et zeros dans l espace
N = 512;
theta = -pi:2*pi/N:pi;
figure
% subplot 121;
% plot(cos(theta), sin(theta))  % representation du cercle unité
% hold on                       % valide la superposition des tracés
% plot(0,0,'+k')                % localisation de l’origine
% axis image                    % repère orthonormé
% plot(real(p1), imag(p1), '*r')
% plot(real(p2), imag(p2), '*r')
% plot(real(z1), imag(z1), 'ob')
% plot(real(z2), imag(z2), 'ob')
% 
% hold off

tab_R = {'0' ,  '0.3',  '0.5',  '0.75','0.99'};
array_r = [ 0 .3 .5 .75 .99]; 

for ii = 1:5
    R = array_r(ii);
    
    p1 = R*exp(1i*th);
    p2 = R*exp(-1i*th);
    
    a1 = -(p1 + p2);
    a2 = p1.*p2;
    
    subplot(3,2,ii)
    zplane(b, [1 a1 a2])
    title(["Localisation des poles et des zeros pour R valant" tab_R{ii}])
    
end

% Reponse en frequence

% h = freqz(b, a, 2*pi*f);
% figure
% subplot 211
% plot(f, abs(h))
% title("Reponse en frequence du module du filtre")
% 
% subplot 212
% plot(f, angle(h))
% title("Reponse en frequence de la phase du filtre")

for ii = 1:5
    R = array_r(ii);
    
    p1 = R*exp(1i*th);
    p2 = R*exp(-1i*th);
    
    a1 = -(p1 + p2);
    a2 = p1.*p2;
    
    h = freqz(b, [1 a1 a2], 2*pi*f);
    
    subplot(5,2,2*ii -1)
    plot(f, abs(h))
    title(["Reponse en frequence du module du filtre pour R =" tab_R{ii}])

    subplot(5,2,2*ii)
    plot(f, angle(h))
    title(["Reponse en frequence de la phase du filtre pour R =" tab_R{ii}])
    
end

%% Etape 2

sigma = 1;
sig = sigma*randn(1,512); 

sigFilt = filter(b,a,sig);

%rep tempo
figure,
subplot 211
plot(sig)
title("Signal non filtré")

subplot 212
plot(sigFilt)
title("Signal filtré")

%Spectre de puissance
spFig = fftshift(abs(fft(sig)))/N;

spFigFilt = fftshift(abs(fft(sigFilt)))/N;

figure,
subplot 211
plot(f, spFig)
title("Spectre de fréquence du bruit non filtré")
xlabel("Frequence f")
ylabel("Spectre de puissance")

subplot 212
plot(f, spFigFilt)
title("Spectre de fréquence du bruit non filtré")
xlabel("Frequence f")
ylabel("Spectre de puissance")

%% Etape 3 influence de theta

tab_Th = {'0',  'pi/3',  'pi/2',  '2pi/3','pi'};
Th = [0 pi/3 pi/2 2*pi/3 pi];

for ii = 1:5
    R = 0.95;
    th = Th(ii);
    
    p1 = R*exp(1i*th);
    p2 = R*exp(-1i*th);
    
    a1 = -(p1 + p2);
    a2 = p1.*p2;
    
    subplot(3,2,ii)
    zplane(b, [1 a1 a2])
    title(["Localisation des poles et des zeros pour th valant" tab_Th{ii}])
    
end

for ii = 1:5
    R = 0.2*(ii-1); %to correct later
    
    p1 = R*exp(1i*th);
    p2 = R*exp(-1i*th);
    
    a1 = -(p1 + p2);
    a2 = p1.*p2;
    
    h = freqz(b, [1 a1 a2], 2*pi*f);
    
    subplot(5,2,2*ii -1)
    plot(f, abs(h))
    title(["Reponse en frequence du module du filtre pour theta =" tab_Th{ii}])

    subplot(5,2,2*ii)
    plot(f, angle(h))
    title(["Reponse en frequence de la phase du filtre pour theta =" tab_Th{ii}])
end

%% Etape 4 influence de R
r = 0.95;
th = pi/3;
   
z1 = R*exp(1i*th);
z2 = R*exp(-1i*th);
    
b1 = -(z1 + z2);
b2 = z1*z2;
    
b = [1 b1 b2];
    
a = [1 0 0];

h = freqz(b, a, 2*pi*f);


figure
subplot 221
zplane(b, a)

subplot 222
plot(f, 20*log10(abs(h)))

subplot 223
plot(f, angle(h))

%%filtrage

sigma = 1;
sig = sigma*randn(1,512); 

sigFilt = filter(b,a,sig);

%temporel
% figure,
% subplot 211
% plot(sig)
% title("Signal non filtré")
% 
% subplot 212
% plot(sigFilt)
% title("Signal filtré")

%%Spectre de puissance
spFig = fftshift(abs(fft(sig)))/N;

spFigFilt = fftshift(abs(fft(sigFilt)))/N;

figure,
subplot 211
plot(f, spFig)
title("Spectre de fréquence du bruit non filtré")
xlabel("Frequence f")
ylabel("Spectre de puissance")

subplot 212
plot(f, spFigFilt)
title("Spectre de fréquence du bruit filtré")
xlabel("Frequence f")
ylabel("Spectre de puissance")


%% 1.5 Etape 1

th0 = pi/3;
R = 0.99;
r = 0.8;

%H1(z)
p1 = R*exp(1i*th0);
p2 = R*exp(-1i*th0);

a1 = -(p1 + p2);
a2 = p1*p2;

b = [1 0 0];
    
a = [1 a1 a2];

h1 = freqz(b, a, 2*pi*f);

%H2(z)
z1 = r*exp(1i*th0);
z2 = r*exp(-1i*th0);
    
b1 = -(z1 + z2);
b2 = z1*z2;
    
b = [1 b1 b2];
    
a = [1 0 0];

h2 = freqz(b, a, 2*pi*f);

%Figure

figure

plot(f,abs(h1)),title("Module H1(z)")
hold all;
plot(f,abs(h2)),title("Module H2(z)")

plot(f,abs(h1.*h2)),title("Module H(z)")

% Très séléctif.

%% 1.5 Etape 2

th0 = pi/3;
R = 0.9;
r = 0.99;

%H1(z)
p1 = R*exp(1i*th0);
p2 = R*exp(-1i*th0);

a1 = -(p1 + p2);
a2 = p1*p2;

b = [1 0 0];
    
a = [1 a1 a2];

h1 = freqz(b, a, 2*pi*f);

%H2(z)
z1 = r*exp(1i*th0);
z2 = r*exp(-1i*th0);
    
b1 = -(z1 + z2);
b2 = z1*z2;
    
b = [1 b1 b2];
    
a = [1 0 0];

h2 = freqz(b, a, 2*pi*f);

%Figure

figure

plot(f,abs(h1)),title("Module H1(z)")
hold all;
plot(f,abs(h2)),title("Module H2(z)")

plot(f,abs(h1.*h2)),title("Module H(z)")

% Beaucoup moins séléctif.

%% 1.6


% Préliminaires
T = 0.4;
fech = 8*10^3;
Nb = 3200;
len = 11;

fnote = [261.6, 293.7, 329.7, 349.2, 392, 440, 493.9];

bg = rand(1,Nb);

for ii = fnote

th0 = 2*pi*ii/fech;
R = 0.99;
r = 0.8;

%H(z)
p1 = R*exp(1i*th0);
p2 = R*exp(-1i*th0);

a1 = -(p1 + p2);
a2 = p1*p2;

b = [1 0 0];
    
a = [1 a1 a2];

h1 = freqz(b, a, 2*pi*f);

y = filter(b,a,bg);

end

%soundsc(vect,fech);

%Partition

partition = [ 1 1 1 2 3 2 1 3 2 2 1 ;
            1 1 1 1 2 2 1 1 1 1 1.5 ];
        
for ii = 1:len

R = 0.99;
r = 0.8;
%th0 = 2*pi*fnote(partition(1,:ii))/fech;
bg = rand(1,Nb*partition(2,ii));

%H(z)
p1 = R*exp(1i*th0);
p2 = R*exp(-1i*th0);

a1 = -(p1 + p2);
a2 = p1*p2;

b = [1 0 0];
    
a = [1 a1 a2];

h1 = freqz(b, a, 2*pi*f);

y = filter(b,a,bg);

vect = [vect,y];
end

%soundsc(vect,fech);

%% 2.2 considération th

A = load('/net/t/drenouf/Documents/first/TP_TS224/signal_radar_config1.mat');

dt = 10*10^(-6);
fech = 200*10^6;

pas_x = 1/fech;
pas_y = dt/lenght;

t_x = 0:pas_x:dt-pas_x;

plot(








