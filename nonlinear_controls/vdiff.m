function F = vdiff(f, x)
n = length(x);
m = length(f);

F = sym('a', [m, n]);

for i = 1:n
	F(:, i) = diff(f, x(i));
end