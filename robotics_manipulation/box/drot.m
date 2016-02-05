function Rdot = drot(theta, thetadot)
w_squiggle = [0 -thetadot 0;
              thetadot 0 0;
              0   0     0];
    R = [cos(theta), -sin(theta), 0;
        sin(theta), cos(theta),   0;
        0,          0,            1];

    Rdot = w_squiggle*R;
%     Rdot = Rdot(1:2, 1:2);
%     
%   Rdot(1,1) = -sin(theta);
%   Rdot(1,2) = ;
%   Rdot(2,1) = ;
%   Rdot(2,2) = ;

end