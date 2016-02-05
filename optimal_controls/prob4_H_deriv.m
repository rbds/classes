%Midterm MAE6292 Randy Schur

function [Hx Hl Hxx Hxl Hlx Hll]=prob4_H_deriv(x,lambda)

x1=x(1);
x2=x(2);
x3=x(3);
x4=x(4);
l1=lambda(1);
l2=lambda(2);
l3=lambda(3);
l4=lambda(4);

Hx=[ (2*l3*x1^2 + 3*l4*x1*x2 - l3*x2^2)/(x1^2 + x2^2)^(5/2), (- l4*x1^2 + 3*l3*x1*x2 + 2*l4*x2^2)/(x1^2 + x2^2)^(5/2), l1, l2];
Hl=[ x3, x4, - l3 - x1/(x1^2 + x2^2)^(3/2), - l4 - x2/(x1^2 + x2^2)^(3/2)];
Hxx =[-(6*l3*x1^3 + 12*l4*x1^2*x2 - 9*l3*x1*x2^2 - 3*l4*x2^3)/(x1^2 + x2^2)^(7/2), (3*l4*x1^3 - 12*l3*x1^2*x2 - 12*l4*x1*x2^2 + 3*l3*x2^3)/(x1^2 + x2^2)^(7/2), 0, 0;
    (3*l4*x1^3 - 12*l3*x1^2*x2 - 12*l4*x1*x2^2 + 3*l3*x2^3)/(x1^2 + x2^2)^(7/2),  (3*l3*x1^3 + 9*l4*x1^2*x2 - 12*l3*x1*x2^2 - 6*l4*x2^3)/(x1^2 + x2^2)^(7/2), 0, 0;
    0,                                                                           0, 0, 0;
    0,                                                                           0, 0, 0];
Hxl =[ 0, 0, (2*x1^2 - x2^2)/(x1^2 + x2^2)^(5/2),        (3*x1*x2)/(x1^2 + x2^2)^(5/2);
    0, 0,       (3*x1*x2)/(x1^2 + x2^2)^(5/2), -(x1^2 - 2*x2^2)/(x1^2 + x2^2)^(5/2);
    1, 0,                                   0,                                    0;
    0, 1,                                   0,                                    0];

Hlx=Hxl';
Hll =[ 0, 0,  0,  0;
    0, 0,  0,  0;
    0, 0, -1,  0;
    0, 0,  0, -1];

end

%% The following commands are used to derive the above derivatives of the Hamiltonian
% clear all;
% close all;
%
% syms x1 x2 x3 x4 l1 l2 l3 l4;
%
% r=sqrt(x1^2+x2^2);
% H=-1/2*(l3^2+l4^2)+l1*x3+l2*x4-l3*1/r^3*x1-l4*1/r^3*x2;
%
% x=[x1 x2 x3 x4];
% l=[l1 l2 l3 l4];
% Hx=simplify(jacobian(H,x));
% Hl=simplify(jacobian(H,l));
% for i=1:4
%     Hxx(i,:)=simplify(jacobian(Hx(i),x));
%     Hxl(i,:)=simplify(jacobian(Hx(i),l));
%     Hlx(i,:)=simplify(jacobian(Hl(i),x));
%     Hll(i,:)=simplify(jacobian(Hl(i),l));
% end
%
