function [ x_plus, x_dot ] = my_box_ode(t, x, h, constants )

    k1 = eom(t, x, constants);
    k2 = eom(t + h/2, x + h/2*k1, constants);
    k3 = eom(t + h/2, x + h/2*k2, constants);
    k4 = eom(t + h, x + h*k3, constants);

    x_plus = x + h/6*(k1 + 2*k2 + 2*k3 + k4);
    x_dot = k1;
end

function [ q_dot ] = eom(~, q, constants)
u = [constants.w/2, -constants.w/2, -constants.w/2, constants.w/2;
     constants.l/2,  constants.l/2, -constants.l/2, -constants.l/2];
 
 %calculate minimum point  
   R = rot(q(3));
   R_dot = drot(q(3), q(6));
   
   corners = R(1:2, 1:2)*u + repmat(q(1:2), 1, 4);
   corners_vel = R_dot(1:2, 1:2)*u + repmat(q(4:5), 1, 4);
 %calculate force  
%   phi = q(2) + R(2,1:2)*u;
%   phi_dot = q(5) + R_dot(2,1:2)*u;

i_min = find(corners(2,:) == min(corners(2,:)));
q_min = corners(:,i_min);
q_dot_min = corners_vel(:,i_min);
if (q_min(2,1) < 0)
    fc = -constants.kp*q_min(2,1) - constants.kv*q_dot_min(2,1);
else
   fc = 0; 
end
     q_dot(1:3) = q(4:6);
     q_dot(4) = 1/constants.m * constants.mu*fc * -1*sign(q(4));
     q_dot(5) = (-constants.g + 1/constants.m*fc);

        if ( length(i_min) > 1)
           q_dot(6) = 0;
        else

        %     fc = -constants.kp*q_min(2,1) - constants.kv*q_dot_min(2,1);
              if (abs(q_dot_min(1)) < 1e-6)
                fF = 0;
              else
                fF = -sign(q_dot_min(1))*constants.mu*fc;
              end
            temp = 1/constants.J*cross([q_min - q(1:2) ; 0], [fF; fc; 0]);
            q_dot(6) = temp(3);
        end

% if( q_min(2) < 0)
%    fc = -constants.kp*min(phi) - constants.kv*min(phi_dot); 
% else
%     fc = 0;
% end


%   if (length(find(phi==min(phi))) > 1)
%      q_dot(6) = 0;      %if two points are at an equal minimum, the moment applied will cancel out.
%   else
     
%      r = [q(1:2) - R(1:2, 1:2)*u(:,i_min); 0];
%      mom = cross(r, [constants.mu*fc; fc; 0]);
%      if(min(phi) < 0)
%         q_dot(6) = 1/constants.J*mom(3);
% %                 z = R(1:2, 1:2)*u(:,i_min); 
%             q_dot(6) = 1/constants.J* (q(2)-z(2))*fc;
%      else
%          q_dot(6) = 0;
%      end
%   end
  q_dot = q_dot';
end