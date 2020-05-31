function bicubic(compressedImg, method, k, h)
    tic
    A = imread(compressedImg);
    [a, l, colors] = size(A);
    
    p = a+(a-1)*k;

    M = uint8(expand(A, k));

    T = [  1,   0,   0,   0;
           1,   h,  h^2,  h^3;
           0,   1,   0,   0;
           0,   1,  2*h, 3*h^2   ];

    C = inv(T);

    if method == 2 %bicubic

        # para cada cor
        for c = 1:colors
            Dx = derivax(A(:,:,c), h);
            Dy = derivay(A(:,:,c), h);
            Dxy = derivaxy(Dy, h);

            # para cada canto esquerdo superior
            for i = 1:k+1:p-(k+1)
                for j = 1:k+1:p-(k+1)

                    xl = ceil(i / (k+1));
                    yl = ceil(j / (k+1));
                    xr = ceil((i+k+1) / (k+1));
                    yr = ceil((j+k+1) / (k+1));

                    # keyboard()

                    D = double([ 
                        A(xl, yl, c),   A(xl, yr, c),  Dy(xl, yl),    Dy(xl, yr); 
                        A(xr, yl, c),   A(xr, yr, c),  Dy(xr, yl),    Dy(xr, yr);
                        Dx(xl,yl),      Dx(xl, yr),    Dxy(xl, yl),   Dxy(xl, yr);
                        Dx(xr, yl),     Dx(xr, yr),    Dxy(xr, yl),   Dxy(xr, yr) 
                    ]);
                    
                    
                    % Matriz de coeficientes do polinomio intepolador
                    X = C * D * C';
                    
                    lhs = linspace(0, h, k + 2)';
                    lhs = [ones(1, k+2)', lhs, lhs.^2, lhs.^3];
                    rhs = linspace(0, h, k + 2);
                    rhs = [ones(1, k+2); rhs; rhs.^2; rhs.^3];

                    M(i:i+k+1, j:j+k+1, c) = lhs * X * rhs;

                    % Para cada pixel dentro desse quadrado.
                    % for m = i:i+k+1
                    %     for n = j:j+k+1
                    %         % Se não for o pixel original usado para a interpolação.
                    %             x = ((m-i)/(k+1))*h;
                    %             y = ((n-j)/(k+1))*h;
                    %             M(m, n, c) = [1, x, x^2, x^3] * X * [1; y; y^2; y^3];
                    %     endfor
                    % endfor

                endfor
            endfor
        endfor
    endif

    imwrite(uint8(M), 'images/bicubic.png');
    toc
    # imwrite(cast(D, 'uint8'), 'isa.png');
endfunction

for i=1:4:5
    for j=1:4:5
        
        xl = ceil(i / (k+1));
        yl = ceil(j / (k+1));
        xr = ceil((i+k+1) / (k+1));
        yr = ceil((i+k+1) / (k+1));

        a = derivax(i, j, k, h, p, B);
        b = derivax(i, j+(k+1), k, h, p, B);
        c = derivax(i+(k+1), j, k, h, p, B);
        d = derivax(i+(k+1), j+(k+1), k, h, p, B);

        '---------------'
        i, j, xl, xr, yl, yr
        ir = i+k+1
        jr = j+k+1

        'luis'
        [a, b, c, d]

        'vini'
        [dxV(xl,yl), dxV(xl, yr), dxV(xr, yl), dxV(xr, yr)]

    endfor
endfor

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