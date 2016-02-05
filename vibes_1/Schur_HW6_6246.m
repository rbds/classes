%% MAE 6243 Homework 6
%Randy Schur

%% Problem 1
a = [-3 0 0 0; 0 0 0 0; 0 0 1 0; 0 0 0 2];
b = [10 20 0 0;-20 -30 0 0; 0 0 -12 6; 0 0 6 -12];
c = [10 20 0 0; -20 -40 0 0; 0 0 -9 9; 0 0 9 -9];
d = [-8 -1 0 0; 4 -4 0 0; 0 0 -4.5 4.5; 0 0 -4.5 4.5];

[Va, Da] = eig(a);
stbla = diag(Da)    % a) is unstable
[Vb, Db] = eig(b);
stblb = diag(Db)    %b is asymptotically stable
[Vc, Dc] = eig(c);
jordan(c)
stblc = diag(Dc)    %c is stable (not a.s.)
[Vd, Dd] = eig(d);
stbld = diag(Dd)    %d is unstable (Jordan block size is 2)
jordan(d)
%% Problem 2
A = [2 2 1; 5 3 6; -5 -1 -4];
B = [1 0 0]';
C = [1 1 2];

Ctrl = ctrb(A,B);       %rank = 2, not fully controllable
[Q, S, V]= svd(Ctrl);
Ac = Q\A*Q; Ac = Ac(3, 3);
[v,d] = eig(Ac);
stbl = diag(d);     %System is not stabilizable.

%% Problem 3
A = [0 1 0; 0 0 1; 24 14 -1];
B = [0 0 1]';
C = [2 -1 1];
%a
Ctrl = ctrb(A,B) %matrix has rank n, system is controllable
%b
poles = [ -5-5*1i, -5+5*1i, -10];
K = place(A,B, poles)
%c
[v,d] = eig(A-B*K);
e_vecs = diag(d)

%% Problem 4
A = [0 1 0; 0 0 1; 24 14 -1];
B = [0 0 1]';
C = [2 -1 1];
Obs = cat(1, C, C*A, C*A*A);
rank(Obs)       %system is observable
%b
poles = [-10+10*1i, -10-10*1i, -20];
L = place(A',C',poles);
L = L';
%c
[v,d] = eig(A-L*C)

%% Problem 5
mat1 = cat(2,A, -B*K);
mat2 = cat(2, L*C, A-B*K-L*C);
comb_system = cat(1, mat1, mat2)
[v,d] = eig(comb_system); 
e_vals = diag(d)

%% Problem 6
A = [0 1; 0 0];
B= [0;1];
C= [1 0];
R = 1;
Q = [1 0; 0 0];

[K, P, E] = lqr(A, B, .5*Q, .5*R);
% a
K
%b
P