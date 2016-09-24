function ex160418
close all;

X0=[1 1]';
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


save('ex160418');
evalin('base','load ex160418');

end

function u=control(t,X)
x1=X(1);
x2=X(2);

s=x1+x2;
rho=abs(x2)+2*x2^2*abs(cos(3*x1));
beta0=1;

eps=0.001;
u=-(rho+beta0)*sat(s/eps);
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

a=1.5+0.5*cos(t);
u=control(t,X);

x1_dot=x2;
x2_dot=-a*x2^2*cos(3*x1)+u;

X_dot=[x1_dot; x2_dot];
end
