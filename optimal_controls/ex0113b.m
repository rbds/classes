clear all;
close all;

x=linspace(-2,4,100);
u=linspace(-4,2,100);
for i=1:100
    for j=1:100
        J(i,j)=1/2*x(i)^2+x(i)*u(j)+u(j)^2+u(j);
    end
end

contour(x,u,J',22);hold on
plot([-2,4],[4 -2],'k')
xlabel('x');
ylabel('u');
axis equal

u=2;
eps=1e-6;
Hu=1;
k=0.1;
while norm(Hu)> eps
   x=2-u;
   plot(x,u, 'r*')
   Jx = x+u;
   fx=1;
   lam= -Jx*inv(fx);
   Ju = x+2*u+1;
   fu = 1;
   Hu = Ju+lam*fu;
   u=u-k*Hu;
   
   drawnow
end

plot(x,u, 'k*')