%% MAE 6246 Homework 5
%Randy Schur

%% Problem 1
clear

syms t tau
A = [0 0; 1 0];     %input A and B matrices
B = [1 exp(-t)]';

psi1 = exp(A*t);    %calculate Phi matrix
psi2 = exp(A*tau);
phi = psi1/psi2;    

Z = phi*B;          %determine controllability
cblty = rank(Z')    %If rows of Z are lin. indep., the matrix is controllable
                    %Since Rank is 1, Matrix is not controllable

%% Problem 2
clear

A = [2 2 1; 5 3 6; -5 -1 -4]; 
B = [1 0 0]';
C = [1 1 2];

%a
Contr(:, 1) = B;
Contr(:, 2) = A*B;
Contr(:, 3) = A*A*B;
cblty = rank(Contr)             %System is controllable IFF rank(Contr=3)
                                %Since rank(Contr) is 2, system is not controllable
%b PBH eigenvector test
%System is not controllable if there is a left e-vec of A s.t. v'*B=0
%Left eigenvector v is v' of eig(A').
[V,D] = eig(A');
V(:,1)'*B
V(:,1)'*B     %System is not controllable, v2'*B = 0.
V(:,3)'*B


%c
% System is controllable IFF rank(sI-A, B) = n for all s
syms s
c2 = cat(2, (s*eye(3) - A), B);
evals = diag(D);
rank(subs(c2,evals(1))) ;
rank(subs(c2,evals(2)))     %since rank is 2, system is uncontrollable
rank(subs(c2,evals(3))) ;

%% Problem 3
A = [2 2 1; 5 3 6; -5 -1 -4]; 
B = [1 0 0]';
C = [1 1 2];

%a 
%Observaibility matrix
%system is observable if rank(O)=n 
O(1,:) = C;
O(2,:) = C*A;
O(3,:) = C*A*A;
obsv = rank(O) %rank is 3, so system is observable

%b PBH eigenvector test
%System is not observable if there is a left e-vec of A s.t. v'*C=0
[V,D] = eig(A');
C*V(1,:)'
C*V(2,:)'
C*V(3,:)'
%System is observable

%c PBH eigenvalue test
%System is observable IFF rank(sI-A, C) = n.
syms s;
c3 = cat(1, s*eye(3)-A, C);
[V,D] = eig(A);
evecs = diag(D);
rank(subs(c3, evecs(1)))
rank(subs(c3, evecs(2)))
rank(subs(c3, evecs(3)))

%% Problem 4
clear

A = [2 2 1; 5 3 6; -5 -1 -4]; 
B = [1 0 0]';
C = [1 1 2];

%a
cha_poly = poly(A)
%b
O(1,:) = C;
O(2,:) = C*A;
O(3,:) = C*A*A;
P = [cha_poly(3), cha_poly(2), 1;
     cha_poly(2), 1,           0;
     1,           0,           0]*O;

 
%c 
Abar = P*A/P
Bbar = P*B
Cbar = C/P



%% Problem 5
clear 
A = [2 2 1; 5 3 6; -5 -1 -4]; 
B = [1 0 0]';
C = [1 1 2];

Contr(:, 1) = B;
Contr(:, 2) = A*B;
Contr(:, 3) = A*A*B;
%a
% Q = P^-1;
[Q,S,V] = svd(Contr)

%b
Abar = Q\A*Q
Bbar = Q\B
Cbar = C*Q
%c
Abarc = Abar(1:2,1:2)
Bbarc = Bbar(1:2)
Cbarc = Cbar(1:2)
%d
cntrbl = cat(2, Bbarc, Abarc*Bbarc); 
rank(cntrbl)            %Since rank is 2 (full rank), submatrix is controllable
%e
[n1, d1] = ss2tf(A, B, C, 0, 1);
G = tf(n1,d1)
%f
[n2, d2] = ss2tf(Abarc, Bbarc, Cbarc, 0, 1);
Gs = tf(n2,d2)
minreal(G)

