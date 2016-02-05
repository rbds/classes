%Randy Schur
%MAE 6257 HW 4
%10/2/14
clear
close all
% Problem 1

%constants
m = 1;
k = 15000;
wn = sqrt(k/m);
zeta = .1;
c = zeta*2*m*wn;
n_cycles = 5;
del_t = .05;
t = 0:del_t:.6*n_cycles;         %time vector
F1 = [0 15 22 28 35 30 25 40 5 -15 -35 -29];  %Force, taken from the problem
F = F1;
for k = 1:n_cycles-1
F = cat(2, F,F1);
end
F(end +1) = 0;
N = length(F) -1;  
tau = N*del_t;
w = 1/tau;
r = w/wn;

a0 = 2/N*sum(F);
for j = 1:100
    for i = 1:length(t)
       c(i) = F(i)*cos(2*j*pi*t(i)/tau); %placeholder to collect terms
       d(i) = F(i)*sin(2*j*pi*t(i)/tau);
    end
   a(j) = 2/N*sum(c); %aj and bj terms
   b(j) =  2/N*sum(d);
end
for i= 1:length(t)
    for j = 1:length(a)
       aterms(j) = a(j) * cos(j*w*t(i)); %placeholder to collect terms
       bterms(j) = b(j) * sin(j*w*t(i));
    end
    force(i) = a0/2 + sum(aterms) + sum(bterms); %F(t) = a0/2 + a(j)*cos(jwt) +b(j)*sin(jwt)
end 

plot(t, F, t, force)
legend('F(t) given', 'F(t) approximation')
title('Forcing function and Fourier approximation, Problem 1')
xlabel('time (s)')
ylabel('Moment from Driven Gear (N/m)')
%% Problem 2
clear

J = .1;
k = 392700;
wn = sqrt(k/J);
w = 1000/60*2*pi;
tau = 2*pi/w;
zeta = 0;
r = w/wn;

for j = 1:10
   a(j) = 2*15000/16*tau/(2*pi)/j*sin(5.89*j);
   b(j) = 17.9/j*(cos(5.89*j) -1);
end

t = 0:.01: 2;
a0 = 2/tau*(1000*15/16*tau);

for i=1:length(t)
    for j=1:length(a)
        aterms(j) = a(j)*cos(j*w*t(i));
        bterms(j) = b(j)*sin(j*w*t(i)); 
        as(j) = a(j)/k/((1-j^2*r^2)^2)*cos(j*w*t(i));
        bs(j) = b(j)/k/((1-j^2*r^2)^2)*sin(j*w*t(i));
    end
    
    M(i) = a0/2 + sum(aterms) + sum(bterms);
    x(i) = a0/(2*k) + sum(as) + sum(bs);
end

close all
plot(t,M)
title('Forcing function and Fourier approximation, Problem 2')
figure(2)
plot(t, x)
title('Steady State response')
