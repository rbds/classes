% random_signal_estim_mean.m

clc;
clear all;
close all;

n = 1000;
x_u = rand(n,1);			% uniform distribution
x_g = randn(n,1);			% normal distribution

% plot time series
figure;
plot(1:n,x_u);
figure;
plot(1:n,x_g);

% plot histogram
figure;
[count,x_cent] = hist(x_u,50);
bar(x_cent,count/sum(count)/(x_cent(2)-x_cent(1)));	% normalize histogram so its total area = 1

% plot analytical distribution
x_an = linspace(x_cent(1),x_cent(end),101);
y_an = ones(size(x_an));
hold on;
plot(x_an,y_an,'r');

% plot histogram
figure;
[count,x_cent] = hist(x_g,50);
bar(x_cent,count/sum(count)/(x_cent(2)-x_cent(1)));	% normalize histogram so its total area = 1

% plot analytical distribution
x_an = linspace(x_cent(1),x_cent(end),101);
y_an = 1/sqrt(2*pi)*exp(-x_an.^2/2);
hold on;
plot(x_an,y_an,'r');

%% In class
clear 
clc
close all

n = 1000;

x_u = rand(n,1);			% uniform distribution
x_g = randn(n,1);			% normal distribution

% plot time series
% figure;
% plot(1:n,x_u);
% figure;
% plot(1:n,x_g);

% plot histogram
% figure;
[count,x_centu] = hist(x_u,50);
[count,x_centg] = hist(x_g, 50);

N=100;
for i=1:(n/N)
   avg100(i) = mean(x_u((i-1)*N+1:i*N));
   var100(i) = var(x_g((i-1)*N+1:i*N));
end

N=10;
for i=1:(n/N)
   avg10(i) = mean(x_g((i-1)*N+1:i*N));
   var10(i) = var(x_g((i-1)*N+1:i*N));
end
mean(avg100)
mean(avg10)
% var(avg10)
% var(avg100)
% figure(1)
% clf
plot(avg100)
figure(2)
% clf
plot(avg10)