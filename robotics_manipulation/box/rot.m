function R = rot(theta)

%   R(1,1) = cos(theta);
%   R(1,2) = -sin(theta);
%   R(2,1) = sin(theta);
%   R(2,2) = cos(theta);
R = [cos(theta), -sin(theta), 0;
    sin(theta), cos(theta), 0;
    0       0       1];
% R = R(1:2, 1:2);
  
end