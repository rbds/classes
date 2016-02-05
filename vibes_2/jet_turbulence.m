% jet_turbulence.m

clc;
clear all;
close all;

% create Gaussian white noise input
dt = .01;
N = 500000;
t = linspace(0,(N-1)*dt,N);
u = randn(N,1)*sqrt(2*pi/dt);

% filter the noise to create Dryden turbulence
sig_wg = 20;
L = 1750;
V = 778;
G_Dryd = 20*sqrt(L/(pi*V))*tf([sqrt(3)*L/V 1],[(L/V)^2 2*L/V 1]);
bode(G_Dryd);
w_g = lsim(G_Dryd,u,t);
figure;
h1 = subplot(2,1,1);
plot(t,u);
ylabel('u(t)');
xlabel('t, s');
h2 = subplot(2,1,2);
plot(t,w_g);
ylabel('w_g(t)');
xlabel('t, s');
linkaxes([h1 h2],'x');

% plot S_uu and S_wgwg
R_uu = xcorr(u,'unbiased');
S_uu = fftshift(fft(R_uu));
R_wgwg = xcorr(w_g,'unbiased');
S_wgwg = fftshift(fft(R_wgwg));
w = linspace(-pi/dt,pi/dt,2*N-1);
ind = w > 0;
figure;
semilogx(w(ind),20*log10(abs(S_uu(ind))));
hold on;
semilogx(w(ind),20*log10(abs(S_wgwg(ind))),'r');

% simulate system with input w_g, plot input vs. output
G = tf([-1.33 -2.05 0],[1 2.87 14.5]);
n_z = lsim(G,w_g,t);
figure;
h1 = subplot(2,1,1);
plot(t,w_g);
ylabel('w_g(t)');
xlabel('t, s');
h2 = subplot(2,1,2);
plot(t,n_z);
ylabel('n_z(t)');
xlabel('t, s');
linkaxes([h1 h2],'x');

% plot S_nznz from simulation output
R_nznz = xcorr(n_z,'unbiased');
S_nznz = fftshift(fft(R_nznz));
figure;
semilogx(w(ind),20*log10(abs(S_nznz(ind))));
ylabel('S_{n_zn_z}(\omega), dB');
xlabel('\omega, rad/s');

% plot S_nznz from theory
[mag,phs] = bode(G,w);
S_nznz_theory = squeeze(mag).^2.*S_wgwg;
hold on;
semilogx(w(ind),20*log10(abs(S_nznz_theory(ind))),'r');
figure;
semilogx(w(ind),20*log10(squeeze(mag(ind))));

% mean-square of output
Enz2 = R_nznz(N)
Enz2a = mean(n_z.^2)
N = [301 735 50 0; -1 17.3 2.9 0; 0 -3.77 13.6 0; 0 1 -17.3 2.9];
D = N;
D(1,:) = [3.77 -13.6 0 0];
Enz2_theory = pi*det(N)/det(D)