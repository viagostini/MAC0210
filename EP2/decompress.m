function decompress (compressedImg, method, k, h)
    tic
    if method == 1
        A = bilinear(compressedImg, k, h);
    else
        A = bicubic(compressedImg, method, k, h);
    endif
    imwrite(A, 'images/func_2_color_k7.png', 'Quality', 100);
    toc
endfunction