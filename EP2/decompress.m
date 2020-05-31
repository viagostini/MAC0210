function decompress (compressedImg, method, k, h)
    
    if method == 1
        bilinear(compressedImg, method, k, h)
    else
        bicubic(compressedImg, method, k, h)
    endif

endfunction