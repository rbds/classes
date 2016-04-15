%% MAE 6254 HW4
% Randy Schur
% 4/11/16
close all

x1_0 = 2;
x2_0=-1;

[t, x] = ode45(@HW4_4, [0, 2], [x1_0; x2_0]);


u = x(:,1) - 3/2*x(:,1).^4 - 3*x(:,1).*(x(:,2)-3/2*x(:,1).^2) - (x(:,2)-3/2*x(:,1).^2);
V = 1/2*x(:,1).^2 + 1/2*(x(:,2) - 3/2*x(:,1).^2).^2;

hold on

plot(t, x(:,1), 'b-')
plot(t, x(:,2), 'r-')
plot(t,u, 'g')
plot(t, V, 'k')

title('System response')
legend('x1', 'x2', 'u', 'V_c')
xlabel('time')