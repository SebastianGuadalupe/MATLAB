clc
close all
clear
h1 = 7.3/1000;
h2 = 23.3/1000;
R1 = 32.80/1000;
R2 = 24.45/1000;
r1 = 6.4/1000;
r2 = 6.9/1000;
m = 0.588; %masa varilla
M1 = 0.475; %masa masa 1
M2 = 0.862; %masa masa 2
l = 0.698; % largo varilla
Peri1 = [1.50360619283165,1.44540324829781,1.38786028043612,1.33445848987985,1.28779625757813,1.25109150142319,1.23040404991227,1.23017984784604,1.26159481378282,1.33629526773565];
Peri2 = [1.54356789217896,1.47278080168339,1.40351584176089,1.33690269049066,1.27395609380211,1.21899279965426,1.17988642135923,1.16568165544393,1.19696383682901,1.29711353112018];
P1 = [0.00365 + (0.069 .* [1:9])];
P1 = fliplr(P1);
P1 = [P1, 0.012];
P1teo = linspace(0,0.7,10000);
Periteo1  = 2*pi*sqrt((2*(m*l^2+3*M1.*P1teo.^2))./(3*9.8*(m*l + 2*M1.*P1teo)));%Considerando Masa como Puntual
P2 = [0.01165 + (0.069 .* [1:9])];
P2 = fliplr(P2);
P2 = [P2,0.01995];
P2teo = linspace(0,0.7,10000);
Periteo2  = 2*pi*sqrt((2*(m*l^2+3*M2.*P2teo.^2))./(3*9.8*(m*l + 2*M2.*P2teo)));%Considerando Masa como Puntual
subplot(1,2,1)
plot(P1,Peri1,'d -');
hold on
plot(P1teo,Periteo1, 'r');
title('Per�odo(X)Masa 1 te�rico y pr�ctico');
subplot(1,2,2)
plot(P2,Peri2,'d -');
hold on
plot(P2teo,Periteo2,'r');
title('Per�odo(X)Masa 2 te�rico y pr�ctico');
figure
plot(P1,Peri1);
hold on
plot(P1teo,Periteo1, 'r');
title('Per�odo(X)Masa 1 y 2')
plot(P2,Peri2,'y');
hold on
plot(P2teo,Periteo2,'g')
[f1, ~, ~, ~] = fit(P1, Peri1,'smoothingspline');
%plot(f1,P1,Periteo1)
Periteofinal1 = 2*pi*sqrt((4*m*l^2+3*M1*(r1^2+R1^2+2*(h1^2)+12*M1.*(P1teo.^2)))./(6*9.8*(m*l+2*M1.*P1teo)));%ahora es de enserio.
Periteofinal2 = 2*pi*sqrt((4*m*l^2+3*M2*(r2^2+R2^2+2*(h2^2)+12*M2.*(P2teo.^2)))./(6*9.8*(m*l+2*M2.*P2teo)));
figure
subplot(1,2,1)
plot(P1teo,Periteofinal1,'r')
hold on
plot(P1,Peri1,'b')
subplot(1,2,2)
plot(P2teo,Periteofinal2,'r')
hold on
plot(P2,Peri2,'b')



figure
plot(f1,P1,Periteo1)
%hold on
%plot(P1,Peri1,'-k');
