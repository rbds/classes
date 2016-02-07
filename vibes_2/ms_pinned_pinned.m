function [phi,dphidx] = ms_pinned_pinned(x,ind,rhoA,L,eval_mode)
%
% phi = ms_pinned_pinned(x,ind,rhoA,L,1)
% dphidx = ms_pinned_pinned(x,ind,rhoA,L,2)
% [phi,dphidx] = ms_pinned_pinned(x,ind,rhoA,L,3)
%
% Returns mode shapes or their slopes for 1 or more modes of a pinned-pinned beam, evaluated at x.
%
% [Inputs]
% x = evaluation points (dimensional)
% ind = which modes to compute
% rhoA = mass per unit length (dimensional)
% L = length (dimensional)
% (optional)
% eval_mode = 1, compute phi(x) (default)
%             2, compute dphi(x)/dx
%             3, compute phi(x) and dphi(x)/dx
%
% [Outputs]
% phi = mode shapes, the ith row corresponds to ind(i), the jth column corresponds to x(j)
% dphidx = mode shape slopes, the ith row corresponds to ind(i), the jth column corresponds to x(j)
%
% Written by Adam Wickenheiser
%

if nargin < 5, eval_mode = 1; end

% dimensionless frequencies (pinned-pinned): sin(lamda) = 0
lamda = pi*(ind)';

x = x(:)';		% make sure x is a row vector
lx = length(x);

temp = (lamda/L)*x;
		
switch eval_mode
	case 1		% compute only phi(x)
		phi = sqrt(2/(rhoA*L))*sin(temp);
	case 2		% compute only dphi/dx(x)
		phi = repmat(lamda*sqrt(2/(rhoA*L^3)),1,lx).*cos(temp);
	otherwise
		phi = sqrt(2/(rhoA*L))*sin(temp);
		dphidx = repmat(lamda*sqrt(2/(rhoA*L^3)),1,lx).*cos(temp);
end