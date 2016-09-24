function L = lieDiff(a, b, x, n)
%
% L = lieDiff(a, b, x)
% 
% Produces the Lie derivative L such that:
%  L = L_b(a(x)) = da/dx * b(x)
%
if nargin() == 3
	n = 1;
end

L = a;
for i = 1:n
	L = vdiff(L, x)*b;
end