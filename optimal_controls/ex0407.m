clear all;
close all;

l=[0 500 1000]';
Z=[30.1 45 73.6]';
R=diag([0.01 0.01 0.04]);

for i=1:3
    Bi_p=[l(i) 0];
    Bi_q=Bi_p+[cosd(Z(i)) sind(Z(i))]*1500;
    plot([Bi_p(1) Bi_q(1)],[Bi_p(2) Bi_q(2)]);hold on;
end
axis equal;
% xlim([1150 1250]);

X_bar = [1100 800]'; % initial guess (roughly center of intersecting triangle.
dX = 1;
eps = 1e-6;

while norm(dX)> eps
Z_bar = zeros(3,1);
H = zeros(3,2);
for i = 1:3
    x = X_bar(1);
    y = X_bar(2);
   Z_bar(i) = 180/pi*atan2(y,(x-l(i)));
    zxi = 180/pi*-y/((x-l(i))^2+y^2);
    zyi = 180/pi*(x-l(i))/((x-l(i))^2+y^2);
    H(i,:) = [zxi, zyi];

end
    dZ = Z- Z_bar;
    P = inv(H'/R*H);
    K=P*H'/R;
    dX = K*dZ;
    
    X_bar = X_bar + dX;
    plot(X_bar(1), X_bar(2), 'r*')
    drawnow
end

plot_gaussian_ellipsoid(X_bar, P, 2)