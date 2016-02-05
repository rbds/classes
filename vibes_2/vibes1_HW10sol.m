n_modes = 5; % number of modes to use in expansion
% beam properties
L = 2; % length (m)
rhoA = 7870*0.1*0.1; % mass/length (kg/m)
EI = 200e9*0.1^4/12; % bending stiffness (N-m^2)
% input force properties
F0 = 5500; % magnitude (N)
w_x = L/2; % force location (m)
w = 3000*2*pi/60; % frequency (rad/s)
% dimensionless frequencies (clamped-clamped): cos(betaL)cosh(betaL) = 1
betaL = [4.73004074 7.85320462 10.9956079 14.1371655 17.2787597]';
% plot mode shapes
x = linspace(0,L,101);
sig = repmat((sin(betaL)-sinh(betaL))./(cos(betaL)-cosh(betaL)),1,length(x));
temp = (betaL/L)*x;
phi_x = sin(temp)-sinh(temp)-sig.*(cos(temp)-cosh(temp)); % mode shapes evaluated at x
figure;
plot(x,phi_x);
title('Mode shapes (c=1)');
% natural frequencies
w_n = betaL.^2*sqrt(EI/(rhoA*L^4))
% modal damping
zeta = 0.05*ones(size(w_n));
% frequency responses
wmin = 0.1*w_n(1);
wmax = 10*w_n(end);
w_G = logspace(log10(wmin),log10(wmax),1001);
Gtilde = zeros(n_modes,length(w_G)); % modal amplification factors
alpha = sin(betaL/2)-sinh(betaL/2)-(sin(betaL)-sinh(betaL))./(cos(betaL)-cosh(betaL)).*(cos(betaL/2)-cosh(betaL/2)) % modal influence coefficients of force
mu = rhoA*trapz(x,phi_x.^2,2)
A_F = zeros(n_modes,length(w_G)); % transfer functions between force and modal response
for i = 1:n_modes
Gtilde(i,:) = 1./(w_n(i)^2-w_G.^2+(1i*2*zeta(i)*w_n(i))*w_G);
A_F(i,:) = (alpha(i)/mu(i))*Gtilde(i,:);
end
figure;
subplot(2,1,1);
semilogx(w_G,20*log10(abs(Gtilde)));
subplot(2,1,2);
semilogx(w_G,180/pi*angle(Gtilde));
title('Modal Frequency Response Functions');
figure;
subplot(2,1,1);
semilogx(w_G,20*log10(abs(A_F)));
subplot(2,1,2);
semilogx(w_G,180/pi*angle(A_F));
title('A_k(i\omega)/F(i\omega)');
% physical response
ind = find(w_G>w,1,'first');
