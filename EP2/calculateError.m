function calculateError (originalImg, decompressedImg)
    ori = double(imread(originalImg));
    dec = double(imread(decompressedImg));

    ncolors = size(dec, 3);

    error = 0;
    for i= 1:ncolors
        errC = norm(ori(:, :, i) - dec(:, :, i)) / norm(ori(:, :, i));
        error = error + errC;
    endfor

    error = error / ncolors
endfunction