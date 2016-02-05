%% MAE6292 HW 5 Problem 3
% Randy Schur
%4/28/15

clear all;
close all;
N=201;
t=linspace(0,20,N);
h=t(2)-t(1);
sigma_x=1e-3;
sigma_y=1e-3;
sigma_t1=3*pi/180;
sigma_t2=5*pi/180;

Q=diag([0 sigma_x^2 0 sigma_y^2]);
R=diag([sigma_t1^2 sigma_t2^2]);

X0=[1 0.5 3 0.8]';
P0=diag([0.1^2 0.1^2 0.1^2 0.1^2]);

w_x=normrnd(0,sigma_x,1,N);
w_y=normrnd(0,sigma_y,1,N);
w=[zeros(1,N); w_x; zeros(1,N); w_y];
v_t1=normrnd(0,sigma_t1,1,N);
v_t2=normrnd(0,sigma_t2,1,N);
v=[v_t1;v_t2];

X_true=zeros(4,N);
X_true(:,1)=X0+[0.1 0 -0.1 0]';

Ak=[1 h 0 0;
    0 1 0 0;
    0 0 1 h;
    0 0 0 1];
B=[0;0;h^2/2;h];
u=-0.1;
% True Trajectory
for k=1:N-1
    X_true(:,k+1)=Ak*X_true(:,k)+ + B*u + w(:,k);
end
%generate measurements.
for k=1:N
    x=X_true(1,k);
    y=X_true(3,k);
    z(:,k)=[sqrt((x-4)^2 +y^2);sqrt((x-8)^2 +y^2)] + v(:,k);
end


%EKF
x_bar=zeros(4,N);
P=zeros(4,4,N);
x_bar(:,1)=X0;
P(:,:,1)=P0;
for k=1:N-1
   %prediction step
    x_bar_minus = Ak*x_bar(:,k) + B*u;
    P_minus = Ak*P(:,:,k)*Ak'+Q;
    
   %update step 
   x = x_bar_minus(1);
   y = x_bar_minus(3);
   H=[(x-4)/sqrt((x-4)^2+y^2) 0 y/sqrt((x-4)^2+y^2) 0;
      (x-8)/sqrt((x-8)^2+y^2) 0 y/sqrt((x-8)^2+y^2) 0];
  z_bar = [sqrt((x-4)^2 +y^2);sqrt((x-8)^2 +y^2)];  
  K=P_minus*H'*inv(H*P_minus*H'+R);
    x_bar_plus=x_bar_minus+K*(z(:,k+1)-z_bar);
    P_plus=(eye(4)-K*H)*P_minus;
  %  
    x_bar(:,k+1) = x_bar_plus;
    P(:,:,k+1) = P_plus;  
end

plot(X_true(1,:), X_true(3,:), x_bar(1,:), x_bar(3,:))
title('Trajectory of Projectile')
legend('True','Estimated')

for k=1:N
    sigma_x(k)=sqrt(P(1,1,k));
    sigma_y(k)=sqrt(P(3,3,k));
end

figure;
plot(t,x_bar(1,:)-X_true(1,:),'b',t,3*sigma_x,'k',t,-3*sigma_x,'k');
xlabel('t');ylabel('e_x');
title('Estimated Value and 3\sigma bounds for x_1')
figure;
plot(t,x_bar(3,:)-X_true(3,:),'b',t,3*sigma_y,'k',t,-3*sigma_y,'k');
xlabel('t');ylabel('e_y');

title('Estimated Value and 3\sigma bounds for x_3')

figure;
for k=1:10:N
    plot(X_true(1,k),X_true(3,k),'r.');hold on;
    plot(x_bar(1,k),x_bar(3,k),'b*');
    plot_gaussian_ellipsoid(x_bar([1 3],k),P([1 3],[1 3],k),3);
end
axis equal;
xlabel('x');ylabel('y');
title('Trajectory with Covariance Ellipses')
legend('true values', 'estimated values', 'covariance ellipse')
