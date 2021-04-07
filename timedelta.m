function [dL,dR] = timedelta(p0,p0l,p0r,v)

%	TIMEDELTA oblicza roznice czasu jaka doswiadczaja uszy wzgledem srodka glowy (punktu (0,0)).
%	Roznice czasu sa uzaleznione od trajektorii zrodla dzwieku.
%
%	p0 - trejektoria
%	p0l - polozenie lewego ucha
%	p0r - polozenie prawego ucha
%	v - predkosc dzwieku w metrach na sekunde
%
%	dL - wektor roznic czasowych dla lewego ucha
%	dR - wektor roznic czasowych dla prawego ucha


    pl = zeros(2,length(p0));
    pr = zeros(2,length(p0));
    p0MOD = zeros(1,length(p0));
    plMOD = zeros(1,length(p0));
    prMOD = zeros(1,length(p0));
    dL = zeros(1,length(p0));
    dR = zeros(1,length(p0));

    for m=1:length(p0)
        pl(:,m) = p0(:,m) - p0l;
        pr(:,m) = p0(:,m) - p0r;

        plMOD(m) = norm(pl(:,m));
        prMOD(m) = norm(pr(:,m));
        p0MOD(m) = norm(p0(:,m));

        dL(m) = (p0MOD(m) - plMOD(m)) / v;
        dR(m) = (p0MOD(m) - prMOD(m)) / v;
    end

end