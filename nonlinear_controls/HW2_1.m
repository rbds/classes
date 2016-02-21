function x_dot = HW2_1( t,x )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

x1 = x(1);
x2 = x(2);

x1dot = -6*x1/((1+x1^2)^2) + 2*x2;
x2dot = -(2*x1 + 2*x2)/((1+x1.^2)^2);

x_dot = [x1dot; x2dot];

end


