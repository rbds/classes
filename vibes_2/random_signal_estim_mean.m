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