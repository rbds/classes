%% Box contact force simulation
%CSCI 6525
%Randy Schur
clear
clf

t_end = 10;
dt = 1e-3;
n_steps = t_end/dt;

x = zeros(6, n_steps);
t = linspace(0, t_end, n_steps);

%ICs
q = [0 5 2]';
q_dot = [3 1 pi/2]';
% q_dot = [0 0 0]';
x(:,1) = [q; q_dot];

%constants
constants.g = 9.807;

constants.kp = 70000;
constants.kv = 450;
constants.w = 1;  %box width and height
constants.l = 1;
constants.m = 10;  %mass
constants.J = 1/12*constants.m*(constants.w^2 + constants.l^2);
constants.mu = 0.5;    %coeff of friction.
state = [q; q_dot];


% u = [constants.w/2, -constants.w/2, -constants.w/2, constants.w/2;
%     constants.l/2,  constants.l/2, -constants.l/2, -constants.l/2];

for i=1:n_steps
   if (mod(i,10)==0) 
      draw(state(1:3), constants)
      drawnow
%       pause(.001)
   end
   
[state, state_dot] = my_box_ode(t(i), state, dt, constants);  
 x(:,i+1) = state;
 t(i);
%  if i ==n_steps*4/5
%     t(i) ;
%  end
end

% plot(t, x(:,1), t, x(:,2))
