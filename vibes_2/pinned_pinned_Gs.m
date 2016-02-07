% pinned_pinned_Gs.m

clc;
clear all;
close all;

n_modes = 15;			% number of modes to use in expansion
N = 3;					% number of modes in truncation

% beam properties
L = 1;					% length (m)
rhoA = 1;				% mass/length (kg/m)
EI = 1;					% bending stiffness (N-m^2)

% dimensionless frequencies (pinned-pinned): sin(lamda) = 0
lamda = pi*(1:n_modes)';

% natural frequencies
w_n = lamda.^2*sqrt(EI/(rhoA*L^4))

% modal damping
zeta = 0.01*ones(size(w_n));

% plot mode shapes
mode_fn = 'ms_pinned_pinned';
% x = linspace(0,L,101);
% phi_x = feval(mode_fn,x,1:n_modes,rhoA,L);		% mode shapes evaluated at x
% figure;
% plot(x,phi_x);
	 
% actuator and sensor locations
x_a = .41*L;
x_s = .41*L;
phi_x_a = feval(mode_fn,x_a,1:n_modes,rhoA,L);		% mode shapes evaluated at x_a
phi_x_s = feval(mode_fn,x_s,1:n_modes,rhoA,L);		% mode shapes evaluated at x_s

% frequency responses
w = linspace(0,2*w_n(n_modes),10001);
G_w = zeros(1,length(w));							% full G(iw)
G = tf(0,1);										% full transfer function
G_w_trunc = zeros(1,length(w));						% truncated G(iw)
G_trunc = tf(0,1);									% truncated transfer function
for k = 1:n_modes
	G_w = G_w + (phi_x_a(k)*phi_x_s(k))./(w_n(k)^2-w.^2+(1i*2*zeta(k)*w_n(k))*w);
	G = G + tf(phi_x_a(k)*phi_x_s(k),[1 2*zeta(k)*w_n(k) w_n(k)^2]);
	if k <= N
		G_w_trunc = G_w_trunc + (phi_x_a(k)*phi_x_s(k))./(w_n(k)^2-w.^2+(1i*2*zeta(k)*w_n(k))*w);
		G_trunc = G_trunc + tf(phi_x_a(k)*phi_x_s(k),[1 2*zeta(k)*w_n(k) w_n(k)^2]);
	else
		G_w_trunc = G_w_trunc + (phi_x_a(k)*phi_x_s(k))/(w_n(k)^2);
		G_trunc = G_trunc + tf(phi_x_a(k)*phi_x_s(k),w_n(k)^2);
	end
end

% plot real part of FRFs
figure;
semilogx(w,real(G_w),w,real(G_w_trunc));
set(gca,'YLim',[-0.1 0.1]);

% pole-zero maps
figure;
pzmap(G,G_trunc);
axis equal;
pG = pole(G)
zG = zero(G)

% figure;
pGtrunc = pole(G_trunc)
zGtrunc = zero(G_trunc)

% Bode plots
figure;
bode(G,G_trunc);
legend('G','G_{trunc}');

