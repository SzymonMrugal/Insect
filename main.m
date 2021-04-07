
%	Program stwarza iluzje pouszania sie zrodla dzwieku 
%	wokol glowy uzytkownika. Sluchawki sa obowiazkowe!
%	
%	Autor: Szymon Mrugal
%	Ostatnio modyfikowane: 20.05.2018


fs = 48000;  % czestotliwosc probkowania dzwieku
d = 0.215;  % odleglosc miedzy uszami w metrach
v = 331.2;  % predkosc dzwieku w metrach na sekunde

audio = audioread('buzz.m4a');  % wczytanie dzwieku
y = audio(:,1)';  % wybranie jednego kanalu
y = y(1:300e3);
t = 1/fs : 1/fs : length(y)/fs;  % wektor czasu

% utworzenie trajektorii jako tablicy wektorów [x,y]
trajectory = [sin(t+deg2rad(90)); sin(t)]; 

plot(trajectory(1,:), trajectory(2,:))
xlim([-1,1]);
ylim([-1,1]);

% obliczenie dzwieku z dwoma kanalami o przesunietym czasie
[Y,dL,dR] = binaural(y,t,fs,4,trajectory,d,v); 

% wykres przesuniec dzwieku w czasie
figure(); 
subplot 211
plot(interp(t,4), dL); title('Ucho lewe');
subplot 212
plot(interp(t,4), dR); title('Ucho prawe');

% odtworzenie dzwieku
sound(Y, fs)  