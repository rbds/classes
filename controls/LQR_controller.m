clear

m = 1;
g = 9.81;
I=2;
A=[0 1 0 0;0 0 -g 0; 0 0 0 1; -m*g/I 0 0 0];
B = [0 0 0 1/I]';
C = [0 0 1 0];
e_val = eig(A);     %unstable

% % controllability
ctrl = ctrb(A,B);         %controllability matrix for system.
rank(ctrl)
obs = obsv(A,C);
rank(obs)

Q = eye(4);
R = 1;
[K,S,E] = lqr(A, B, Q, R);
damp(A-B*K)             %find poles, natural frequencies, damping ratios.

G = [0 1 0 0; 0 0 0 1]';
V = .01^2.*eye(2);
W = (.1*pi/180)^2;

LT = lqr(A', C', G*V*G', W);
L = LT'
damp(A-L*C)