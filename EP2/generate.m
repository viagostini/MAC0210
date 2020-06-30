# func_1: (sin(x) - sin(y) / 2)
# func_1_color: (sin(x), (sin(y) + sin(x)) / 2, sin(x))

# func_2: tan(x) - tan(y)
# func_2_color: (tan(x) - tan(y), tan(x), tan(y) - y)


function generate (p)
    [XI, YI] = meshgrid(1:p, 1:p);
    
    A(:,:,1) = rfunc(XI, YI);
    A(:,:,2) = gfunc(XI, YI);
    A(:,:,3) = bfunc(XI, YI);

    # keyboard()

    imwrite(A, 'images/func_2_color_2.png');

endfunction

function r = rfunc (x, y)
    r = tan(x) - tan(y);
endfunction

function g = gfunc (x, y)
    g = tan(x);
endfunction

function b = bfunc (x, y)
    b = tan(y) - y;
endfunction