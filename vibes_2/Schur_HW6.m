clear 
close all

n_modes = 6; % number of modes to use in expansion
DVA_mode = 2; % mode to tune DVA to beam properties
L = 1; % length (m)
rhoA = 1; % mass/length (kg/m)
EI = 1; % bending stiffness (N-m^2)

% dimensionless frequencies (pinned-pinned):
lamda = pi*(1:n_modes)'; 
w_n = lamda.^2*sqrt(EI/(rhoA*L^4));% natural frequencies
w_a = w_n(2);
% modal damping
zeta = 0.00*ones(size(w_n));
% plot mode shapes
mode_fn ='ms_pinned_pinned';

% force influence
x_f = L/10; % force location
phi_x_f = feval(mode_fn,x_f,1:n_modes,rhoA,L); % mode shapes evaluated at x_f
% constant DVA parameters
x_a = L/4;
p = 1;
phi_x_a = feval(mode_fn,x_a,1:n_modes,rhoA,L); % mode shapes evaluated at x_a
zeta_a = 0.05;
w_a = p*w_n(DVA_mode);
% frequency response at x for system without DVA
wmin = 0.1*w_n(1);
wmax = 10*w_n(end);
w = logspace(log10(wmin),log10(wmax),10001);
G = zeros(1,length(w));
% G(iw) =W(x,iw)/F(iw)
x = L/4;
phi_x = feval(mode_fn,x,1:n_modes,rhoA,L);
% mode shapes evaluated at x
for k = 1:n_modes
    Gtilde = 1./(w_n(k)^2-w.^2+(1i*2*zeta(k)*w_n(k))*w);
    G = G + (phi_x_f(k)*phi_x(k))*Gtilde;
end
    str = {'Without DVA'};
ampl = 10^(25/20);    
r1 = 35/w_a;
r2 = 45/w_a;

mu = [.004 .065];
%      mu = [0.005 0.01 0.05 0.1 0.5 1];
    G_DVA = zeros(length(mu),length(w));
% G(iw) =W(x,iw)/F(iw) w/ DVA
for i = 1:length(mu)
    % varying DVA parameters
    m_a = mu(i)/phi_x_a(DVA_mode)^2
    % DVA mass (kg)
    k_a = m_a*w_a^2    % DVA stiffness (N/m)
    c_a = 2*zeta_a*m_a*w_a % DVA damping (N/(m/s))
    % frequency response at x for system with DVA
    H = (m_a*(c_a*w.^3+k_a*w.^2))./(-m_a*w.^2+1i*c_a*w+k_a); % H(iw) (DVA TF)
    num = zeros(1,length(w)); % sum in numerator of W(x_a,s)/F(s)
    den = zeros(1,length(w)); % sum in denomenator of W(x_a,s)/F(s)
    for k = 1:n_modes
        Gtilde = 1./(w_n(k)^2 - w.^2+(1i*2*zeta(k)*w_n(k))*w);
        num = num + phi_x_f(k)*phi_x_a(k)*Gtilde;
        den = den + phi_x_a(k)^2*Gtilde;
    end
Wxa_F = num./(1-H.*den);
    for k = 1:n_modes
        Gtilde = 1./(w_n(k)^2-w.^2+(1i*2*zeta(k)*w_n(k))*w);
        G_DVA(i,:) = G_DVA(i,:) + H.*Wxa_F.*(phi_x_a(k)*phi_x(k)*Gtilde)+(phi_x_f(k)*phi_x(k))*Gtilde;
    end
    str{i+1} = sprintf('\\mu = %g',mu(i));
end
% convert to dimensionless
d_st = phi_x_a(DVA_mode)*phi_x(DVA_mode)/w_n(DVA_mode)^2;
G = G/d_st;
G_DVA = G_DVA/d_st;
% plot frequency response
figure;
semilogx(w,20*log10(abs(G)),w,20*log10(abs(G_DVA)));
legend(str{:});
set(gca,'XLim',[1e0 1e3]);
hold on
x = linspace(-120, 40, 100);
y1 = repmat(35, size(x));
y2 = repmat(45, size(x));
semilogx(y1, x, 'k:', y2, x, 'k:')
y3 = repmat(25, size(w));
semilogx(w, y3, 'k:')

%% Problem 2

clear
close all

alpha = 0.004;
T=10;
m1 = 1;
m2 = .1;
c=.004;
k=1;

w2 = sqrt(k/m2);
zeta = c/(2*m2*w2);
mu = m2/m1;

s = tf('s');
G1=(m2*s^2+c*s+k)/((m2*s^2+c*s+k)*(m1*s^2+c*s+k)-(c*s+k)^2);
G2 = w2^2/((mu*s^2+2*zeta*w2*s+w2^2) - (2*zeta*w2*s+w2^2)/(x^2+2*zeta*w2*s+w2^2));
H = tf([T 1], [T*alpha 1]);

G1_loop=  G1/(1+G1*H);
G2_loop = G2/(1+G2*H);
margin(G1_loop)

