%% MAE 6254 HW1
% Randy Schur
% 2/8/16
close all
clear

d1 = -1.5:.4:1.5;
d2 = -1.5:.4:1.5;

[X,Y] = meshgrid(d1, d2);
for i= d1
    for j= d2
        x0 = [i; j];

        [t, x] = ode45(@HW2_1, [0, 10], x0);

        y = x(:,1);
        ydot = x(:,2);

        hold on
        plot(x(:,1), x(:,2), 'b')
    end
end

u = zeros(size(X));
v = zeros(size(Y));

for i= 1:length(d1)
    for j= 1:length(d2)
        x = X(i,j);
        y = Y(i,j);
        f = HW2_1(0, [x, y]);
        u(i,j) = f(1);
        v(i,j) = f(2);
    end
end

quiver(X, Y, u, v, 'red')
axis equal
axis([-5, 5, -2, 2])
title('Phase Portrait x1 vs x2')
