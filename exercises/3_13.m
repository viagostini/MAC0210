source('find_all_roots.m')

f = @(x) 2 * cosh(x/4) - x;

find_roots(f, 0, 10, 10, 1e-8)