clear
close all

n = 500;
t = linspace(0, 2*pi, n);
w = .5*randn(3, n); % zero mean noise

r = 20;
x = r*sin(t) + w(1,:);
y = r*cos(t) + w(2,:);
plot(x,y, '.', 'LineWidth', 4)
axis equal
print('circle', '-dpng')

r = 20;
x = r*sin(t) + w(1,:);
y = r*cos(t) + w(2,:);
plot(x(100:200),y(100:200), '.', 'LineWidth', 4)
axis equal
print('arc', '-dpng')

figure
m = 3;
y2 = m*t + w(3,:) ;
plot(t, y2, '.', 'LineWidth', 4)
axis equal
print('line', '-dpng')