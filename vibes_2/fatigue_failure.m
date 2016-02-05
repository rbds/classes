% fatigue_failure.m

clc;
clear all;
close all;

% create linear system
m = 1;
c = .1;
k = 25;
G = tf(1,[m c k]);

% create Gaussian white noise input
dt = .01;
N = 500000;
t = linspace(0,(N-1)*dt,N);
S0 = 1;
u = randn(N,1)*sqrt(2*pi*S0/dt);

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
Ey2_theory = pi/(c*k)

% find (positive) peaks in y(t) and plot their magnitude distribution
[pks,locs] = findpeaks(y);
locs = locs(pks>0);
pks = pks(pks>0);
figure;
[nelements,centers] = hist(pks,50);
bar(centers,nelements/sum(nelements)/(centers(2)-centers(1)),'FaceColor',[.7 .7 1]);	% normalize histogram so its total area = 1

% add Rayleigh distribution curve
xlims = get(gca,'XLim');
x = linspace(xlims(1),xlims(2),101);
Ray_dist = (x/Ey2a).*exp(-x.^2/(2*Ey2a));
hold on;
plot(x,Ray_dist,'r--');
ylabel('Probability');
xlabel('Peak magnitude');

% plot accumulated damage
b = 0.25;
c = 10000;
D = cumsum(pks.^b)/c;
D_theory = (sqrt(k/m)/(2*pi*c)*sqrt(2*Ey2a)^b*gamma((b+2)/2))*t(locs);
t_L = 1/(sqrt(k/m)/(2*pi*c)*sqrt(2*Ey2a)^b*gamma((b+2)/2))
figure;
plot(t(locs),D,t(locs),D_theory,'r--');
ylabel('Damage');
xlabel('t, s');