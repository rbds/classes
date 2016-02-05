%% MAE6292 HW2
%Randy Schur
%2/10/15

%% Problem 1
clear
c1 = @(t) sqrt(4 - (t-5)^2)/(t-5);
c2 = 5;
f = @(t)  sqrt(4-(t-5)^2)/(t-5)*t + 5 - sqrt(4-(t-5)^2);
tf = fsolve(f,4)
c1(tf)
%% Problem 2