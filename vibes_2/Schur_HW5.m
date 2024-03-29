%% Schur_HW5
%Randy Schur
%MAE 6258
%2/18/15

%% Problem 1
clear
close
% figure
% a

m1 = 3;
w1_rpm = 1400;
w1 = w1_rpm*2*pi/60;
wn = w1;
k1 = m1*w1^2;
mu1 = .0675;
m_eff = m1/mu1;

ampl = sqrt(10);
mu_a = 2/(ampl^2 - 1);
p_a = 1/(1+mu_a)*1.1;
ma = mu_a*m_eff
wa = p_a*wn;
ka = wa^2*ma
zeta_a= sqrt(3*mu_a/((8*(1+mu_a)^3)));
c = zeta_a*2*ma*wn

% b
pk =  10^0.4; % Use a max. amplitude of 8 dB, less than 10 with a safety factor.
mu_b = 2/(pk - 1);
zeta_b = 1/sqrt(2*(mu_b+1)*(mu_b+2));
p_b=1;


% c
r = logspace( -1, 1, 1000);
wk = r*1400;
X_1 = 1./abs(1 - r.^2);
X_a = abs((r.^2 - p_a^2)+(2*zeta_a.*r).^2)./abs((mu_a*p_a^2.*r.^2-(r.^2-1).*(r.^2-p_a^2)).^2 + (2*zeta_a.*r).^2.*(r.^2+mu_a.*r.^2 -1).^2);
X_b = abs((r.^2 - p_b^2)+(2*zeta_b.*r).^2)./abs((mu_b*p_b^2.*r.^2-(r.^2-1).*(r.^2-p_b^2)).^2 + (2*zeta_b.*r).^2.*(r.^2+mu_b.*r.^2 -1).^2);
semilogx(wk, 20*log10(X_1), wk, 20*log10(X_a), wk, 20*log10(X_b), wk, repmat(10, [1 1000])) 
x = linspace(-40, 60, 100);
y1 = repmat(1000, size(x));
y2 = repmat(1500, size(x));
max(X_a)
hold on
% semilogx(y1, x, 'k:', y2, x, 'k:')
title('System Frequency Response')
xlabel('RPM')
ylabel('Amplitude (dB)')
legend('No DVA', 'With DVA (a)', 'With DVA(b)', '10 dB')

%% Problem 2
clear
close all
zeta = .05;
x = linspace(0, 1, 1000);
k=6; %number of modes to use.
xa = .125;
r = logspace(-1, 1, 1000);
s = 1j*r;
w = 0;
for i =1:k
   phi(i,:)  = sin(k.*pi.*x); 
   beta4(i) = (i*pi)^4;
   wk(i) = sqrt(beta4(i));
   phi_xa(i) = sin(i*pi*xa);
   Gtilde(i, :) = 1./(s.^2 + 2*zeta.*wk(i).*s + wk(i).^2);
    A(i,:) = abs(Gtilde(i,:)).*phi_xa(i)+1;
    w =w+ A(i,:).*phi(i,:);
end

semilogx(r, 20*log10(w))