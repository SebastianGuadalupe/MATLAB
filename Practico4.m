clear
close all

mm = 0.6582;
dmm = 0.0133;
mh = 0.6569;
dmh = 0.0133;
rm = 0.0751; % radio madera
dr = 0.000005; % sigma radio de los dos
rh = 0.0755; % radio hueco
hi = 0.095;
dhi = 0.002;
senb=9.5/188.5; % seno del angulo de la mesa
dsenb = 0.001;
%tirada = load('tirada1.txt');
%tie = tirada(:, 1);
%xm = tirada(:, 2);%m de madera
%xh = tirada(:, 3);%h de hueco

for i = [2 3]
    tirada = load(['tirada', num2str(i), '.txt']);
    tie = tirada(:, 1);
    xm = tirada(:, 2);
    xh = tirada(:, 3);
    hm = hi-xm*senb;
    hh = hi-xh*senb;
    figure(1)
    subplot(1, 2, i-1)
    plot(tie, xm, '-r')
    title(['Posicion en funcion del tiempo en evento ', num2str(i-1)])
    ylabel('Posicion (m)'); xlabel('Tiempo (s)')
    hold on
    plot(tie, xh, '-b')
    tie = tirada(40:82, 1);
    xm = tirada(40:82, 2);
    xh = tirada(40:82, 3);
    
    
    a = polyfit(tie, xm, 2);
    plot(tie, a(1)*tie.^2+a(2)*tie+a(3), '-g', 'LineWidth', 2)
    b = polyfit(tie, xh, 2);
    plot(tie, b(1)*tie.^2+b(2)*tie+b(3), '-y', 'LineWidth', 2)
    [coefM, errorM] = errormc(tie,xm,2);
    [coefH, errorH] = errormc(tie,xh,2);
    acm(i)=coefM(1)*2; %aceleracion de centro de masa madera
    ach(i)=coefH(1)*2; %aceleracion de centro de masa hueco
    dacm(i) = errorM(1)*2;
    dach(i) = errorH(1)*2;
    g=9.8; % gravedad
    dg = 0.2;
    Km(i) = ((g*senb)/acm(i))-1; % constante del momento de inercia del cilindro de madera
    Kh(i) = ((g*senb)/ach(i))-1; % constante del momento de inercia del cilindro hueco[0,0.552285462066978,0.530629293961028], [0,0.900119702412914,1.039897232823813]
    dKm(i) = abs(senb/acm(i))*dg + abs(sqrt(1-senb^2)*g/acm(i))*dsenb + abs(senb)*dacm(i);
    dKh(i) = abs(senb/ach(i))*dg + abs(sqrt(1-senb^2)*g/ach(i))*dsenb + abs(senb)*dach(i);
    Ekm(i, :) = 1/2*mm*(acm(i)*tie).^2;
    Ekh(i, :) = 1/2*mh*(ach(i)*tie).^2;
    figure(2)
    subplot(1, 2, i-1)
    plot(tie, Ekm(i, :), '-r')
    title(['Energia cinetica de traslacion centro de masa en evento ', num2str(i-1)])
    ylabel('Enercia cinetica (J)'); xlabel('Tiempo (s)')
    hold on
    plot(tie, Ekh(i, :), '-b')
    Vcm(i, :) = coefM(2) + acm(i)*tie;
    Vch(i, :) = coefH(2) + ach(i)*tie;
    Etm(i, :) = 1/2*(1+Km(i))*Vcm(i, :).^2;
    Eth(i, :) = 1/2*(1+Kh(i))*Vch(i, :).^2;
    figure(3)
    subplot(1, 2, i-1)
    plot(tie, Etm(i, :), '-r')
    title(['Energia cinetica total en evento ', num2str(i-1)])
    ylabel('Energia cinetica (J)'); xlabel('Tiempo (s)')
    hold on
    plot(tie, Eth(i, :), '-b')
    Ugm(i, :) = mm*g*hm(i);
    Ugh(i, :) = mh*g*hh(i);
    figure(4)
    subplot(1, 2, i-1)
    plot(tie, Etm(i, :)+Ugm(i, :), '-r')
    title(['Energia total en evento ', num2str(i-1)])
    ylabel('Energia (J)'); xlabel('Tiempo (s)')
    hold on
    plot(tie, Eth(i, :)+Ugh(i, :), '-b')
end


% tirada = load('tirada10.txt');
% tie = tirada(:, 1);
% xm = tirada(:, 2);
% xh = tirada(:, 3);
% plot(tie, xm, '-r')
% hold on
% plot(tie, xh, '-b')
% tie = tirada(67:82, 1);
% xm = tirada(67:82, 2);
% xh = tirada(67:82, 3);


%plot(tie(i), xm(i), '-r')
%hold on
%plot(tie(i), xh(i), '-b')
%tie(i) = tie(i)(67:99);
%xm(i) = xm(i)(67:99);
%xh(i) = xh(i)(67:99);
%plot(tie, xm)


% a = polyfit(tie, xm, 2);
% plot(tie, a(1)*tie.^2+a(2)*tie+a(3), '-g')
% b = polyfit(tie, xh, 2);
% plot(tie, b(1)*tie.^2+b(2)*tie+b(3), '-y')
% [coefM, errorM] = errormc(tie,xm,2);
% [coefH, errorH] = errormc(tie,xh,2);
% acm=coefM(1)*2; %aceleracion de centro de masa madera
% ach=coefH(1)*2; %aceleracion de centro de masa hueco
% dacm = errorM(1)*2;
% dach = errorH(1)*2;
% senb=9.5/188.5; % seno del angulo de la mesa
% dsenb = 0.001;
% g=9.8; % gravedad
% dg = 0.2;
% Km= ((g*senb)/acm)-1; % energia cinetica madera
% Kh= ((g*senb)/ach)-1; % energia cinetica hueco
% dKm = abs(senb/acm)*dg + abs(sqrt(1-senb^2)*g/acm)*dsenb + abs(senb)*dacm;
% dKh = abs(senb/ach)*dg + abs(sqrt(1-senb^2)*g/ach)*dsenb + abs(senb)*dach;
% 
% Ekm = 1/2*mm*(acm*tie).^2;
% Ekh = 1/2*mh*(ach*tie).^2;
% figure
% plot(tie, Ekm, '-r')
% title('Energia cinetica de traslacion centro de masa')
% hold on
% plot(tie, Ekh, '-b')
% 
% Frm = mm*g*senb - mm*acm;
% Frh = mh*g*senb - mh*ach;
% alfam = rm/acm;
% alfah = rh/ach;
% Icm = Frm*rm/alfam;
% Ich = Frh*rh/alfah;
% Khd = 1/2*(1+rh/0.0709);

