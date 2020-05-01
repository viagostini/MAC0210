function decompress (compressedImg, method, k, h)
    img = imread(compressedImg);
    img = expand(img, k);

    A = [ 1 , 0 , 0 ,  0  ;
          1 , 0 , h ,  0  ;
          1 , h , 0 ,  0  ;
          1 , h , h , h^2   ];

    %imwrite(img, 'decompress.png', 'Quality', 100, 'Compression', 'none');


endfunction