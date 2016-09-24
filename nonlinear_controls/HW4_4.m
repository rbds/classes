function x_dot = HW4_4( t,x )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


xd1 = -3/2*x(1)^2-1/2*x(1)^3-x(2);
xd2 = x(1) - 3/2*x(1)^4 - 3*x(1)*(x(2)-3/2*x(1)^2) - (x(2)-3/2*x(1)^2);

x_dot = [xd1; xd2];

end

