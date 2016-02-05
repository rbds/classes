function x_dot = HW1_1( t,x )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
g = 9.81;
l = 5;
c = 0.8;

theta = x(1);
theta_dot = x(2);

theta_ddot = -g/l*sin(theta) - c*theta_dot;
x_dot = [theta_dot; theta_ddot];

end

