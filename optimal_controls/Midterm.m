%% MAE6292 Midterm
% Randy Schur
% 3/31/15

%% Problem  1
clear
close all
load('prob1_data.mat');

eps = 1e-5;
alpha = .1;
x = [ 3 3 3]';
A = P(1:2, 1:3, :);
b = P(1:2, 4, :);
ct = P(3, 1:3, :);
for i=1:N
   c(:,:,i) = ct(:,:,i)'; 
end
d = P(3,4,:);
d = squeeze(d);

count = 0;
Jx = 1;

hold on

while(norm(Jx) > eps)
   Jx = [0 0 0]';
   J= [0; 0]; 

  for i=1:N
    f = (A(:,:,i)*x + b(:,:,i)) * 1/(c(:,:,i)'*x+d(i));
    f_prime = -(A(:,:,i)*x+b(:,:,i))*c(:,:,i)'/(c(:,:,i)'*x +d(i))^2 + A(:,:,i)/ (c(:,:,i)'*x+d(i));
%     Jx = Jx + w(i)*(-y(:,i)'*f_prime - y(:,i)'*f_prime + f_prime'*f + (f'*f_prime)');
    Jx = Jx + w(i)*(-2*f_prime'*y(:,i) +2*f_prime'*f);
    J = J + w(i)*(y(:,i) - f);
  end
  
  count = count+1;
  x = x - alpha*Jx;
  plot(count, norm(J)) 
  drawnow;
end
title('Convergence of State Estimate')
ylabel('Norm of J_{x}')
xlabel('iterations')

x
J


%% Problem 2
%f
figure

N = 501;
tf = 2.412;
t = linspace(0, tf, N);
c = 1.146;

x = .5*c*(t - sin(t));
y = .5*c*(1 - cos(t));
plot(x, y)
hold on
plot(x, 1, 'r:')
plot(1, y, 'r:')
set(gca, 'Ydir', 'reverse')
axis equal
title('Cycloid curve')