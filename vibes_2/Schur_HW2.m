%Randy Schur
%1/28/15

%% Problem 1
clear
close all
%a
m_empty = 1000; %[lbf]
m_full = 3000;
m = [m_empty];
k = 30000; %[lbf/ft.]
zeta = 0.2;
wn_empty = sqrt(k/m);
c_empty = zeta*2*m*wn_empty; %[lb/ft/s]
v = 55; %[mph]
w = 2*pi/((5280*55)/12); %1/hr.
syms s
G = 1./(s^2 + c_empty./m_empty*s +k./m_empty);
val_empty = abs(subs(G,1j*w));
u = 1/3; %[ft]
ampl_empty = val_empty*u %ft.

m = m_full;
k = 30000; %[lbf/ft.]
zeta = 0.2;
wn_full = sqrt(k/m);
c_full = zeta*2*m*wn_full; %[lb/ft/s]
v = 55; %[mph]
syms s
G = 1./(s^2 + c_full./m_full*s +k./m_full);
val = abs(subs(G,1j*w));
u = 1/3; %[ft]
ampl_full = val*u %ft.

% %b
wr = wn_full*sqrt(1-2*zeta^2);
spd_of_max_ampl = 12*2*pi/wr;

%c
v = linspace(0,100, 1001);
w = 2*pi./(v/12);
r = w/wn_full;
val_full = 1./sqrt((1-r.^2).^2+(2*zeta*r).^2);
n = find(val_full==max(val_full));
max_force_tansm = v(n) %[mph]

r = w/wn_empty;
val_empty = 1./sqrt((1-r.^2).^2+(2*zeta*r).^2);
plot(v, val_full)
n = find(val_empty==max(val_empty));
max_force_tansm = v(n)
plot(v, val_full./3, v, val_empty./3,'r', 24.86, val_full(250)/3, 'k*')
title('Driving Speed vs. Amplitude of Vibration')
xlabel('speed (mph)')
ylabel('Amplitude (ft.)')
legend('loaded', 'empty')

%% Problem 3
clear
close all
w = [0.2 1 2 2.6 2.8 3 3.4 3.6 3.8 4 5 6 7 8 9 10]; %[Hz]
x = [1 2 4 12 18 25 18 15 13 11 8 7 6 6 6 5];       %[mm]

m = 100; %[kg]
plot(w,x)
 
mR = .005/100;
wn = 3;
zeta = .1;
r = w./wn;
x_c = 1000*100.*mR.*r.^2./sqrt((1-r.^2).^2+(2*zeta.*r).^2);
hold on
plot(w, x_c, 'r')
legend('Given Data', 'Response from Estimated Values')
%b
r = 6/wn;
Ft = sqrt((1+(2*zeta*r).^2)./((1-r.^2).^2+(2*zeta.*r).^2))

%c
w = linspace(0, 10, 101);
r = linspace(0, 5, 101);
zeta = [0 .05 .1 .15 .2 ];
figure
hold on
for i=1:length(zeta)
    F(i,:) = sqrt((1+(2*zeta(i).*r).^2)./((1-r.^2).^2+(2*zeta(i).*r).^2));
end
plot(r, F)
title('Percentage of Force Transmitted vs. w/w_n for Different Values of \zeta')


