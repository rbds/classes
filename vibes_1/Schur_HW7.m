%Randy Schur
%MAE 6257
%HW 7

%% Problem 1
clear

M = [1 0; 0 4];
K = [9 -4; -4 4];
% syms c1 c2;
c1 =2; c2 =1;
C = [c1 + c2, -c2; -c2, c2];
L = chol(M);
Ktilde = (L\K)/L';
Ctilde = (C\K)/C';
[P,D] = eig(Ktilde);
P = fliplr(P);
w = flipud(sqrt(diag(D)));


L1 = P'*Ctilde*P;
L2 = P'*Ktilde*P;

%% Problem 2
clear
close all

M = [2 0; 0 4];
K = [10 -8; -8 8];
L = chol(M);
Ktilde = (L/M)\L';

[P,D] = eig(Ktilde);
w = sqrt(diag(D));
L1 = [.02 0; 0 .1];
L2 = P'*Ktilde*P;

q0 = [0;0];
qdot0 = [0;0];
z0 = (L*P)'*q0;
zdot0 = (L*P)'*qdot0;

%from notes for underdamped decoupled systems:
zeta = diag(L1);
% t = linspace(0, 50, 1000);
t = linspace(0,10,1001); 
wd = w.*sqrt(1-zeta.^2);
phi = atan2(wd.*z0,(zdot0 + zeta.*w.*z0));
z1b = zeros(length(t));
z2b = zeros(1, length(t));

alpha = P'/L;
f1 = 5;
f2 = 0;


% b
s = sym('s');
F = [5/s; 0];
Z_sym1b = (s*z0(1) + zdot0(1) +2*zeta(1)*w(1)*z0(1))/(s^2 + 2*zeta(1)*w(1)*s + w(1)^2) + alpha(1,:)*F./(s^2 +2*zeta(1)*w(1)*s + w(1)^2);
z_sym1b = ilaplace(Z_sym1b);     % inverse Laplace transform
z1b = subs(z_sym1b,t);   % substitute t vector for 't' in symbolic output

Z_sym2b = (s*z0(2) + zdot0(2) +2*zeta(2)*w(2)*z0(2))/(s^2 + 2*zeta(2)*w(2)*s + w(2)^2) + alpha(2,:)*F./(s^2 +2*zeta(2)*w(2)*s + w(2)^2);
z_sym2b = ilaplace(Z_sym2b);     % inverse Laplace transform
z2b = subs(z_sym2b,t);   % substitute t vector for 't' in symbolic output

figure;
plot(t,z1b);
hold on 
plot(t, z2b, 'LineWidth', 3);
title('Modal Responses to f1 = 5*H(t)');
legend('mode 1', 'mode 2')

%c
s = sym('s');
F = [0; 2];
Z_sym1c = (s*z0(1) + zdot0(1) +2*zeta(1)*w(1)*z0(1))/(s^2 + 2*zeta(1)*w(1)*s + w(1)^2) + alpha(1,:)*F./(s^2 +2*zeta(1)*w(1)*s + w(1)^2);
z_sym1c = ilaplace(Z_sym1c);     % inverse Laplace transform
z1c = subs(z_sym1c,t);   % substitute t vector for 't' in symbolic output

Z_sym2c = (s*z0(2) + zdot0(2) +2*zeta(2)*w(2)*z0(2))/(s^2 + 2*zeta(2)*w(2)*s + w(2)^2) + alpha(2,:)*F./(s^2 +2*zeta(2)*w(2)*s + w(2)^2);
z_sym2c = ilaplace(Z_sym2c);     % inverse Laplace transform
z2c = subs(z_sym2c,t);   % substitute t vector for 't' in symbolic output

figure;
plot(t,z1c);
hold on 
plot(t, z2c, 'LineWidth', 3);
title('Modal Responses to f2 = 2*delta(t)');
legend('mode 1', 'mode 2')

%d
s = sym('s');
F = [5/s; 2];
Z_sym1d = (s*z0(1) + zdot0(1) +2*zeta(1)*w(1)*z0(1))/(s^2 + 2*zeta(1)*w(1)*s + w(1)^2) + alpha(1,:)*F./(s^2 +2*zeta(1)*w(1)*s + w(1)^2);
z_sym1d = ilaplace(Z_sym1d);     % inverse Laplace transform
z1d = subs(z_sym1d,t);   % substitute t vector for 't' in symbolic output

Z_sym2d = (s*z0(2) + zdot0(2) +2*zeta(2)*w(2)*z0(2))/(s^2 + 2*zeta(2)*w(2)*s + w(2)^2) + alpha(2,:)*F./(s^2 +2*zeta(2)*w(2)*s + w(2)^2);
z_sym2d = ilaplace(Z_sym2d);     % inverse Laplace transform
z2d = subs(z_sym2d,t);   % substitute t vector for 't' in symbolic output
zd(1,:) = z1d;
zd(2,:) = z2d;
q = L'\P*zd;
figure
plot(t, q)
title('Physical Responses')
legend('Mass 1', 'Mass 2')

%% Problem 3
clear
close all

m1 = 200;
m2 = 50;
M = [m1 0; 0 m2];
k1 = 1000;
k2 = 500;
e = .5;
K = [k1 0; 0, k2];
L = chol(M);
Ktilde = (L\K)/L';
[P,D] = eig(Ktilde);
wn = sqrt(diag(Ktilde));
L2 = P'*Ktilde*P;

[v,d] = eig(M\K);
v = fliplr(v);
d = flipud(sqrt(diag(d)));
B = [1 0; 0 1];
alpha = P'*L\B;


%c
w = logspace(log10(0.1*wn(1)),log10(10*wn(end)),1001);
Gtilde = zeros(2,length(w));		% modal transfer functions

for i = 1:2
	Gtilde(i,:) = 1./(-w.^2+(1i*2*zeta(i)*wn(i))*w+wn(i)^2);
end

% Bode plots
figure;
semilogx(w,20*log10(Gtilde));
title('Modal Dynamic Amplification Factors')
legend('Z_1(iw)/F(iw)','Z_2(iw)/F(iw)');

%d
syms s;
Z1 = 1/(s^2 +5)*P'\L*B;
Z2 = 1/(s^2 +10)*P'\L*B;
F1 = 1;
F2 = -11.5;

figure;
G11 = subs( Z1/F1, w);
G12 = subs( Z1/F2, w);
G21 = subs( Z2/F1, w);
G22 = subs( Z2/F2, w);
subplot(2,2,1) 
semilogx(w, 20*log10(G11(1:1001)));
subplot(2,2, 2)
semilogx(w, 20*log10(G12(1:1001)));
subplot(2,2,3)
semilogx(w, 20*log10(G21(1:1001)));
subplot(2,2,4)
semilogx(w, 20*log10(G22(1:1001)));