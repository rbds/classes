% Randy Schur
%MAE 6257 HW2

%%Problem 1
close
m = 50; %[kg]
k = 5000; %[N/m]
c1 = 1000; %[N/m/s]
c2 = 100;
c3 = 10000;

%ICs
x0 = 1; %[m]
xdot0 = 1; %[m/s]

t = linspace(0, 10, 1000);


% solution via state space
A1 = [0 1; -k/m  -c1/m];
A2 = [0 1; -k/m  -c2/m];
A3 = [0 1; -k/m  -c3/m];
B = [0 0]';
C = [1 0];
D = 0;
sys1 = ss(A1,B,C,D);              % construct state space object
sys2 = ss(A2, B, C, D);
sys3 = ss(A3, B, C, D);
u = ones(size(t));              % vector of ones representing the unit step input
x1 = lsim(sys1,u,t,[x0 xdot0]);  % linear system simulation
x2 = lsim(sys2,u,t,[x0 xdot0]);
x3 = lsim(sys3,u,t,[x0 xdot0]);

hold on
plot(t,x1);
plot(t, x2, 'r');
plot(t, x3, 'g');
title('System Response');
xlabel('time (s)')
ylabel('Amplitude (m)');
legend( 'c = 500 N/m/s', 'c = 50 N/m/s', 'c = 5000 N/m/s')

%%
