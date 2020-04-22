
set terminal png size 1000, 764
set output 'images/newton_basins_f6.png'

unset key

set style data lines

# unset cbtics
unset colorbox

# set this according to number of expected roots
set cbrange [-1 : 2] noreverse nowriteback

set palette rgbformulae 7, 5, 15

set xrange [-4:4]
set yrange [-4:4]

plot 'output_f6.txt' using 1:2:3 with image