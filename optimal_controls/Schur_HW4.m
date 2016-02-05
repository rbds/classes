%% MAE 6292 HW 4
%Randy Schur
%4/16/15

%% Problem 4.
clear
close all
load('prob4_data.mat');

A = C(1:2, 1:3, :);
b = C(1:2, 4, :);
ct = C(3, 1:3, :);
for i=1:N
   c(:,:,i) = ct(:,:,i)'; 
end
d = C(3,4,:);
d = squeeze(d);

x_bar = [5 4 5]'; % initial guess, close to the result from the midterm.
dx = 1;
eps = 1e-6;

while norm(dx) > eps
    z_bar = zeros(8,1);
    H = zeros(8,3);
      for i=1:N 
       z_bar(2*i-1:2*i,:) = (A(:,:,i)*x_bar + b(:,:,i)) * 1/(c(:,:,i)'*x_bar+d(i));
       H(2*i-1:2*i,:) = -(A(:,:,i)*x_bar+b(:,:,i))*c(:,:,i)'/(c(:,:,i)'*x_bar +d(i))^2 + A(:,:,i)/ (c(:,:,i)'*x_bar+d(i));
      end
        dz = Z- z_bar;
        P = inv(H'/R*H);
        K = P*H'/R;
        dx = K*dz;

        x_bar = x_bar + dx;
end
[v,d] = eig(P);
%b 
semi_major_axis = v(:,3) %semi-major axis

%c
semi_minor_axis = v(:,1) %semi-minor axis
%d
plot(x_bar(1), x_bar(2), 'rx')
hold on
plot_gaussian_ellipsoid(x_bar(1:2), P(1:2,1:2), 2, 25)
title('Uncertainty Ellipse, 86%')
xlabel('x1')
ylabel('x2')
%e
figure
plot(x_bar(2), x_bar(3), 'rx')
hold on
plot_gaussian_ellipsoid(x_bar(2:3), P(2:3,2:3), 2, 25)
title('Uncertainty Ellipse, 86%')
xlabel('x2')
ylabel('x3')