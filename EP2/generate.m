function generate (p, func)
    [XI, YI] = meshgrid(1:p, 1:p);
    
    A = func(XI, YI);

    imwrite(A, 'images/func.png');

endfunction

function [x, y, z] = f (x, y)
    x = sin(x);
    y = (sin(y) + sin(x)) / 2;
    z = sin(x);
endfunction