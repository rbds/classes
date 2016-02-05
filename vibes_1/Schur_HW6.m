%Randy Schur
%MAE 6257 HW6
% 10/16/14

%% Problem 2
%a.
clear
close all

m1 = 1;
m2 = 4; 
k1 = 2;
k2 = 1;

M = [m1 0; 0 m2];
K = [k1 + k2, -k2; -k2 k2];
zeta = 0.3;
[V, D] = eig(M\K);
V = fliplr(V);
w = flipud(sqrt(diag(D)));
% w = sqrt(diag(D));

A = [1/(2*w(1)) w(1)/2; 1/(2*w(2)) w(2)/2];
a = A\[zeta; zeta];
alpha = a(1)
beta = a(2)

%b.
L = chol(M, 'lower');
Ktilde = L^-1*K*L'^-1;
[P,DK] = eig(Ktilde);

q0 = [1 -1]';
qdot0 = [0 2]';

z0 = (L*P)'*q0;
zdot0 = (L*P)'*qdot0;

%from notes for underdamped decoupled systems:
t = linspace(0, 50, 1000);
wd = w*sqrt(1-zeta^2);
%wd(2) = w(2)*sqrt(1-zeta^2);
phi = atan2(wd.*z0,(zdot0 + zeta*w.*z0));
z1 = zeros(length(t));
z2 = zeros(1, length(t));
for i = 1:length(t)
    z(:,i) = sqrt(z0.^2 + ((zdot0 + zeta*w.*z0(1))./wd).^2).*exp(-zeta*w.*t(i)).*sin(wd.*t(i) + phi);
%     z2(i) = sqrt(z0(2)^2 + ((zdot0(2) + zeta*w(2)*z0(2))/wd(2))^2)*exp(-zeta*w(2)*t(i))*sin(wd(2)*t(i) + phi(2));
end
subplot(2,1,1), plot(t,z)
title('2b. Modal Response')
xlabel('time (s)')
ylabel('Amplitude (m)')
legend('First Mode', 'Second Mode')

%c.
q = L'^-1*P*z;
subplot(2,1,2), plot(t,q)
title('2c. System Physical Response')
xlabel('time (s)')
ylabel('Amplitude (m)')
legend('x1(t)', 'x2(t)')
%% Problem 3
%a.)
clear
figure

m =[3000; 12000; 3000]; %[kg]
E = 6.9*10^9; %[N/m2]
I = 5.2*10^-6; %[m4]
l = 2;
k = E*I/l^3;

M = diag(m);
K = [k -k 0; -k 2*k -k; 0 -k k];

%b.)
[u,D] = eig(M\K);
w= sqrt(diag(D));


%c.)
L = chol(M, 'lower');
Ktilde = (L^-1)*K*(L'^-1);
[P, DK] = eig(Ktilde);
% P = fliplr(P);

%d.)

q0 = [0.2; 0; 0];
qdot0 = [0; 0; 0];
z0 = (L*P)'*q0;
zdot0 = (L*P)'*qdot0;

t = linspace(0, 50, 1000);
%for undamped systems:
% z = zeros(3, length(t));
for i = 1:length(t)
   z(1, i) = zdot0(1)*t(i) + z0(1);
   z(2,i) = sqrt(z0(2)^2 + (zdot0(2)/w(2))^2)*sin(w(2)*t(i) + atan2(w(2)*z0(2), zdot0(2))); 
   z(3,i) = sqrt(z0(3)^2 + (zdot0(3)/w(3))^2)*sin(w(3)*t(i) + atan2(w(3)*z0(3), zdot0(3))); 
end

subplot(2,1,1), plot(t, z)
title('3d. Modal Response')
xlabel('time (s)')
ylabel('Amplitude (m)')
legend('First Mode', 'Second Mode', 'Third Mode')

q = L'^-1*P*z;
subplot(2,1,2), plot(t,q)
title('3e. System Physical Response')
xlabel('time (s)')
ylabel('Amplitude (m)')
legend('x1(t)', 'x2(t)', 'x3(t)')