function Schur_final_prob4
close all;
clear;

theta= 2;

X0=[1; -1; 0];
N=501;
t=linspace(0,20,N);

[t, X]=ode45(@eom,t,X0);

for i=1:N
    u(i,:) = control(t(i), X(i,:)');
end

x1 = X(:,1);
x2 = X(:,2);
theta_hat = X(:,3);

figure;plot(t,x1, t, x2, t, theta_hat);ylabel('x'); xlabel('t')
title('System Response vs. time'); legend('x_1', 'x_2', 'theta_{hat}');
figure;plot(t,u);ylabel('u'); xlabel('t')
title('Control Input vs. time'); legend('u_1', 'u_2', 'u_3');


end


function X_dot=eom(t,X)
theta=2;
gamma = 2;

x1 = X(1);
x2 = X(2);
theta_hat = X(3);
alpha = -theta_hat*x1^2-x1;
z = x2 - alpha;

theta_hat_dot = gamma*(x1^2*(1+2*z*theta_hat - z));
u=control(t,X);
x1_dot = x2 + theta*x1^2;
x2_dot = u;

X_dot=[x1_dot; x2_dot; theta_hat_dot];
end

function u=control(t,X)
theta=2;
gamma = 1;

x1 = X(1);
x2 = X(2);
theta_hat = X(3);
alpha = -theta_hat*x1^2-x1;
z = x2 - alpha;

u= -2*z-2*z*theta_hat*x1+2*theta_hat*x1^2-gamma*x1^4*(z+2*z*theta_hat*x1+x1);
end
