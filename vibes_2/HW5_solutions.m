n_modes = 8; % number of modes to use in expansion
DVA_mode = 4; % mode to tune DVA to
% beam properties
L = 1; % length (m)
rhoA = 1; % mass/length (kg/m)
EI = 1; % bending stiffness (N-m^2)

% dimensionless frequencies (pinned-pinned):
lamda = pi*(1:n_modes)'; % natural frequencies
w_n = lamda.^2*sqrt(EI/(rhoA*L^4))
% modal damping
zeta = 0.00*ones(size(w_n));
% plot mode shapes
mode_fn ='ms_pinned_pinned';
% x = linspace(0,L,101);
% phi_x = feval(mode_fn,x,1:n_modes,rhoA,L); % mode shapes evaluated at x
% figure;
% plot(x,phi_x);

% force influence
x_f = L/8; % force location
phi_x_f = feval(mode_fn,x_f,1:n_modes,rhoA,L); % mode shapes evaluated at x_f
% constant DVA parameters
x_a = L/8;
p = 1;
phi_x_a = feval(mode_fn,x_a,1:n_modes,rhoA,L); % mode shapes evaluated at x_a
zeta_a = 0.05;
w_a = p*w_n(DVA_mode)
% frequency response at x for system without DVA
wmin = 0.1*w_n(1);
wmax = 10*w_n(end);
w = logspace(log10(wmin),log10(wmax),10001);
G = zeros(1,length(w));
% G(iw) =W(x,iw)/F(iw)
x = L/8;
phi_x = feval(mode_fn,x,1:n_modes,rhoA,L);
% mode shapes evaluated at x
for k = 1:n_modes
    Gtilde = 1./(w_n(k)^2-w.^2+(1i*2*zeta(k)*w_n(k))*w);
    G = G + (phi_x_f(k)*phi_x(k))*Gtilde;
end
    str = {'Without DVA'};
    mu = [0.005 0.01 0.05 0.1 0.5 1];
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

