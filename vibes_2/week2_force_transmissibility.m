clear
close 

syms x
m=50;
w=125.7;
zeta= 0.07;

eqn = .25==sqrt((1+(2*zeta*x)^2)/((1-x^2)^2+(2*zeta*x)^2));
S=solve(eqn, x);
S= eval(S);
r= S(S == real(S) & S>0);

% r= vpa(r(4),3);
wn=w/r;
k=vpa(wn^2*m,3);
c=vpa( 0.99*sqrt(k),3);

k=152000;
c=386.39;
w_v= 0:200;
ftm = sqrt((k^2+(c*w_v).^2)./((k - m*w_v.^2).^2+(c*w_v).^2));
plot(w_v, ftm)
k = 0.9*k;
ftm = sqrt((k^2+(c*w_v).^2)./((k - m*w_v.^2).^2+(c*w_v).^2));
hold on
plot(w_v, ftm, 'r')
