% expands image inserting k rows and k columns between
% every original row and column
function M = expand (A, k)
    nrows = size(A, 1) * (k + 1) - k;
    ncols = size(A, 2) * (k + 1) - k;
    
    M = int16(zeros(nrows, ncols, 3));
    M(1:(k+1):end, 1:(k+1):end, :) = A;
endfunction