function [Y,dL,dR] = binaural(y,t,samplerate,upsamp,trajectory,d,vdz)

%	BINAURAL tworzy nowy dzwiek dwukanalowy o przesunietym czasie w zaleznosci 
%	od trajektorii, tworzac iluzje poruszania sie dzwieku orygianlnego.
%
%	y - dzwiek
%	t - wektor czasu dzwieku oryginalnego
%	samplerate - czestotliwosc probkowania dzwieku
%	upsamp - stopien upsamplingu
%	trajectory - trajektoria zrodla dzwieku
%	d - odleglosc miedzy uszami w metrach
%	vdz - predkosc dzwieku
%
%	Y - dzwiek dwukanalowy o przesunietym czasie
%	dL - wektor przesuniec czasowych dla lewego ucha
%	dR - wektor przesuniec czasowych dla prawego ucha


if (length(trajectory(1,:)) ~= length(y))
    error('length(trajectory(1,:)) ~= length(y)')
end

% upsampling
y1 = interp(y,upsamp);

% obliczenie roznic czasowych miedzy punktem (0,0) a uszami
[dL,dR] = timedelta(trajectory,[-d/2;0],[d/2;0],vdz);

for m=1:length(dL)  % zaokraglenie do najblizszych probek po upsimpling
    dL(m) = dL(m) - ( mod(dL(m),1/(samplerate*upsamp)) );
    dR(m) = dR(m) - ( mod(dR(m),1/(samplerate*upsamp)) );
end

tL = t + dL;
tR = t + dR;

for m =1000:length(tL)-1000  % pierwsze probki moga miec ujemny indeks
    yL(m) = y1(round(tL(m)*samplerate*upsamp));
end
for m =1000:length(tR)-1000
    yR(m) = y1(round(tR(m)*samplerate*upsamp));
end

Y =[yL;yR];