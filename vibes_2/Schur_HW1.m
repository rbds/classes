%Randy Schur
%MAE 6258 HW1
%1/21/15
clear
close
m = 10;
c= 1000;
k= 5000;
l=1;
w= 1000*2*pi/60;
M= 100;

B= [(M/(17/16*m*l^2)) 0 0];
A = [1 c*l/4 k*l+w^2 w^2*c*l/4 w^2*k*l];
[r, p, k1] = residue(B,A)

syms s
T = (M/(17/16*m*l^2))*(s^2/(s^2+w^2))*(1/(s^2+250*s+5000));
x = ilaplace(T);
vpa(x,3)

%c
t= linspace(0, 3, 1001);
G =(M/10.625)/(s^2+250*s+5000);
g = abs(subs(G, 1j*w))*M*cos(w*t+angle(subs(G, 1j*w))) ;

%d
plot(t, eval(g), 'r')
hold on
plot(t, eval(subs(x,t)))