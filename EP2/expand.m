% expands image inserting k rows and k columns between
% every original row and column
function M = expand (compressedImg, k)
    [nrows, ncols, ncolors] = size(compressedImg);

    nrows = nrows + (nrows-1) * k;
    ncols = ncols + (ncols-1) * k;
    
    # M = uint8(zeros(nrows, ncols, 3));
    M = zeros(nrows, ncols, ncolors);
    M(1:(k+1):end, 1:(k+1):end, :) = compressedImg;
endfunction