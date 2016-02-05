clear all;
close all;

A=[0 1; 0 0];
B=[0 1]';
Q=[1 0; 0 0];
R=.01;

Qf=[1 0; 0 0];
tf = 20;
rf = [sin(tf*pi/2) 0]';
N=501;
t=linspace(0,tf,N);
dt=t(2)-t(1);
r=sin(t*pi/2);
r(2,:)=pi/2*cos(pi/2*t);

P=zeros(2,2,N);
s=zeros(2,N);
P(:,:,N)=Qf;
s(:,N)=Qf*rf;

for k=N:-1:2
    P_dot=-P(:,:,k)*A-A'*P(:,:,k)+P(:,:,k)*B*inv(R)*B'*P(:,:,k)-Q;
    s_dot= (P(:,:,k)*B*inv(R)*B'- A')*s(:,k)+ Q*r(:,k);
    P(:,:,k-1)=P(:,:,k)-P_dot*dt;
    s(:,k-1)= s(:,k)-s_dot*dt;
end

    x=zeros(2,N);
    K=zeros(1,2,N);
    u=zeros(1,N);

    x(:,1)=[1 1]';
for k=1:N-1
    K(:,:,k)= inv(R)*B'*P(:,:,k);
    u(k)= -K(:,:,k)*x(:,k) - inv(R)*B'*s(:,k);
    x_dot= A*(x(:,k))+ B*u(:,k);
    x(:,k+1)= x(:,k) + x_dot*dt;
end

for k=1:N
    K1(k)=K(1,1,k);
    K2(k)=K(1,2,k);
end

figure(1);

plot(t, x(1,:), t , r(1,:));hold on;
ylabel('x, r')
legend ('x1', 'r1')
figure
plot(t,x(2,:), t , r(2,:));hold on;
legend ('x2', 'r2')
figure
plot(t,u);hold on;
ylabel('u');
figure
plot(t,K1,t,K2,t,s(1,:));hold on;
ylabel('K, s');
figure(1)

