function [t, x] = simulate()

  % setup time to simulate the box
  TIME = 10.0; % ten seconds

  % initialize x and t
  x = [];
  t = [];

  % setup the initial position and velocities
  q = [0 .5 0]';
  qd = [0 0 0]';

  % set the step size
  DT = 1e-3;

  % setup drawing steps
  DRAW_STEPS = .1/DT;

  % simulate
  for i=1:(TIME/DT)
    % save the height of the box and the current time
    x = [x; q'];
    t = [t; (i-1)*DT];

    % only draw every x steps
    if (mod(i,DRAW_STEPS) == 0) 
      draw(q);
      pause(1e-3);
    end

    % does fully implicit integration
%    [tout, yout] = ode15s(@boxode,[0 DT],[q;qd]);
%    q = yout(1:3);
%    qd = yout(4:6);

    % do semi-implicit integration
    qdqdd = boxode(0, [q; qd]);
    qdd = qdqdd(4:end);
    qd = qd + qdd*DT;
    q = q + qd*DT;

  end    
