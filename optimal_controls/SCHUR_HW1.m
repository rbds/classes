%% MAE 6292 HW1
%Randy Schur
%1/27/15

%% Problem 2.
clear all
close

Q = [3 1 1; 1 2 0; 1 0 1];
R = eye(2);
B= [1 1; 1 0; 0 1];
c=[1 -1 0]';
% 

u=[10, 10]';
eps= 1e-5;
Hu=1;
k= 0.1;
lam = 1;
while norm(Hu)> eps
    x = -(B*u +c);
    Jx = x'*Q;
    fx = 1;
    lam= (-Jx/(fx))';
    Ju = u'*R;
    
   fu = 1;
   Hu = Ju+lam'*B;
   u=u-k*Hu';
end
u
ustar = -(R+B'*Q*B)\B'*Q*c
x
xstar = -(eye(3) - B/(R+B'*Q*B)*B'*Q)*c
lam
lam_star = (inv(Q) + B/R*B')\c

%% Problem 3
clear
clc

lam = linspace(0, 10, 1001);
alph = [1 2 3];
eps = .01;
f = 10;
i=1;
while (abs(f) > eps)
    i = i+1;
    f = sum(max(0, 1/lam(i) - alph)) - 1;
end
lam = lam(i)
x = max(0, 1/lam - alph)
mu = -1./(x + alph) + lam