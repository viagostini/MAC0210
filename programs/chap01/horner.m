#! /bin/octave -qf

% Example 1.4

% Assume the polynomial coefficients are already stored
% in array c such that for any real x,
% p(x) = c(1) + c(2)x + c(3)x^2 + ... + c(n+1)x^n

function r = horner(a, x)
    r = 0.0;
    for i = length(a):-1:1
        r = r*x + a(i);
    end
end

a = [2, -3, 7];
x = -2;

horner(a, x)