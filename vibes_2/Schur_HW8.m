% first_order_white_noise.m

clc;
clear all;
close all;

% create linear system
a = 2*pi;
G = tf(.2,[1 a]);

% create Gaussian white noise input
dt = .01;
N = 10000;
t = linspace(0,(N-1)*dt,N);
for k = 1:20

u = randn(N,1)*2*pi*sqrt(2*pi/dt);

% plot S_uu
R_uu = xcorr(u,'unbiased');
S_uu = fftshift(fft(R_uu));
% Eu2 = R_uu(N)
% Eu2a = mean(u.^2)
% Eu2b = mean(abs(S_uu)) 
% w = linspace(-pi/dt,pi/dt,2*N-1);
% ind = w > 0;

% figure;
% semilogx(w(ind),20*log10(abs(S_uu(ind))));
% ylabel('S_{uu}(\omega)');
% xlabel('\omega, rad/s');

% simulate system with input u, plot input vs. output
y = lsim(G,u,t);

Ey2a(:, k) = y.^2; 
    
end
figure
Ey2_mean = mean(Ey2a');
plot(t, Ey2_mean)
theory = 1 - exp(-4/25*pi*t);
hold on
plot(t, theory, 'r', 'LineWidth', 2)

mean(S_uu)
title('E[\omega^2(t)]')
xlabel('t')
ylabel('Expected value')
legend('calculated', 'theoretical')
