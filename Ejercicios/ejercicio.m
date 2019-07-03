clear; close all; clc
h = 4000; % altura en metros
g=9.81; % gravedad en m/s^2
paire = 1.22; % densidad del aire en kg/m^3
phielo = 917; % densidad del hielo en kg/m^3

% partes a) y b)
% modelo sin resistencia del aire
tf_R0 = sqrt(2*h/g);
t_R0 = 0:0.1:tf_R0;
x_R0 = h - (g*t_R0.^2)/2;
plot(t_R0, x_R0, '-r')
title('Posicion de la bola de granizo en funcion del tiempo')
ylabel('Posicion (m)'); xlabel('Tiempo (s)')
v_R0 = -g.*t_R0/2;
a_R0 = diff(v_R0)./diff(t_R0);
figure
plot(t_R0, v_R0, '-r')
title('Velocidad de la bola de granizo en funcion del tiempo')
ylabel('Velocidad (m/s)'); xlabel('Tiempo (s)')

% partes c), d) y e)
d = load('modeloR1.txt'); x_R1 = d(:, 2); t_R1 = d(:, 1);
figure(1)
hold on
plot(t_R1, x_R1, '-b')
v_R1 = diff(x_R1)./diff(t_R1);
a_R1 = diff(v_R1)./diff(t_R1(1:end-1));
figure(2)
hold on
plot(t_R1(1:end-1), v_R1, '-b')
figure(3)
title('Aceleracion de la bola de granizo en funcion del tiempo')
ylabel('Aceleracion (m/s^2)'); xlabel('Tiempo (s)')
hold on
plot(t_R1(1:end-2), a_R1, '-b')
pf1 = polyfit(v_R1(1:end-1), a_R1, 1);
k1 = -pf1(1);

% parte f)
d = load('modeloR2.txt'); x_R2 = d(:, 2); t_R2 = d(:, 1); clear d
figure(1)
hold on
plot(t_R2, x_R2, '-g')
legend('Modelo sin resistencia del aire', 'Modelo 1', 'Modelo 2')
v_R2 = diff(x_R2)./diff(t_R2);
a_R2 = diff(v_R2)./diff(t_R2(1:end-1));
figure(2)
hold on
plot(t_R2(1:end-1), v_R2, '-g')
legend('Modelo sin resistencia del aire', 'Modelo 1', 'Modelo 2')
figure(3)
hold on
plot(t_R2(1:end-2), a_R2, '-g')legend('Modelo 1', 'Modelo 2')
pf2 = polyfit(v_R2(1:end-1), a_R2, 2);
k2 = -pf2(1);
D = 2*k2/paire;



close all