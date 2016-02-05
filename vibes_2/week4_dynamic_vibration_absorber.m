close all
clear

res = 3000; %[rpm]
wn = res*2*pi/60; %[rad/s]

ma1 = 2; %[kg]
w1 = wn;    
p=1;

eq = @(u) -(2500/3000)^2+ (u+2-sqrt((u+2)^2-4))/2; 
mu = fzero(eq, .5);
r = logspace(-1,1,1000);
%baseline system, no DVA
X_no = 1./abs(1-r.^2);

%tuned DVA 1 , used to find effective mass of the system.
p=1;
X_1 = abs(p^2-r.^2)./abs((1-r.^2).*(p^2-r.^2) - mu*p^2.*r.^2);

%tuned DVA 2 
mu2 = .89; %found from chosen value of r1_hat, which is outside operating range
X_2 = abs(p^2-r.^2)./abs((1-r.^2).*(p^2-r.^2) - mu2*p^2.*r.^2);

w=3000*r;
semilogx(w, 20*log10(X_no), w, 20*log10(X_1), w, 20*log10(X_2))
title('Deflection with DVAs')
hold on 
x = linspace(-40, 60, 100);
y1 = repmat(2000, size(x));
y2 = repmat(4000, size(x));
semilogx(y1,x, 'k:', y2, x, 'k:')
legend('Base - no DVA', 'DVA 1 - p=1', 'DVA 2 - resonance outside range', 'operating range')

%%
close all
clear

r = logspace(-1,1,1000);
A = 10^.5;
r1 = 2/3;
r2 = 4/3;
phi1 = (-1/A + r1^2 -1)^(-1);
phi2 = (-1/A + r2^2 -1)^(-1);
p3_sq = r1^2*r2^2*(phi2-phi1)/(r2^2*phi2 - r1^2*phi1);
p3 = sqrt(p3_sq);
mu3 = (r2^2 - r1^2)/(r1^2*r2^2*(phi2-phi1));
X_3 = abs(p3^2-r.^2)./abs((1-r.^2).*(p3^2-r.^2) - mu3*p3^2.*r.^2);
w = 3000*r;
semilogx(w, 20*log10(X_3))