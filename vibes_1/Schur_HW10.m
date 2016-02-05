%% MAE6257 HW10
%Randy Schur

%% Problem 3
clear
clc
close all
spd = 100*pi;
rho = 7870;
E = 200*10^9;
b = .01;
h =.01;
A = b*h;
I = b*h^3/12;
l =2;
zeta = .05;
f0 = 5500;
x = linspace(0, l, 1000);
for j=1:5
   beta = j*pi/(2*l);
   c2 = (sin(beta*l)+sinh(beta*l))/(cos(beta*l) + cosh(beta*l));
   c3 = -1;
   c4 = -c2;
   w(j) = sqrt((j*pi)^4/(2*l)^4*E*I/(rho*A));
   phi(j,:) = sin(beta*x)+c2*cos(beta*x)+c3*sinh(beta*x) + c4*cosh(beta*x);
end
% a
natural_frequencies = w %natural frequencies
plot(x, phi)
title('mode shapes')
xlabel('position (m)')
ylabel('relative deflection')
% b
t = linspace(0, 10, 1000);
for j=1:5
   s = 1i*w(j);
   G = spd/(s^2 + spd^2)*1/(s^2 +2*zeta*w(j)*s+w(j)^2);
   mag = abs(G);
   ang = angle(G);
   a(j,:) = mag*cos(spd*t + ang);
end
defl = a.*phi;
figure
plot(t, defl)
title('Steady State response of first 5 modes')
legend('mode 1', 'mode 2', 'mode 3', 'mode 4', 'mode 5')
xlabel('time (s)')
ylabel('Amplitude (m)')
