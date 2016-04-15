%% Prob. 3.
clear; close all

x = -5:.01:5;
V = @(x1, x2) 3/2*x1.^2 - x1.*x2 + x2.^2;
V_dot = @(x1, x2) -x1.^2.*(1 + x1.*x2) - x2.^2.*(1-2*x1.^2);
[X, Y] = meshgrid(x, x);

% colormap('default')
% surf(x, x, V(X,Y))
% figure
contourf(x,x, V(X,Y))
title('V(x_1, x_2)')
xlabel('x_1')
ylabel('x_2')
colorbar

x1 = 3;
x2 = -x1;
y1 = 1.5;
y2= -y1;
e = sqrt(1-(1/4)^2/(4^2));
 a = 1/2*sqrt((x2-x1)^2+(y2-y1)^2);
 b = a*sqrt(1-e^2);
 t = linspace(0,2*pi);
 X = a*cos(t);
 Y = b*sin(t);
 w = atan2(y2-y1,x2-x1);
 x = (x1+x2)/2 + X*cos(w) - Y*sin(w);
 y = (y1+y2)/2 + X*sin(w) + Y*cos(w)
 hold on
 plot(x,y,'y-')
% figure
% surf(x,x, V_dot(X,Y))
% colormap('default')


% figure
% contourf(x,x,V_dot(X,Y))
% title('Vdot(x_1, x_2)')
% xlabel('x_1')
% ylabel('x_2')
% colorbar
% x1 = 4;
% x2 = -4;
% y1 = 0;
% y2=0;
% e = sqrt(1-(1/4)^2/(4^2));
%  a = 1/2*sqrt((x2-x1)^2+(y2-y1)^2);
%  b = a*sqrt(1-e^2);
%  t = linspace(0,2*pi);
%  X = a*cos(t);
%  Y = b*sin(t);
%  w = atan2(y2-y1,x2-x1);
%  x = (x1+x2)/2 + X*cos(w) - Y*sin(w);
%  y = (y1+y2)/2 + X*sin(w) + Y*cos(w)
%  hold on
%  plot(x,y,'y-')
%  axis equal


%% Problem 5f
clear
close all

p0 = [0; 0; 0];
pdot0 = [0; 0; 0];
[t, p] = ode45(@midterm5, [0, 20], [p0; pdot0], []);

% t = linspace(0, 20, 1001);
pd = [sin(3*pi*t + pi/2), sin(2*pi*t), repmat(-1, size(t))];
pd_dot = [3*pi*cos(3*pi*t + pi/2), 2*pi*cos(2*pi*t), repmat(-1, size(t))];

plot3(p(:,1), p(:,2), p(:,3))
hold on 
plot3(pd(:,1), pd(:,2), pd(:,3), 'r-')
legend('p', 'pd')

% figure
% plot3(p(:,4), p(:,5), p(:,6))
% hold on 
% plot3(pd_dot(:,1), pd_dot(:,2), pd_dot(:,3), 'r-')
% legend('p_dot', 'pd_dot')

kp = 25;
kv = 5;
u = -kp*p(:,1:3) - kv*p(:,4:6);
max(abs(u))

figure
% plot(t, p(:,1), t, p(:,2), t, p(:,3))
plot(t, p(:,1:3))
axis([0 max(t) -5 5 ])
xlabel('t')
ylabel('e_{p}')
legend('ep(1)', 'ep(2)', 'ep(3)')
title('e_{p} vs. time')

figure
% plot(t, p(:,4), t, p(:,5), t, p(:,6))
plot(t, p(:,4:6))
% axis([0 max(t) -5 5 ])
xlabel('t')
ylabel('e_{v}')
legend('ev(1)', 'ev(2)', 'ev(3)')
title('e_{v} vs. time')

figure
plot(t, u)
xlabel('time')
ylabel('u')
title('u vs. time')
legend('u1', 'u2', 'u3')