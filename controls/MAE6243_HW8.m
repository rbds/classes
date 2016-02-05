%% MAE 6243 HW8
% Randy Schur
% 11/17/14

%% Problem 17.4D
l = 20;                     %[in]
d = linspace(0.1, 3, 100);  %[in]
E = 30*10^6;                %[psi]
I = pi*d.^4/64;             %[in^4]
w = .28*pi*(d/2).^2;        %[lb/in]
dst = 5*w.*l^4./(384.*E.*I);%[in]
g = 386;                    %[in/s^2]
n_c = sqrt(5*g./(4.*dst));  %[rad/s]
plot(d, n_c);
title ('Critical Speed vs. Shaft Diameter');
xlabel('Shaft Diameter [in]');
ylabel('Critical Speed [rad/s]');

%% Problem 17.5D
d = .25;                    %[in]
l = linspace(1,20,100);     %[in]
E = 30*10^6;                %[psi]
I = pi*d.^4/64;             %[in^4]
w = .28*pi*(d/2).^2.;       %[lb/in]
dst= 5*w.*l.^4./(384.*E.*I);%[in]
g = 386;                    %[in/s^2]
n_c = sqrt(5*g./(4.*dst));  %[rad/s]
plot(l, n_c)
title ('Critical Speed vs. Supported Length')
xlabel('Supported Length [in]')
ylabel('Critical Speed [rad/s]')