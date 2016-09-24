clear all
close all

syms x1 x2 x3 x4 m l J k real

x = [x1 x2 x3 x4]';
% k=5;
% m=3;
% J=4;
% l=2;

f = [x3, x4, k*(x2-x1)/J, -m*9.81*l*sin(x2) - k*(x2-x1)]';
g = [0 0 1/J 0]';
h = x2;
% h=x1;
% g = [0 1 0]';
% f = [x2+2*x1^2, x3, x1-x3 ]';

Lfh = lieDiff(h, f, x)
Lf2h = lieDiff(h, f, x, 2)
LgLfh = lieDiff(lieDiff(h, f, x), g, x)
LgLf2h = lieDiff(lieDiff(h, f, x, 2), g, x)
Lf3h = lieDiff(h, f, x, 3)

