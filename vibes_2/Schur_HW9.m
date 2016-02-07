%% HW 9 MAE 6258
%Randy Schur
%4/1/15

%% Problem 1
clear 
close all

S0= .004;
m = 9000;
k = 45000;
zeta = 0.2;
wn = sqrt(k/m);
c = zeta*2*m*wn;

In = pi/m*(S0/c)*(k*m + c^2);
N = 10000;
dt = .005;
t = linspace(0, (N-1)*dt, N);

G = tf([-c -k], [m c k]);
n = 100;
w = zeros(n, N);

for i=1:n
    y = randn(N,1)*sqrt(2*pi*S0/dt);
    w(i,:) = lsim(G, y, t);    
end

w2_avg = mean(w.^2);
plot(t, w2_avg)
hold on
plot(t, In, 'r:')
xlabel('time (s)')
ylabel('x^2')
legend('Simulated Value', 'Theoretical Value')
title('Mean Square Value of Displacement')


