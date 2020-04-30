set terminal png size 1000, 764
set output 'newton_basins.png'

unset key

set style data lines

# unset cbtics
# unset colorbox

# set this according to number of expected roots
set cbrange [-1 : 9] noreverse nowriteback

set palette rgbformulae 7, 5, 15

# set this according to interval used in newton.c
set xrange [-2:2]
set yrange [-2:2]

plot 'newton_basins.txt' using 1:2:3 with image