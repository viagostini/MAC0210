function err = calculateError (originalImg, decompressedImg)
    ori = double(imread(originalImg));
    dec = double(imread(decompressedImg));

    ncolors = size(dec, 3);

    err = 0;
    for i= 1:ncolors
        err = err + norm(ori(:, :, i) - dec(:, :, i)) / norm(ori(:, :, i));
    endfor

    err = err / ncolors;
endfunction