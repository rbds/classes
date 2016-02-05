function [ A, e ] = my_eom_lin( x, lambda )
% Hx=x-2*x*lambda;
% Hl=-lambda-x^2;
% Hxx=1-2*lambda;
% Hll=-1;
% Hlx=-2*x;
% Hxl=-2*x;

[Hx Hl Hxx Hxl Hlx Hll]= prob4_H_deriv(x,lambda);

A=[Hlx Hll;
  -Hxx -Hxl];
e=-(A*[x;lambda])+[Hl'; -Hx'];
end

