clear all;
close all;

x=linspace(-2,4,100);
u=linspace(-4,2,100);
for i=1:100
    for j=1:100
        J(i,j)=1/2*x(i)^2+x(i)*u(j)+u(j)^2+u(j);
    end
end

contour(x,u,J',22);hold on;
plot([-2,4],[4 -2],'k');
xlabel('x');
ylabel('u');
axis equal;
