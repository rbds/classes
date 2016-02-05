% first_order_white_noise.m

clc;
clear all;
close all;

% create linear system
a = 1;
G = tf(1,[1 a]);

% create Gaussian white noise input
dt = .01;
N = 100000;
t = linspace(0,(N-1)*dt,N);
u = randn(N,1)*sqrt(2*pi/dt);

% plot S_uu
R_uu = xcorr(u,'biased');
S_uu = fftshift(fft(R_uu));
Eu2 = R_uu(N)
Eu2a = mean(u.^2)
Eu2b = mean(abs(S_uu))
w = linspace(-pi/dt,pi/dt,2*N-1);
ind = w > 0;
figure;
semilogx(w(ind),20*log10(abs(S_uu(ind))));
ylabel('S_{uu}(\omega)');
xlabel('\omega, rad/s');

% simulate system with input u, plot input vs. output
y = lsim(G,u,t);
figure;
h1 = subplot(2,1,1);
plot(t,u);
ylabel('u(t)');
xlabel('t, s');
h2 = subplot(2,1,2);
plot(t,y);
ylabel('y(t)');
xlabel('t, s');
linkaxes([h1 h2],'x');

% plot S_yy from simulation output
R_yy = xcorr(y,'biased');
S_yy = fftshift(fft(R_yy));
figure;
semilogx(w(ind),20*log10(abs(S_yy(ind))));
ylabel('S_{yy}(\omega), dB');
xlabel('\omega, rad/s');

% plot S_yy from theory
[mag,phs] = bode(G,w);
S_yy_theory = squeeze(mag).^2.*S_uu;
hold on;
semilogx(w(ind),20*log10(abs(S_yy_theory(ind))),'r');
ylabel('S_{yy}(\omega), dB');
xlabel('\omega, rad/s');
legend('computed','theoretical');

% Bode magnitude plot of G
figure;
semilogx(w(ind),20*log10(squeeze(mag(ind))));
ylabel('|G(i\omega)|, dB');
xlabel('\omega, rad/s');

% mean-square of output
Ey2 = R_yy(N)
Ey2a = mean(y.^2)
Ey2_theory = pi/a
