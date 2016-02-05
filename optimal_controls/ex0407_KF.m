clear all;
close all;

h=0.1;
t=0:0.1:20;
N=length(t);

A=[1 h;0 1];
B=[h^2/2 ; h];
H=[1 0];

sigma_p=1e-6;
sigma_v=4e-4;
sigma_mu=0.1;

Q=diag([sigma_p^2, sigma_v^2]);
R=sigma_mu^2;

x0=[0 0]';
P0=eye(2);

wp=normrnd(0,sigma_p,1,N);
wv=normrnd(0,sigma_v,1,N);
w=[wp;wv];
mu=normrnd(0,sigma_mu,N,1);

u=0.01;
