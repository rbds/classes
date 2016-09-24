function exAdaptive
global theta k gamma
close all;

theta=2;
k=1;
gamma=1;

X0=[2; 0];
N=501;
t=linspace(0,30,N);

[t X]=ode45(@eom,t,X0);


x=X(:,1);
theta_hat=X(:,2);

for i=1:N
    u(i)=control(t(i),X(i,:));
end

figure;plot(t,x);ylabel('x');
figure;plot(t,theta_hat);ylabel('$\hat\theta$','interpreter','latex');
figure;plot(t,u);ylabel('u');


end


function X_dot=eom(t,X)
global theta gamma
x=X(1);
theta_hat=X(2);

u=control(t,X);
phi=2*x+x^2+1;
x_dot=u+theta*phi;
theta_hat_dot=gamma*x*phi;

X_dot=[x_dot;theta_hat_dot];
end

function u=control(t,X)
global k
x=X(1);
theta_hat=X(2);

phi=2*x+x^2+1;
u=-k*x-theta_hat*phi;
end