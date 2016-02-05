%% MAE6258 HW12
%Randy Schur
%4/22/15

%%Problem 1
%a
clear 
close all

wc = 16;
beta = 20;
m=100;
k=20000;
S0 = 1;

N = [S0*beta^2 0; -1 wc^2];
detn =  det(N);
D = [beta 0; -1 wc^2];
detd = det(D);
pi*S0*beta
pi/1*detn/detd
    
%b 
mu = .097;
p = 0.8713;
zeta = 0.14;

%c
wn = sqrt(k/m);
w = logspace( -1, 1.5, 1000);
b = beta/wn;
r = w./wn;
rc = wc/wn;

Sff = S0*b^2*r.^2./((rc^2 - r.^2).^2 + (b^2*r.^2).^2);
G_ir_2 = 1/sqrt(2*pi*beta*S0)*((r.^2 - p^2)+(2*zeta.*r).^2)./((mu*p^2.*r.^2 - (r.^2-1).*(r.^2 -p^2)).^2 + (2*zeta.*r).^2.*(r.^2 + mu*r.^2 -1).^2);
Sxx = abs(G_ir_2).*Sff;
G_noDVA = 1./abs(r.^2-1);
Sxx_noDVA = G_noDVA.*Sff;
plot(r, 20*log10(Sff), r, 20*log10(Sxx), r, 20*log10(Sxx_noDVA))
legend('Sff', 'S_{\xi\xi} with DVA', 'S_{\xi\xi} without DVA')
xlabel('r')
ylabel('dB')

%d 
dr = r(2) - r(1);
dst = sqrt(wn*S0)/k;
G = b.*r.^2./((rc^2-r.^2).^2+(b*r.^2).^2);
E_x2 = 1/(2*pi)*S0/k^2*trapz(G.*wn);
E_xi2 = E_x2/dst^2
