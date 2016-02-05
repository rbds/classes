%% MAE 6258 HW11
%Randy Schur
%4/15/15
%Adapted from yield_failure.m

clc
clear
close all

% create linear system
m = 5;
c = .1;
wn = 1*2*pi;                             % natural frequency
k = wn.^2*m;
G = tf(1,[m c k]);

zeta = c/(2*sqrt(m*k))                     % damping ratio
Tc = 1/(wn*zeta);                           % time constant of transients

% create Gaussian white noise input
dt = .01;
N = 500000;
t = linspace(0,(N-1)*dt,N);
S0 = 1;
u = randn(N,1)*sqrt(2*pi*S0/dt);

% simulate system with input u, plot input vs. output
y = lsim(G,u,t);
ind = (t > 5*Tc);			% trim transient response
t = t(ind);
t = t - t(1);
N = length(t);
u = u(ind);
y = y(ind);
% figure;
% h1 = subplot(2,1,1);
% plot(t,u);
% ylabel('u(t)');
% xlabel('t, s');
% h2 = subplot(2,1,2);
% plot(t,y);
% ylabel('y(t)');
% xlabel('t, s');
% linkaxes([h1 h2],'x');

% plot S_uu
R_uu = xcorr(u,'unbiased');
Eu2 = R_uu(N);
Eu2a = mean(u.^2);

% mean-square of output
R_yy = xcorr(y,'unbiased');
Ey2 = R_yy(N);
Ey2a = mean(y.^2);
Ey2_theory = pi/(c*k);

for k_std = 1:8
    

% failure estimates
% k_std = 3;                                  % # of standard deviations to failure
U = k_std*std(y);							% std(y) = sqrt(Ey2a)
Pf_Cheb = 1/k_std^2*(1+wn*t(end));
tf_Cheb = (k_std^2-1)/wn;
lam = wn/pi*exp(-k_std^2/2);
Pf_Pois = 1 - exp(-lam*t(end));
tf_Pois = 1/lam;

% find failure points
% figure;
% plot(t,y,t,U*ones(size(t)),'r--',t,-U*ones(size(t)),'r--');
% ind_f = (abs(y) >= U);
% tf_sim = t(find(ind_f,1))
% hold on;
% plot(t(ind_f),y(ind_f),'r*');

%calculate n_dot_plus(k*sigma_x)
[pks, locs] = findpeaks(y);
ind_fplus = (pks >= U);
pos_pks = find(ind_fplus>0);
n_dot_plus(k_std) = size(pos_pks,1)/t(end)
a_crosses = 0;
for count = 2:length(pos_pks)
    diff = pos_pks(count) - pos_pks(count-1);
    if diff >5
       a_crosses = a_crosses+1; 
    end
end
n_dot_plus_a(k_std) = a_crosses/t(end)

%theoretical values
n_dot_plus_theory(k_std) = 1*exp(-k_std^2/2)
sigma_x_sq = Ey2_theory;
K = 2*zeta*wn^3*sigma_x_sq/pi;
sigma_xdot_sq = pi*K/(2*zeta*wn^3)*((1+pi^2*zeta^2)/12);
sigma_1_sq = pi^3*zeta*K/(24*wn);

n_dot_plus_a_theory(k_std) = U*sqrt(sigma_1_sq)/(sqrt(2*pi)*sigma_x_sq)*exp(-U^2/(2*sigma_x_sq))

end
figure
plot(1:k_std, n_dot_plus, 1:k_std, n_dot_plus_theory)
hold on
plot(1:k_std, n_dot_plus_a, 'bo', 1:k_std, n_dot_plus_a_theory, 'ro')
legend( 'x(t) crossings', 'theoretical value', 'a(t) crossings', 'theoretical value')

