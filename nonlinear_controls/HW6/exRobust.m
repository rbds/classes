function exRobust
global theta k B epsilon
close all;

%theta=10;
k=1;
B=3;
epsilon=0.01;


N=501;
t=linspace(0,20,N);
x0=2;
[t x]=ode45(@eom,t,x0);



for i=1:N
    u(i)=control(t(i),x(i,:));
end

figure;plot(t,x);ylabel('x');
figure;plot(t,u);ylabel('u');

save tmp;
evalin('base','load tmp');
end


function x_dot=eom(t,x)
%global theta

u=control(t,x);

theta=1+0.5*sin(t);
phi=x^2+2*x;
x_dot=u+theta*phi;


end

function u=control(t,x)
global k B epsilon
 

phi=x^2+2*x;
mu=B*abs(phi)*x;
v=-mu/(abs(mu)+epsilon)*B*abs(phi);

u=-k*x+v;
end