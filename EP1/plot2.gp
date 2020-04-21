
set terminal png size 1000, 764
set output 'newton_basins_f3_b.png'
unset key
set style data lines
#unset cbtics
unset colorbox
set cbrange [-1 : 10] noreverse nowriteback
set palette rgbformulae 7, 5, 15

set xrange [-10:10]
set yrange [-10:10]

plot 'output_f3.txt' using 1:2:3 with image