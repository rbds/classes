%Randy Schur
%MAE 6258 HW 3
%2/4/15

%% Problem 1
clear 
close all
m=20;
wn = 15;
zeta =0.2;

k = [1000 2000 4000];
c = [10 50 100];

for i=1:length(k)
    for j=1:length(c)
        Kp(i) = 4500-k(i);
        Kv(j) = 120 - c(j);
        val(i,j) = sqrt(Kp(i)^2 + Kv(j)^2);
    end
end

k_and_c = val==min(min(val))
Kp = Kp(3)
Kv = Kv(3)


%% Problem 2
clear
close all

m=9.45;
k=8;
c=.974;
zeta = .056;
wn=.92;
num = 1;
den = [m c k]; 
G_uncontrolled = tf(num,den);
step(G_uncontrolled)

figure
m=9.45;
k=8;
c=.974;
zeta= .169;
wn= 1.032;
d_st = .0833;
kp=1/d_st-k;
ka=(k+kp)/wn^2 - m;
kv=zeta*2*sqrt((m+ka)*(k+kp))-c;
num = 1;
den= [(m+ka) (c+kv) (k+kp) ];
G_controlled = tf(num,den)
step(G_controlled)

%% Problem 3
clear
close all

m=150;
c=4000;
k= 6*10^6;
w=30;
Kp= -4.5*10^6;
Kv = 11000;
wn = 100;
zeta = 0.5;
T = .01;
sim('HW3_prob3');
sim1 = simout;
T = .1;
sim('HW3_prob3');
sim2 = simout;
T = 1;
sim('HW3_prob3');
sim3 = simout;
T = 10;
sim('HW3_prob3');
sim4 = simout;
T = 100;
sim('HW3_prob3');
sim5 = simout;
plot(sim1.time, sim1.signals.values, sim2.time, sim2.signals.values, sim3.time, sim3.signals.values, sim4.time, sim4.signals.values, sim5.time, sim5.signals.values)
legend('T = .01', 'T=.1', 'T=1', 'T=10', 'T=100')
title('System and Actuator Dynamics')
figure
T = 0;
sim('HW3_prob3')
sim6 = simout;
Kv = 0;
Kp = 0;
sim('HW3_prob3')
plot(sim6.time, sim6.signals.values, simout.time, simout.signals.values)
title('System Dynamics')
legend('Closed Loop', 'Open Loop')
% %b
m=150;
k=6*10^6;
c = 4000;
Kp = -4.5*10^6;
T=[.01 .1 1 10 100];
for i=1:length(T)
    figure
num = [T(i) 1 0];
den=[T(i)*m (T(i)*c+m) (T(i)*(k+Kp)+c) k+Kp];
G = tf(num,den);
rlocus(G)
title(strcat('Root Locus T =', num2str(T(i))))
end