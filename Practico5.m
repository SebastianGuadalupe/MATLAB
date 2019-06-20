close all; clear; clc
M = 0.0587; dM = 0.00589; % Masa de la varilla.
m = 0.0475; dm = 0.00477; %Masa de la masa.
R = 0.03280/2; dR = 0.00005; %Radio externo de la masa.
r = 0.00640/2; dr = dR; % Radio interno de la masa.
h = 0.00730; dh = dR; %Espesor de la masa.
l = 0.685; dl = 0.001; %Largo desde eje hasta extremo.
d = 0.564; dd = 0.001; %Distancia eje masa.
frect1 = 4.60202390394252; %Frecuencia del movimiento en el primer evento.(Extraido de "tratamientoDeDatos.m")
Perit1 = 2*pi/frect1; %Periodo del movimiento en el primer evento.
frect9 = 4.31915345141501; %Frecuencia del movimiento en el noveno evento.(Extraido de "tratamientoDeDatos.m")
Perit9 = 2*pi/frect9;%Periodo del movimiento en el noveno evento.
for i= 1:5
    Datos = load([num2str(i),'.txt']);
    t = Datos(:,1);
    O = Datos(:,2);
    O = detrend(O);
    %figure
    %plot(t,O)
end

for i= 1:5
    Datos = load([num2str(i+5),'.txt']);
    t = Datos(:,1);
    O = Datos(:,2);
    O = detrend(O);
    %figure
    %plot(t,O)
end

dcm = ((M * l/2) + (m * d)) / (m + M); % distancia del centro de masa luego de agregar la pesa

% Calculo de I Teorico
I_teo_varilla = 1/3 * M * l^2; % Monmento Inercial de la vara girando libremente por un extremo.
d_I_teo_varilla = (l^2*dM + M*dl)/3; % sigma momento inercial teorico de varilla
I_teo_cilindro = 1/4 * m * (r^2+R^2) + ((1 / 12) * m * h^2); % Monmento Inercial de la masa libremente por un extremo con modelo cilindrico.
I_teo_final_puntual = I_teo_varilla + m * d^2; % Momento Inercial del sistema varilla-masa girando con eje en el extremo usando modelo de masa puntual.
I_teo_final_cilindro = I_teo_varilla + I_teo_cilindro + m * d^2; % Momento Inercial del sistema varilla-masa girando con eje en el extremo usando modelo de masa cilindrica.

%Calculo de I experimental
I_pr_varilla = (M * 9.8 * l)/(2* frect1^2); % momento de inercia de la barilla experimental
I_pr_final = ((M+m) * 9.8 * l)/(2 * frect9^2);

Error_varilla = abs(I_teo_varilla - I_pr_varilla)/I_teo_varilla * 100;
Error_cilindro = abs(I_teo_final_cilindro - I_pr_final)/I_teo_final_cilindro * 100;
Error_puntual = abs(I_teo_final_puntual - I_pr_final)/I_teo_final_puntual * 100;



