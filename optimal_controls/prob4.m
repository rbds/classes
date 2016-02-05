%% Midterm 6292 
%Randy Schur
%Problem 4

function [] = prob4(  )
clear
close all

N= 501;
t = linspace(0,pi, N);
dt = t(2) - t(1);

x_init = [1 0 0 1]'*ones(1,N);
lambda_init = ones(4,N);

x = x_init;
x(:,N) = [-2 0 0 -1/sqrt(2)]';
eps = 1e-5;
delta = 1;
count =0;
while delta > eps
   phi = zeros(8,8,N);
   p = zeros(8,N);
   phi(:,:,1) = eye(8);
%    p(:,1) = [0 0 0 0 0 0 0 0]';
   for k=1:N-1
     [A e] = my_eom_lin(x_init(:,k), lambda_init(:,k));
      phi_dot = A*phi(:,:,k);
      p_dot = A*p(:,k) + e;
      phi(:,:,k+1) = phi(:,:,k) + phi_dot*dt;
      p(:,k+1) = p(:,k) + dt*p_dot;
   end
   
   x0 = [1 0 0 1]';
 
    phi_xl=phi(1:4,5:8, N);
    phi_xx=phi(1:4, 1:4,N);
    p_x_tf=p(1:4,N);
    xf = [-2 0 0 -1/sqrt(2)]';
    lambda0= inv(phi_xl)*(xf -phi_xx*x0-p_x_tf);
    
    x=zeros(4,N);
    lambda=zeros(4,N);
    x(:,1)=x0;
    lambda(:,1)=lambda0;
    z0=[x0;lambda0];
    for k=2:N
        zk=phi(:,:,k)*z0+p(:,k);
        x(:,k)=zk(1:4);
        lambda(:,k)=zk(5:8);
    end
    u = [-lambda(3,:); -lambda(4,:)];
    
    subplot(2,2,1);
    plot(t,x);hold on;
    ylabel('x');
    subplot(2,2,2);
    plot(t,lambda);hold on;
    ylabel('\lambda');
    subplot(2,2,3);
    plot(t,u);hold on;
    ylabel('u');
    drawnow;
    
    delta = norm(max(abs(x-x_init) + abs(lambda-lambda_init)));
    
    x_init=x;
    lambda_init=lambda;
    count = count+1;
end
figure
    subplot(2,2,1);
    plot(t,x);hold on;
    ylabel('x');
    title('Converged Values')
    subplot(2,2,2);
    plot(t,lambda);hold on;
    ylabel('\lambda');
    subplot(2,2,3);
    plot(t,u);hold on;
    ylabel('u');

end


function [ A, e ] = my_eom_lin( x, lambda )

[Hx Hl Hxx Hxl Hlx Hll]= prob4_H_deriv(x,lambda);

A=[Hlx Hll;
  -Hxx -Hxl];
e=-(A*[x;lambda])+[Hl'; -Hx'];
end


function [Hx Hl Hxx Hxl Hlx Hll]=prob4_H_deriv(x,lambda)

x1=x(1);
x2=x(2);
x3=x(3);
x4=x(4);
l1=lambda(1);
l2=lambda(2);
l3=lambda(3);
l4=lambda(4);

Hx= [ (2*l3*x1^2 + 3*l4*x1*x2 - l3*x2^2)/(x1^2 + x2^2)^(5/2), (- l4*x1^2 + 3*l3*x1*x2 + 2*l4*x2^2)/(x1^2 + x2^2)^(5/2), l1, l2];
Hl= [ x3, x4, - l3 - x1/(x1^2 + x2^2)^(3/2), - l4 - x2/(x1^2 + x2^2)^(3/2)];
Hxx=[-(6*l3*x1^3 + 12*l4*x1^2*x2 - 9*l3*x1*x2^2 - 3*l4*x2^3)/(x1^2 + x2^2)^(7/2), (3*l4*x1^3 - 12*l3*x1^2*x2 - 12*l4*x1*x2^2 + 3*l3*x2^3)/(x1^2 + x2^2)^(7/2), 0, 0;
    (3*l4*x1^3 - 12*l3*x1^2*x2 - 12*l4*x1*x2^2 + 3*l3*x2^3)/(x1^2 + x2^2)^(7/2),  (3*l3*x1^3 + 9*l4*x1^2*x2 - 12*l3*x1*x2^2 - 6*l4*x2^3)/(x1^2 + x2^2)^(7/2), 0, 0;
       0,                                                                           0, 0, 0;
       0,                                                                           0, 0, 0];
Hxl=[  0, 0, (2*x1^2 - x2^2)/(x1^2 + x2^2)^(5/2),        (3*x1*x2)/(x1^2 + x2^2)^(5/2);
       0, 0,       (3*x1*x2)/(x1^2 + x2^2)^(5/2), -(x1^2 - 2*x2^2)/(x1^2 + x2^2)^(5/2);
       1, 0,                                   0,                                   0;
       0, 1,                                   0,                                   0];

Hlx=Hxl';
Hll=[  0, 0,  0,  0;
       0, 0,  0,  0;
       0, 0, -1,  0;
       0, 0,  0, -1];

end