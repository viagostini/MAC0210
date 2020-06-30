function D = bicubic(compressedImg, method, k, h)
    A = imread(compressedImg);
    [a, l, ncolors] = size(A);
    
    # para lidar com imagens PB e RGB
    D = cast(expand(A, k), class(A));
    p = a+(a-1)*k;

    H = [  1,   0,   0,    0;
           1,   h,  h^2,   h^3;
           0,   1,   0,    0;
           0,   1,  2*h,  3*h^2  ];

    Hinv = inv(H);

    if (k == 1)
        p = p - 1;
    endif

    # para cada cor
    for c = 1:ncolors
        Dx = derivax(A(:,:,c), h);
        Dy = derivay(A(:,:,c), h);
        Dxy = derivaxy(Dy, h);

        # para cada canto esquerdo superior
        for i = 1:k+1:p-k+1
            for j = 1:k+1:p-k+1

                xl = ceil(i / (k+1));
                yl = ceil(j / (k+1));
                xr = ceil((i+k+1) / (k+1));
                yr = ceil((j+k+1) / (k+1));

                f = double([ 
                    A(xl, yl, c),   A(xl, yr, c),  Dy(xl, yl),    Dy(xl, yr); 
                    A(xr, yl, c),   A(xr, yr, c),  Dy(xr, yl),    Dy(xr, yr);
                    Dx(xl,yl),      Dx(xl, yr),    Dxy(xl, yl),   Dxy(xl, yr);
                    Dx(xr, yl),     Dx(xr, yr),    Dxy(xr, yl),   Dxy(xr, yr) 
                ]);
                
                
                % Matriz de coeficientes do polinomio intepolador
                X = Hinv * f * Hinv';
                
                lhs = linspace(0, h, k + 2)';
                lhs = [ones(1, k+2)', lhs, lhs.^2, lhs.^3];
                rhs = linspace(0, h, k + 2);
                rhs = [ones(1, k+2); rhs; rhs.^2; rhs.^3];

                D(i:i+k+1, j:j+k+1, c) = lhs * X * rhs;
            endfor
        endfor
    endfor
endfunction

function Dx = derivax(A, h)
    # A é a matrix original, não expandida
    [nr, nc, c] = size(A);
    Dx = zeros(nr, nc);

    # diferença unilateral nas bordas de cima e baixo
    Dx_top = ( A(2, :) - A(1, :) ) / h;
    Dx_bot = ( A(end, :) - A(end-1, :) ) / h;
    
    # diferença centralizada nas linhas do meio
    for row = 2:(nr-1)
        Dx(row, :) = ( A(row+1, :) - A(row-1, :) ) / (2 * h);
    endfor

    Dx(1, :) = Dx_top;
    Dx(end, :) = Dx_bot;
endfunction

function Dy = derivay(A, h)
    # A é a matrix original, não expandida
    [nr, nc, c] = size(A);
    Dy = zeros(nr, nc);

    # diferença unilateral nas bordas da esquerda e direita
    Dy_left  = ( A(:, 2) - A(:, 1) ) / h;
    Dy_right = ( A(:, end) - A(:, end-1) ) / h;
    
    # diferença centralizada nas linhas do meio
    for col = 2:(nc-1)
        Dy(:, col) = ( A(:, col+1) - A(:, col-1) ) / (2 * h);
    endfor

    Dy(:, 1) = Dy_left;
    Dy(:, end) = Dy_right;
endfunction

function Dxy = derivaxy(Dy, h)
    [nr, nc, c] = size(Dy);
    Dxy = zeros(nr, nc);

    # diferença unilateral nas bordas de cima e baixo
    Dxy_top = ( Dy(2, :) - Dy(1, :) ) / h;
    Dxy_bot = ( Dy(end, :) - Dy(end-1, :) ) / h;
    
    # diferença centralizada nas linhas do meio
    for row = 2:(nr-1)
        Dxy(row, :) = ( Dy(row+1, :) - Dy(row-1, :) ) / (2 * h);
    endfor

    Dxy(1, :) = Dxy_top;
    Dxy(end, :) = Dxy_bot;
endfunction