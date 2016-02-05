%Randy Schur
%MAE 6257 HW1
%9/11/14

hold off
%Problem 4d
m = 10;
k = 5000;
l = 1;
w = sqrt(3428.6);
% w = 57;
A = [0 1; -(48/7)*k/(m*l) 0];
B = [0 (48/7)*k/(m*l^2)]';
C = [1 0];
D = 0;

t = linspace(0,5, 1000);

system = ss(A,B,C,D);
u = -0.01*exp(-t);
x = lsim(system, u, t, [0 0]);

plot(t,x)
hold on


x1 = .0331*cos(w*t) - .0067*sin(w*t) - 0.0115*exp(-t);
plot(t,x1, 'r', 'LineWidth', 2)
legend('state space solution', 'analytical solution')
