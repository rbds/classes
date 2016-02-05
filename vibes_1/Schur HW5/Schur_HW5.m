%Randy Schur
%MAE 6257 HW 5
%10/9/14
clear
close

m1 = 10;
m2 = 2;
m3 = 10;
k = 6;
q0 = [ 0 2 0]';
qdot0 = [0 0 0]';
t = linspace(0,5, 1000);
t = t';
% t = 1;

M = [m1 0  0; 0 m2 0; 0 0 m3];
K = [-7*k k 5*k; k -2*k k; 5*k k -7*k];

[V, D] = eig(-M\K);
w1 = sqrt(D(1,1));
w2 = sqrt(D(2,2));
w3 = sqrt(D(2,2));

u1 = V(:,1);
u2 = V(:,2);
u3 = V(:,3);

mu1 = u1'*M*u1;
mu2 = u2'*M*u2;
mu3 = u3'*M*u3;

phi1 = atan2((w1*u1'*M*q0),(u1'*M*qdot0));
phi2 = atan2((w2*u2'*M*q0),(u2'*M*qdot0));
phi3 = atan2((w3*u3'*M*q0),(u3'*M*qdot0));
A1 = u1'*M*q0/(mu1*sin(phi1));
A2 = u2'*M*q0/(mu2*sin(phi2));
A3 = u3'*M*q0/(mu3*sin(phi3));

for i = 1:length(t)
q(:,i) = A1*sin(w1*t(i) + phi1)*u1 + A2*sin(w2*t(i) + phi2)*u2 + A3*sin(w3*t(i) + phi3)*u3; 
end
subplot(3,1,1), plot(t, q(1,:))
title('Mass 1 Response')
xlabel(' time(s)')
ylabel(' Amplitude(m)')

subplot(3,1,2), plot(t, q(2,:))
title('Mass 2 Response')
xlabel(' time(s)')
ylabel(' Amplitude(m)')

subplot(3,1,3), plot(t, q(3,:))
title('Mass 3 Response')
xlabel(' time(s)')
ylabel(' Amplitude(m)')
