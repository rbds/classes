%1/18/15 - wweek 3
%Randy Schur
%MAE 6258

m=150;
k=6*10^6;
c = 4000;
Kp = -4.5*10^6;

num = [1 0];
den=[m c k+Kp];
G = tf(num,den)
rlocus(G)
