%% MAE 6292 HW3
%Randy Schur
%3/3/15

clear all
close all

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

Q=[1 0; 0 0];
P=zeros(2,2,N);
s=zeros(2,N);
P(:,:,N)=Qf;
s(:,N)=Qf*rf;
for k=N:-1:2
    P_dot=-P(:,:,k)*A-A'*P(:,:,k)+P(:,:,k)*B/R*B'*P(:,:,k)-Q;
    s_dot= (P(:,:,k)*B/(R)*B'- A')*s(:,k)+ Q*r(:,k);
    P(:,:,k-1)=P(:,:,k)-P_dot*dt;
    s(:,k-1)= s(:,k)-s_dot*dt;
end

    x=zeros(2,N);
    K=zeros(1,2,N);
    u=zeros(1,N);

    x(:,1)=[1 1]';
for k=1:N-1
    K(:,:,k)= R\B'*P(:,:,k);
    u(k)= -K(:,:,k)*x(:,k) - R\B'*s(:,k);
    x_dot= A*(x(:,k))+ B*u(:,k);
    x(:,k+1)= x(:,k) + x_dot*dt;
end

for k=1:N
    K1(k)=K(1,1,k);
    K2(k)=K(1,2,k);
end

figure(1);

plot(t, x(1,:), t , r(1,:), t, x(2,:), t, r(2,:))
ylabel('x, r')
legend ('x1', 'r1','x2', 'r2')
figure
plot(t,u)
ylabel('u');
figure
plot(t,K1,t,K2)
ylabel('K')
legend('K1', 'K2')
figure
plot(t,s(1,:),t, s(2,:))
legend('s1', 's2')
ylabel('s')
figure(1)

