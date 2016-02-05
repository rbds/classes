% twoDOF_forced_modal_resp.m

clear all;
close all;

m1 = 1;
m2 = 1;
k1 = 10;
k2 = 10;
k3 = 10;
M = diag([m1 m2]);
K = [k1+k2 -k2; -k2 k2+k3];
B = [1 0]';
F = 1;

% compute mass-normalized modes
L = chol(M,'lower')
Ktilde = (L\K)/L'			% same as Ktilde = inv(L)*K*inv(L')
[P,D] = eig(Ktilde)
wn = sqrt(diag(D))
zeta = 0*wn;

% modal frequency responses
N = length(wn);
w = logspace(log10(0.1*wn(1)),log10(10*wn(end)),1001);
Gtilde = zeros(N,length(w));		% modal transfer functions
Z_F = zeros(N,length(w));	% Z(iw)/F(iw)
alpha = P'*(L\B)			% same as alpha = P'*inv(L)*B
for i = 1:N
	Gtilde(i,:) = 1./(-w.^2+(1i*2*zeta(i)*wn(i))*w+wn(i)^2);
	Z_F(i,:) = Gtilde(i,:)*alpha(i,:)*F;
end

% physical frequency responses
Q_F = zeros(N,length(w));
for j = 1:length(w)
	temp = zeros(N,N);
	for i = 1:N
		temp = temp + Gtilde(i,j)*P(:,i)*P(:,i)';
	end
	Q_F(:,j) = (L'\temp)*(L\B);		% same as Q_F(:,j) = inv(L')*temp*inv(L)*B
end

% Bode plots
figure;
semilogx(w,20*log10(abs(Z_F)));
legend('Z_1(iw)/F(iw)','Z_2(iw)/F(iw)');

figure;
semilogx(w,20*log10(abs(Q_F)));
legend('Q_1(iw)/F(iw)','Q_2(iw)/F(iw)');

% --------------------------------------------------------------------------------------------------
% put some damping in
% modal frequency responses
zeta = [0.02 0.05]';
wd = wn.*sqrt(1-zeta.^2)
wp = wn.*sqrt(1-2*zeta.^2)
for i = 1:N
	Gtilde(i,:) = 1./(-w.^2+(1i*2*zeta(i)*wn(i))*w+wn(i)^2);
	Z_F(i,:) = Gtilde(i,:)*alpha(i,:)*F;
end

% physical frequency responses
Q_F = zeros(N,length(w));
for j = 1:length(w)
	temp = zeros(N,N);
	for i = 1:N
		temp = temp + Gtilde(i,j)*P(:,i)*P(:,i)';
	end
	Q_F(:,j) = (L'\temp)*(L\B);		% same as Q_F(:,j) = inv(L')*temp*inv(L)*B
end

% Bode plots
figure;
semilogx(w,20*log10(abs(Z_F)));
legend('Z_1(iw)/F(iw)','Z_2(iw)/F(iw)');

figure;
semilogx(w,20*log10(abs(Q_F)));
legend('Q_1(iw)/F(iw)','Q_2(iw)/F(iw)');

% --------------------------------------------------------------------------------------------------
% setup state space model for time simulation
alpha = 2*wn(1)*wn(2)*(zeta(1)*wn(2)-zeta(2)*wn(1))/(wn(2)^2-wn(1)^2)
beta = 2*(zeta(2)*wn(2)-zeta(1)*wn(1))/(wn(2)^2-wn(1)^2)
C = alpha*M + beta*K;
A_ss = [zeros(N) eye(N); -M\K -M\C]
B_ss = [zeros(N,length(F)); M\B]
C_ss = [eye(N) zeros(N)]
sys = ss(A_ss,B_ss,C_ss,0);
damp(sys)

% time simulation
w_f = 4.45;				% input frequency (rad/s)
t = linspace(0,50*2*pi/w_f,1001);
f = sin(w_f*t);
q = lsim(sys,f,t);
figure;
plot(t,q);