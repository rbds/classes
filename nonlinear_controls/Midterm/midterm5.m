function [ p_dot] = midterm5( t,p )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
g = 9.81;
m = 0.5;
kp = 25;
kv = 5;

pd = [sin(3*pi*t + pi/2); sin(2*pi*t); -1];
pd_dot = [3*pi*cos(3*pi*t + pi/2); 2*pi*cos(2*pi*t); -1];

ep = p(1:3) - pd;
ev = p(4:6) - pd_dot;

u = -kp*ep - kv*ev; %reduction of u leaves ev_dot equivalent.

ev_dot = u/m;
p_dot = [ev; ev_dot];


end

