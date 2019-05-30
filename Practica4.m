close all
clear
m1 = 0.3115;
dm1 = 0.0003;
m2 = 0.5015;
dm2 = 0.0007;
PEp = 0;


for i = 1:10
   d=load(['Prueba', num2str(i), '.txt']);
   xd = d(1:find(d(:, 2) == max(d(:, 2))), 2);
   tied = d(1:find(d(:, 2) == max(d(:, 2))), 1);
   plot(tied, xd)
   hold on
   
   xi = xd(xd > 0.25 & xd < 0.87);
   tiei = tied(xd > 0.25 & xd < 0.87);
   
   xf = xd(xd > 1);
   tief = tied(xd > 1);
   
   %Antes del choque
   [q,w] = errormc(tiei, xi, 1);
   Vi(i) = q(1); %Velocidad inicial
   DVi(i) = w(1); %Incertidumbre en velocidad inicial
   Pi(i) = Vi(i) * m1; %Cantidad de movimiento inicial
   DPi(i) = Pi(i)*(DVi(i)/Vi(i) + dm1/m1);
   %Despues del choque
   [q,w] = errormc(tief, xf, 1);
   Vf(i) = q(1); %Velocidad final
   DVf(i) = w(1); %Incertidumbre en velocidad final
   Pf(i) = Vf(i)*m2; %Cantidad de movimiento final
   DPf(i) = Pf(i)*(DVf(i)/Vf(i) + dm2/m2);
   Ep(i) = Pf(i)/Pi(i); %Epsilon
   DEp(i) = Ep(i)*(DPf(i)/Pf(i) + DPi(i)/Pi(i));
   IncEp(i) = sqrt(std(DEp(i))^2+(max(DEp(i))^2)); %Delta Epsilon

   RepVi(i) = DVi(i)/Vi(i).*100;
   RepVf(i) = DVf(i)/Vf(i).*100;
end

T = table(Vi', DVi', RepVi', Vf', DVf', RepVf', Pi', DPi', Pf', DPf', Ep', IncEp');





