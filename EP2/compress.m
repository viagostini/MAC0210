function compress (originalImg, k)
    img = imread(originalImg);

    img = img(1:(k+1):end, 1:(k+1):end, :);

    imwrite(img, "compress.png");
endfunction