%% MAE6258 HW10
%Randy Schur
%4/8/15

%% Problem 1
clear
close all
m = 0.2;
k=50000;
c=.1;
d = [2500 5000 7500 10000];
b = 0.25;
S0 = 1;

S = sqrt(pi*S0/(4*c*k));

num_breaks = zeros(1, 5);
cycles = zeros(1,5);

for i=1:4
    N(i) = d(i)./(S^b);
end
failure_level(:,1) = min(N)./N;
num_breaks(2) = 1;
cycles(2) = min(N);
for j = 2:4
    S = sqrt(pi*S0/((5-j)*c*k));
    for i=j:4
        N(i) = d(i)./(S^b);
    end
    n_cycles = (1 - failure_level(j,j-1))*N(j);
    failure_level(:,j) = failure_level(:,j-1) + n_cycles./N';
    num_breaks(j+1) = j;
    cycles(j+1) = cycles(j) + n_cycles;
end

%a
const = zeros(1,4);
time_broken= zeros(1,5);
for i=1:4
    S = sqrt(pi*S0/((5-i)*c*k));
    fn(i) = sqrt(k*(5-i)/m);
    const(i) = fn(i)./(2*pi*d(i))*(sqrt(2)*S^b)*gamma((b+2)/2);
    time_broken(i+1) = 1/(const(i));
end
plot(time_broken, num_breaks, 'x', time_broken, num_breaks, 'r')
title('Failures over time')
xlabel('Time (s)')
ylabel('sections broken')

%b
figure
plot(cycles, num_breaks, 'x', cycles, num_breaks, 'r')
axis([0 40000 0 5])
title('Failures vs. Cycles')
xlabel('Number of Cycles')
ylabel('sections broken')


%% Problem 2

% fatigue_failure.m
clear all;
close all;

% create linear system
m = 1;
c = [.05 .2  .5  1  5];
k = 25;


for i = 1:5
    G = tf(1,[m c(i) k]);
% create Gaussian white noise input
dt = .01;
N = 500000;
t = linspace(0,(N-1)*dt,N);
S0 = 1;
u = randn(N,1)*sqrt(2*pi*S0/dt);

% plot S_uu
R_uu = xcorr(u,'biased');
S_uu = fftshift(fft(R_uu));

% simulate system with input u, plot input vs. output
y = lsim(G,u,t);

% mean-square of output
% Ey2 = R_yy(N);
Ey2a = mean(y.^2);
Ey2_theory = pi/(c(i)*k);

% find (positive) peaks in y(t) and plot their magnitude distribution
[pks,locs] = findpeaks(y);
locs = locs(pks>0);
pks = pks(pks>0);
figure;
[nelements,centers] = hist(pks,50);
bar(centers,nelements/sum(nelements)/(centers(2)-centers(1)),'FaceColor',[.7 .7 1]);	% normalize histogram so its total area = 1

% add Rayleigh distribution curve
xlims = get(gca,'XLim');
x = linspace(xlims(1),xlims(2),101);
Ray_dist = (x/Ey2a).*exp(-x.^2/(2*Ey2a));
Gauss_dist = 2/(sqrt(2*pi)*sqrt(Ey2a)).*exp(-x.^2/(2*Ey2a));
hold on;
plot(x,Ray_dist,'r--');
plot(x, Gauss_dist, 'g--')
str = sprintf('Histogram with c = %1.1d', c(i) );
title(str)
ylabel('Probability');
xlabel('Peak magnitude');
legend('Rayleigh Distribution', 'Gaussian Distribution')
end
