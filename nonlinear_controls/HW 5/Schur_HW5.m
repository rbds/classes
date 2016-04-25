function Schur_HW5
close all;

X0=[pi/4 0]';
N=501;
t=linspace(0,20,N);
[t X]=ode45(@eom,t,X0);

x1=X(:,1);
x2=X(:,2);
for k=1:N
    u(k)=control(t(k),X(k,:)');
end

figure;
plot(x1,x2);hold on;
plot([-1 1],[1, -1],'r--');
title('\theta vs. $\dot{\theta}$')
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
dmax = 0.6783;
beta=2*dmax;

eps=0.01;
u=-(beta)*sat(s/eps);
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

m = 1;
k=.1;
l = 1;
g = 9.81;
h = sin(2*t);

a = g/l;
b = k/m;
c = 1/(m*l^2);
z = h/l;
u=control(t,X);

x1_dot=x2;
x2_dot=-a*sin(x1)-b*x2+c*u+z*cos(x1);

X_dot=[x1_dot; x2_dot];
end
