function c = monomial(X, y)
    A = [1; 1; 1; 1];
    for i = 1:numel(X)-1
        A = [A X.^i];
    end

    c = A \ y;
endfunction

X = [-1; 0; 1; 2];
y = [1; 1; 2; 0];

c = monomial(X, y);

f = @(x) c(4) * x^3 + c(3) * x^2 + c(2) * x + c(1)

f(10)