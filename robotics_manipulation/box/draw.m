% draws the box 
function draw(y, constants)

  if (size(y,1) == 1)
    y = y';
  end

  % get the state of the box 
  xtheta_box = y(1:3);

  % get rotation matrix for the box 
  R_box = rot(xtheta_box(3));

  % setup the four points on the bottom of the box
  u(1,:) = [  constants.w/2 constants.l/2 ];
  u(2,:) = [ -constants.w/2 constants.l/2 ];
  u(3,:) = [ -constants.w/2 -constants.l/2 ];
  u(4,:) = [ constants.w/2 -constants.l/2 ];

  % get the points of the box in the world frame
  for i=1:4
    p(i,:) = xtheta_box(1:2)' + u(i,:)*R_box(1:2, 1:2);
  end

  % setup points for the ground 
  v_ground_x = [-10 15 15 -10]; 
  v_ground_y = [-5 -5 0 0];

  % now draw the shapes
  fill(v_ground_x, v_ground_y, 'r');
  hold on;
  fill(p(:,1), p(:,2), 'b');
  hold off;

  % setup the axes 
  axis([-5 15 -5 15]);
 
