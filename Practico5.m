close all
clear
clc
M = 0.0587; dM = 0.00589; % Masa de la varilla.
m = 0.0475; dm = 0.00477; %Masa de la masa.
R = 0.03280/2; dR = 0.00005; %Radio externo de la masa.
r = 0.00640/2; dr = dR; % Radio interno de la masa.
h = 0.00730; dh = dR; %Espesor de la masa.
l = 0.685; dl = 0.001; %Largo desde eje hasta extremo.
d = 0.564; dd = 0.001; %Distancia eje masa.
frect1 = 4.60202390394252; %Frecuencia del movimiento en el primer evento.(Extra�do de "tratamientoDeDatos.m")
Perit1 = 1/frect1; %Per�odo del movimiento en el primer evento.
frect9 = 4.31915345141501; %Frecuencia del movimiento en el noveno evento.(Extra�do de "tratamientoDeDatos.m")
Perit9 = 1/frect9;%Per�odo del movimiento en el noveno evento.
for i= 1:5
    Datos = load([num2str(i),'.txt']);
    t = Datos(:,1);
    O = Datos(:,2);
    %figure
    O = detrend(O);
    %plot(t,O)
end

for i= 1:5
    Datos = load([num2str(i+5),'.txt']);
    t = Datos(:,1);
    O = Datos(:,2);
    %figure
    O = detrend(O);
    %plot(t,O)
end
%C�lculo de I Te�rico
Iteo1 = 1/3*M*l^2;%Monmento Inercial de la vara girando libremente por un extremo.
Iteop = m*d^2;
I_teo_puntual = Iteo1+Iteop;
Iteo2 = 1/4*m*(r^2+R^2)+1/12*m*h^2;%Monmento Inercial de la masa libremente por un extremo.
I_teo_final_cilindro = Iteo1 + Iteo2 + m * d^2;%Momento Inercial del sistema varilla-masa girando con eje en el extremo.
dIteo1 = 1/3*l^2*dM+2/3*M*l*dl;
dI_teo_puntual = dm*d^2+2*d*m*dd;
dI_teo_final_puntual = 1/3*l^2*dM*2/3*M*l*dl+dm*d^2+2*d*m*dd;

%C�lculo de I experimental
Ipr1 = (M* 9.8* l)/(2* frect1^2);%Mediante la ecuaci�n 
Ipr9 = ((M * 9.8* l/2)+ (m*9.8*d))/(frect9^2);

Error_varilla = abs(Iteo1 - Ipr1)/Iteo1 * 100;
Error_cilindro = abs(I_teo_final_cilindro - Ipr9)/I_teo_final_cilindro * 100;
Error_puntual = abs(I_teo_puntual - Ipr9)/I_teo_puntual * 100;

