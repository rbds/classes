function Schur_final_prob2
close all;

X0=[1.5 0.5]';
N=501;
t=linspace(0,10,N);
[t X]=ode45(@eom,t,X0);

x1=X(:,1);
x2=X(:,2);
for k=1:N
    u(k)=control(t(k),X(k,:)');
end

figure;
plot(x1,x2);hold on;
plot([-1 1],[1, -1],'r--');
title('x vs. x_dot$')
xlabel('\theta')
ylabel('$\dot{\theta}$')
figure
plot(t,u)
title('Control Input vs. time')
figure
plot(t, x1, 'b-', t, x2, 'r-')
hold on
plot(t, repmat(.01, size(t)), 'k--', t, repmat(-.01, size(t)), 'k--')
title('System Response')
legend('x1', 'x2')

% save('Schur_HW5');
% evalin('base','load Schur_HW5');

end

function u=control(t,X)
x1=X(1);
x2=X(2);

s=x1+x2;
rho = abs(x1)*abs(x2)+x2^2+.2/5.5*abs(s);
beta0= 11;

eps=0.01;
u= -(rho+beta0)*sat(s/eps);
end

function y=sat(x)

if abs(x) < 1
    y=x;
else
    y=sign(x);
end

end

function X_dot=eom(t,X)
x1=X(1);
x2=X(2);

m = 5.5;
c1 = .04;
c2 = .01;
del = 0.1*sin(x1)+0.1*cos(x2);

u=control(t,X);

x1_dot=x2;
x2_dot=-c1*x2 - c2*x2*abs(x2)+ del + u;

X_dot=[x1_dot; x2_dot];
end