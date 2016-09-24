clear all
close all

syms x1 x2 x3 x4 real

x = [x1 x2 x3 x4]';

f = [x3, x4, x1+x1*x2-2*x3]';
g = [0 1 0]';
h = x1*x1-2*x3;
% h=x1;
% g = [0 1 0]';
% f = [x2+2*x1^2, x3, x1-x3 ]';

Lfh = lieDiff(h, f, x);
Lf2h = lieDiff(h, f, x, 2);
LgLfh = lieDiff(lieDiff(h, f, x), g, x);
