1;

function [x_l, x_r] = bisection(f, x_l, x_r)
    for i = 1:3
        x_m = (x_l + x_r) / 2;
        
        if f(x_l) * f(x_m) < 0
            x_r = x_m;
        else
            x_l = x_m;
        end
    endfor
    [x_l, x_r];
endfunction


function [sol, iters] = secant(f, x0, x1, tol)
    p = 0;
    a = x0;
    b = x1;
    f_x0 = f(x0);
    f_x1 = f(x1);

    iter = 0;
    while abs(f_x1) > tol && abs(f_x1 - f_x0) > tol * (1 + abs(f_x1))
        denominator = (f_x1 - f_x0) / (x1 - x0);
        x = x1 - (f_x1)/denominator;
        x0 = x1;
        x1 = x;
        f_x0 = f_x1;
        f_x1 = f(x1);
        iter = iter + 1;
        
        if abs(f_x1) > 0.5 * abs(f_x0) && p == 0
            p = 1;
            x0 = a;
            x1 = b;
            [c, d] = bisection(f, x0, x1);
            x0 = c;
            x1 = d;
            f_x0 = f(x0);
            f_x1 = f(x1);
        end
    end

    if abs(f_x1) > tol
        iter = -1;
    end

    sol = x1;
    iters = iter;

endfunction

function y = fsinc (x)
    y = 0;
    if x != 0
        y = sin(x)/x;
    end
    y;
endfunction

function y = k (x)
    if x == 0
        y = 0;
    else
        y = (x .* cos(x) .- sin(x)) ./ (x.*x);
    end
    y;
endfunction

function s = find_sign_change (f, a, b, nprobe)
    probes = linspace(a, b, nprobe);
    fp = f(probes);
    d = find(diff(sign(fp)) != 0)';
    r = [d d+1];
    s = probes(r);
endfunction

function find_roots (f, a, b, nprobe, tol)
    ret = find_sign_change(f, a, b, nprobe);

    for i = 1:rows(ret)
        x0 = ret(i, :)(1);
        x1 = ret(i, :)(2);
        [sol, iters] = secant(f, x0, x1, tol)
        printf('\n')
    endfor

endfunction