%% MAE 6258 HW8
%Randy Schur
%3.25.15

clc;
clear all;
close all;

% create linear system
a = [1 2*pi];
G = tf(.2,[a]);

% create Gaussian white noise input
dt = .001;
N = 2500;
t = linspace(0,(N-1)*dt,N);

for k = 1:2000
u = 2*pi*randn(N,1)*sqrt(2*pi/dt);
R_uu = xcorr(u,'unbiased');
S_uu = fftshift(fft(R_uu));
w = linspace(-pi/dt,pi/dt,2*N-1);
ind = w > 0;
% simulate system with input u, plot input vs. output
y = lsim(G,u,t);
Ey2a(:, k) = y.^2; 
end

figure
Ey2_mean = mean(Ey2a');
plot(t, Ey2_mean)
theory = 1-exp(-4*pi*t);
Ey2_theory = pi./a;
hold on
plot(t, theory, 'r', 'LineWidth',2)
mean(S_uu)

axis([0 2.5 0 1.5])
title('E[\omega^2(t)]')
xlabel('t')
ylabel('Expected Value')
legend('calculated', 'theoretical')
