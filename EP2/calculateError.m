function err = calculateError (originalImg, decompressedImg)
    ori = double(imread(originalImg));
    dec = double(imread(decompressedImg));

    errR = norm(ori(:, :, 1) - dec(:, :, 1)) / norm(ori(:, :, 1));
    errG = norm(ori(:, :, 2) - dec(:, :, 2)) / norm(ori(:, :, 2));
    errB = norm(ori(:, :, 3) - dec(:, :, 3)) / norm(ori(:, :, 3));

    err = (errR + errG + errB) / 3
endfunction