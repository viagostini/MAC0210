function D = bilinear(compressedImg, k, h)
  A = imread(compressedImg);

  [a, l, ncolors] = size(A);
  
  # para lidar com imagens PB e RGB
  D = cast(expand(A, k), class(A));
  p = size(D,1);
  
  H = [ 1,  0,  0,   0   ; 
        1,  0,  h,   0   ;
        1,  h,  0,   0   ;
        1,  h,  h,  h^2  ];

  if (k == 1)
    p = p - 1;
  endif

  for color=1:ncolors
    # pontos que podem ser canto esquerdo superior
    for i=1:k+1:p-k+1
      for j=1:k+1:p-k+1

        xl = ceil(i / (k+1));
        yl = ceil(j / (k+1));
        xr = ceil((i+k+1) / (k+1));
        yr = ceil((j+k+1) / (k+1));

        f = double([
          A(xl, yl, color);
          A(xl, yr, color);
          A(xr, yl, color);
          A(xr, yr, color)
        ]);

        X = H \ f;

        lhs = [ones(1, k + 2)' linspace(0, h, k + 2)'];
        rhs = [ones(1, k + 2); linspace(0, h, k + 2)];
        cff = [X(1) X(2); X(3) X(4)];
        
        D(i:i+k+1, j:j+k+1, color) = (lhs * cff * rhs)';
      endfor
    endfor
  endfor
endfunction