function compress (originalImg, k)
    img = imread(originalImg);

    img = img(1:(k+1):end, 1:(k+1):end, :);

    imwrite(img, "images/compress2.png", 'Quality', 100, 'Compression', 'none');
endfunction