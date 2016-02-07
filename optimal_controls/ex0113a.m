% MAE 6295
%Randy Schur
% Numerical Solution by Steepest Descent, demo.

clear all
close all
u1 = linspace(-2, 4, 100);
u2 = linspace (-4, 2, 100);
for i = 1:100   
    for j= 1:100
        J(i,j) = 1/2*u1(i).^2+u1(i)*u2(j)+u2(j)^2 + u2(j);
    end
end

contour(u1, u2, J', 22)
hold on
xlabel('u_1')
ylabel('u_2')
axis equal

u=[4 2];
eps = 1e-6;
k = 0.1;
Ju=1;

while norm(Ju) > eps
   Ju = [u(1)+u(2) u(1)+2*u(2)+1];
       u = u-k*Ju;
       plot(u(1), u(2), 'r*')
       drawnow
       norm(Ju)
end       
plot(u(1), u(2), 'k')