function SDOF_time_resp()

clc;
clear all;
close all;

% constants
m = 2;
c = 40;
k = 108;
l = 0.3;
l1 = 0.1;
l2 = 0.15;

% initial conditions
x0 = 0.1;
xdot0 = 0;

t = linspace(0,4,401);      % time vector for plotting, 401 points between 0 and 4

% solution via Laplace transform using residue
num1 = [m*x0 m*xdot0+c*(l2/l)^2*x0]             % numerator of free response
den1 = [m c*(l2/l)^2 k*(l1/l)^2]                % denominator of free response
num2 = [-l1/l]                                  % numerator of forced response
den2 = [m c*(l2/l)^2 k*(l1/l)^2 0]              % denominator of forced response

% compute partial fraction expansion coefficients
[r1,p1] = residue(num1,den1)
[r2,p2] = residue(num2,den2)

x1 = r1(1)*exp(p1(1)*t) + r1(2)*exp(p1(2)*t) + r2(1)*exp(p2(1)*t) + r2(2)*exp(p2(2)*t) + r2(3)*exp(p2(3)*t);
plot(t,x1);
title('Solution via Laplace transform using residue');

% solution via Laplace transform using Symbolic Math toolbox
s = sym('s');
X_sym = (m*x0*s + m*xdot0+c*(l2/l)^2*x0)/(m*s^2 +  c*(l2/l)^2*s +  k*(l1/l)^2) + -l1/l/((m*s^2 +  c*(l2/l)^2*s +  k*(l1/l)^2)*s)
x_sym = ilaplace(X_sym)     % inverse Laplace transform
x2 = subs(x_sym,t);   % substitute t vector for 't' in symbolic output

figure;
plot(t,x2);
title('Solution via Laplace transform using Symbolic Math toolbox');

% solution via state space
A = [0 1; -k/m*(l1/l)^2 -c/m*(l2/l)^2]
B = [0 -l1/l/m]'
C = [1 0]
D = 0
sys = ss(A,B,C,D);              % construct state space object
u = ones(size(t));              % vector of ones representing the unit step input
x3 = lsim(sys,u,t,[x0 xdot0]);  % linear system simulation

figure;
plot(t,x3);
title('Solution via state space');

% solution via ode45
[t,x] = ode45(@eom_fun,t,[x0 xdot0]');
x4 = zeros(size(t));
for i = 1:length(t)
    x4(i) = C*x(i,:)';
end

    % equation of motion (EOM) function called by ode45, returns derivatives of states
    function x_dot = eom_fun(this_t,this_x)
        
        this_u = 1;
        x_dot = A*this_x + B*this_u;
        
    end

figure;
plot(t,x4);
title('Solution via ode45');

end
