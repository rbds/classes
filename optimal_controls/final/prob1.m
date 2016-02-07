clear all;
close all;

N=201;
t=linspace(0,20,N);
h=t(2)-t(1);
sigma_wV=1e-2;
sigma_wt=1e-2;
sigma_vr=1e-1;
sigma_vt=3*pi/180;

Nref=2;
ref=[0 10; 5 -5];

Q=diag([sigma_wV^2 sigma_wt^2]);
R=diag([sigma_vr^2 sigma_vt^2 sigma_vr^2 sigma_vt^2]);

X0=[0.05 0.1 3*pi/180]';
P0=diag([0.2^2 0.2^2 (5*pi/180)^2]);

load prob1_wv;

X_true=zeros(3,N);
X_true(:,1)=[0 0 0]';

V=pi;

% True Trajectory
for k=1:N-1
    if k <= (N-1)/2
        u(k)=pi/5;
    else
        u(k)=-pi/5;
    end
    theta_k=X_true(3,k);
    X_true(:,k+1)=X_true(:,k)...
        +[h*(V+w_V(k))*cos(theta_k);h*(V+w_V(k))*sin(theta_k);h*(u(k)+w_t(k))];
end

figure(1);
plot(X_true(1,:),X_true(2,:),'r');
xlabel('$x$','interpreter','latex');
ylabel('$y$','interpreter','latex');
axis equal;

% Measurement
for k=1:N
    x=X_true(1,k);
    y=X_true(2,k);
    theta=X_true(3,k);
    
    for j=1:Nref
        rx=ref(1,j);
        ry=ref(2,j);
        
        delx=rx-x;
        dely=ry-y;
        
        dis=sqrt(delx^2+dely^2);
        
        delP=[delx; dely];
        delP_body=[cos(theta) sin(theta);
            -sin(theta) cos(theta)]*delP;
        angle=atan2(delP_body(2),delP_body(1));
        
        z(2*j-1:2*j,k)=[dis; angle];
    end
    
    z(:,k)=z(:,k)+v(:,k);
end


figure(1);hold on;
plot(ref(1,:),ref(2,:),'b*');
figure(2);
plot(t,z);
xlabel('$t$','interpreter','latex');
ylabel('$z$','interpreter','latex');

% EKF

X_bar=zeros(3,N);
P=zeros(3,3,N);
X_bar(:,1)=X0;
P(:,:,1)=P0;
Z_bar=zeros(2*Nref,N);

