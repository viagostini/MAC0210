source('find_all_roots.m');

f = @(x) (x .* cos(x) .- sin(x)) ./ (x.*x);

find_roots(f, -10, 10, 10, 1e-8)