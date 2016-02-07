%% MAE 6254 HW1
% Randy Schur
% 2/8/16
close all
g = 9.81;
c = 0.8;
l = 5;
d1 = -5:1:5;
d2 = -5:1:5;

[X,Y] = meshgrid(d1, d2);
for i= d1
    for j= d2
        x0 = [i; j];

        [t, x] = ode45(@HW1_1, [0, 10], x0);

        theta = x(:,1);
        theta_dot = x(:,2);

        hold on
%         quiver(X,Y,theta, theta_dot)
        plot(theta, theta_dot, 'b')
    end
end
[t, x] = ode45(@HW1_1, [0, 10], [1, 3.54]);

theta = x(:,1);
    theta_dot = x(:,2);
    hold on
    plot(theta, theta_dot, 'r--')
        
axis([-pi pi -4 4])

% figure

u = zeros(size(X));
v = zeros(size(Y));

for i= 1:length(d1)
    for j= 1:length(d2)
        x = X(i,j);
        y = Y(i,j);
        f = HW1_1(0, [x, y]);
        u(i,j) = f(1);
        v(i,j) = f(2);
    end
end

quiver(X, Y, u, v)
