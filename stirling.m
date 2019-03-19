#! /bin/octave -qf

# Example 1.1 - Stirling approximation to n!

e = exp(1);
n = 1:10;

fact_n = factorial(n);
Sn = sqrt(2*pi*n) .* ((n/e).^n);

abs_err = abs(Sn-fact_n);
rel_err = abs_err ./ fact_n;

format short g

[n; fact_n; Sn; abs_err; rel_err]'