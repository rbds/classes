% two_mode_colloc_v_noncolloc.m

clc;
clear all;
close all;

w_n = [2 5];
zeta = [0.01 0.03];

G_col = tf(0.1,[1 2*zeta(1)*w_n(1) w_n(1)^2]) + tf(0.08,[1 2*zeta(2)*w_n(2) w_n(2)^2]);		% both residues are positive
G_ncol = tf(0.1,[1 2*zeta(1)*w_n(1) w_n(1)^2]) + tf(-0.08,[1 2*zeta(2)*w_n(2) w_n(2)^2]);	% one positive, one negative residue
K = tf([1 0.2],[1 0.5]);		% lead compensator

pG_col = pole(G_col)
zG_col = zero(G_col)

pG_ncol = pole(G_ncol)
zG_ncol = zero(G_ncol)

% root locus plots
figure;
rlocus(K*G_col);
% axis([-1 1 -20 20]);

figure;
rlocus(K*G_ncol);
% axis([-1 1 -20 20]);

% Bode plots with gain and phase margins
figure;
margin(K*G_col);

figure;
margin(K*G_ncol);