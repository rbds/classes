% evaluates the derivative for the box in 2D suitable for integration with
% MATLAB
% t the current time (will be unused)
% y(1) will be the horizontal position of the box
% y(2) will be the vertical position of the box
% y(3) will be the 2D angular orientation of the box
% y(4) will be the time derivative of the horizontal position (horizontal
%      component of linear velocity)
% y(5) will be the time derivative of the vertical position (vertical
%      component of linear velocity)
% y(6) will be the time derivative of the angular orientation (angular velocity)
% ydot(1) will be the time derivative of the horizontal position of the box
%         (horizontal component of linear velocity)
% ydot(2) will be the time derivative of the vertical position of the box
%         (vertical component of linear velocity)
% ydot(3) will be the time derivative of the angular orientation of the box
%         (angular velocity)
% ydot(4) will be the second time derivative of the horizontal position of the
%         box (horizontal component of linear acceleration)
% ydot(5) will be the second time derivative of the vertical position of the
%         box (vertical component of linear acceleration)
% ydot(6) will be the second time derivative of the orientation of the
%         box (angular acceleration)
function ydot = boxode(t, y)

  % set gravity
  g = 9.81;

  % make sure y is in the right format
  if (size(y,1) == 1)
    y = y';
  end

  % TODO: get the state of the box, call position of the box xtheta_box and
  %       the velocity of the box dot_xtheta_box

  % setup the mass of the box 
  m_box = 10.0;

  % setup the mass "matrix" 
  % the box width is 1 and height is .25
  % inertia matrix for a box is
  % 1/12*m*(w^2 + h^2)
  % setup width/height 
  w_box = 1.0;
  h_box = 1.0;
  % TODO: now setup moment of inertia
  % hint: J_box is given below
  J_box = 1/12*m_box*(w_box^2 + h_box^2); 

  % setup the big mass matrix 
  M = diag([m_box m_box J_box]);

  % compute the gravitational forces on the box 
  fg = [0 -g*m_box 0 ]';

  % get rotation matrix for the box 
  R_box = rot(xtheta_box(3));

  % TODO: setup the four points on the bottom of the box
  
  % TODO: get the points of the box in the world frame 

  % set contact forces to zero initially
  fc = zeros(3,1);

  % TODO: check whether the vertical component of each corner of the
  % box is below 0.0 (fill in the parentheses below)
  for i=1:4
    if ()
 
      % TODO: get the interpenetration depth at the bottom-most corner of the
      % box 

      % TODO: compute the velocity at the corner of the box

      % TODO: setup spring and damper constants 
      KP = ;
      KV = ;

      % TODO: compute contact force using interpenetration depth, vertical
      %       component of the velocity of the lowest box corner, and KP and KV 
      fN = ; 

      % TODO: make sure normal force is compressive (don't pull bodies together)

      % compute sliding friction forces using mu (def'd below); if the 
      % horizontal velocity is *nearly* zero, apply no frictional force.
      % Otherwise apply a force opposite to the direction of motion.
      mu = 0.5;
      fF = ;
 
      % TODO: compute the contact forces on this corner of the box (add to fc)
    end
  end

  % TODO: solve for the accelerations

  % TODO: set ydot

