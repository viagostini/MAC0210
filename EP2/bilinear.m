function bilinear(compressedImg, method, k, h)
  tic
  img = imread(compressedImg);

  [a, l, ncolors] = size(img);
  # a, ncolors
  
  if method == 1 %bilinear
    
    D = uint8(expand(img, k));
    # D = zeros(p, p, 3);
    # D(1:k + 1:end, 1:k + 1:end, :) = img;

    n = size(D,1);
    
    A = [ 1,  0,  0,   0   ; 
          1,  0,  h,   0   ;
          1,  h,  0,   0   ;
          1,  h,  h,  h^2  ];

    for color=1:ncolors
      
      # pontos que podem ser canto esquerdo superior
      for i=1:k+1:n-k+1
        for j=1:k+1:n-k+1

          xl = ceil(i / (k+1));
          yl = ceil(j / (k+1));
          xr = ceil((i+k+1) / (k+1));
          yr = ceil((j+k+1) / (k+1));

          f = double([
            img(xl, yl, color);
            img(xl, yr, color);
            img(xr, yl, color);
            img(xr, yr, color)
          ]);

          X = A \ f;

          lhs = [ones(1, k + 2)' linspace(0, h, k + 2)'];
          rhs = [ones(1, k + 2) ; linspace(0, h, k + 2)];
          cff = [X(1) X(2); X(3) X(4)];
          

          D(i:i+k+1, j:j+k+1, color) = (lhs * cff * rhs)';

        endfor
      endfor


      % for i=1:(k+1):(n-(k+1))
      %   for j=1:(k+1):(n-(k+1))
        
      %     %calcular pontos dados das bordas
      %     fq00 = D(i, j, color);
      %     fq10 = D(i+(k+1), j, color);
      %     fq01 = D(i, j+(k+1), color);
      %     fq11 = D(i+(k+1), j+(k+1), color);

      %     %preencher os pixels criados com a expansao do quadrado
      %     B = [fq00; fq01; fq10; fq11];
      %     B = double(B);
      %     X = A\B;

      %     for p=i:(i+(k+1))
      %       for r=j:(j+(k+1))
      %         dx = (p-i)/(k+1) * h;
      %         dy = (r-j)/(k+1) * h;
      %         D(p, r, color) = X(1) + X(2)*dx + X(3)*dy + X(4)*dx*dy;
      %       endfor
      %     endfor
      %   endfor
      % endfor
    endfor
  endif
  imwrite(D, 'images/bilinear.png', 'Quality', 100);
  toc
  # imwrite(cast(D, 'uint8'), 'isa.png');
endfunction