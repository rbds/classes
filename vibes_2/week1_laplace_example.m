%% 1/14/15 - week 1
%MAE 6258
%Randy Schur

%% laplace example
B1 = [.2, 1];
B2 = -0.33;
A1 = [2, 10, 12];
A2 = [2, 10, 12, 0];

[R1,P1,K1] = residue(B1, A1)
[R2, P2, K2] = residue(B2, A2)

%% symbolic example 
%using ilaplace.
syms s
L = (.2*s + 1)/(2*s^2 +10*s+12) - .33/(s*(2*s^2+10*s+12));
x = ilaplace(L);
vpa(x)

t = linspace(0, 10, 101);
plot(t, eval(subs(x, t)))

%% frequency response
f = 2*cos(5*t);
L = (.2*s + 1)/(2*s^2 +10*s+12) - (.67*s)/((2*s^2+10*s+12)*(s^2+25));
x = ilaplace(L);
vpa(x, 4)

t = linspace(0, 10, 1001);
plot(t, eval(subs(x,t)), 'r')
hold on
w = 5;
u = 2;
G = -.33/(2*s^2+10*s+12);
g = abs(subs(G, 1j*w))*2*cos(w*t+angle(subs(G, 1j*w))) ;
plot(t, eval(g), 'g')

