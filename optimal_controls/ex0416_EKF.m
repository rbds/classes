clear all;
close all;

N=201;
t=linspace(0,20,N);
h=t(2)-t(1);
sigma_x=1e-3;
sigma_y=1e-3;
sigma_r=1e-1;
sigma_t=5*pi/180;

Q=diag([0 sigma_x^2 0 sigma_y^2]);
R=diag([sigma_r^2 sigma_t^2]);

X0=[1 0.1 0.1 0.2]';
P0=diag([0.1^2 0 0.1^2 0]);

w_x=normrnd(0,sigma_x,1,N);
w_y=normrnd(0,sigma_y,1,N);
w=[zeros(1,N); w_x; zeros(1,N); w_y];
v_r=normrnd(0,sigma_r,1,N);
v_t=normrnd(0,sigma_t,1,N);
v=[v_r;v_t];

X_true=zeros(4,N);
X_true(:,1)=X0+[0.1 0 -0.1 0]';

Ak=[1 h 0 0;
    0 1 0 0;
    0 0 1 h;
    0 0 0 1];

% True Trajectory
for k=1:N-1
    X_true(:,k+1)=Ak*X_true(:,k)+w(:,k);
end

for k=1:N
    x=X_true(1,k);
    y=X_true(3,k);
    r=sqrt(x^2+y^2);
    theta=atan2(y,x);
    z(:,k)=[r;theta]+v(:,k);
end

figure(1);
plot(X_true(1,:),X_true(3,:),'r');
xlabel('x');
ylabel('y');

figure(2);
plot(t,z);
xlabel('t');
ylabel('z');

% EKF

X_bar=zeros(4,N);
P=zeros(4,4,N);
X_bar(:,1)=X0;
P(:,:,1)=P0;

for k=1:N-1
    % prediction
    X_bar_kp=Ak*X_bar(:,k);
    P_kp=Ak*P(:,:,k)*Ak'+Q;

    % correction
    x=X_bar_kp(1);
    y=X_bar_kp(3);
    r=sqrt(x^2+y^2);
    theta=atan2(y,x);
    z_bar=[r;theta];
    H=[x/r 0 y/r 0;
        -y/r^2 0 x/r^2 0];
    K=P_kp*H'*inv(H*P_kp*H'+R);
    X_bar_kp=X_bar_kp+K*(z(:,k+1)-z_bar);
    P_kp=(eye(4)-K*H)*P_kp;

    
    X_bar(:,k+1)=X_bar_kp;
    P(:,:,k+1)=P_kp;
end

figure(1);
hold on;
plot(X_bar(1,:),X_bar(3,:),'b');
xlabel('x');
ylabel('y');

for k=1:N
    sigma_x(k)=sqrt(P(1,1,k));
    sigma_y(k)=sqrt(P(3,3,k));
end

figure;
plot(t,X_bar(1,:)-X_true(1,:),'b',t,3*sigma_x,'k',t,-3*sigma_x,'k');
xlabel('t');ylabel('e_x');
figure;
plot(t,X_bar(3,:)-X_true(3,:),'b',t,3*sigma_y,'k',t,-3*sigma_y,'k');
xlabel('t');ylabel('e_y');

figure;
for k=1:10:N
    plot(X_true(1,k),X_true(3,k),'r.');hold on;
    plot(X_bar(1,k),X_bar(3,k),'b*');
    plot_gaussian_ellipsoid(X_bar([1 3],k),P([1 3],[1 3],k),3);
end
axis equal;
xlabel('x');ylabel('y');


    
    
    
    

