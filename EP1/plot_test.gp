set terminal wxt size 350,262 enhanced font 'Verdana,10' persist

# Line width of the axes
set border linewidth 1.5
# Line styles
set style line 1 linecolor rgb '#0060ad' linetype 1 linewidth 2
set style line 2 linecolor rgb '#dd181f' linetype 1 linewidth 2

set xrange [-1000:1000]
set yrange [0:500]

a = 0.9
f(x) = abs(((x * cos(x) - sin(x)) / (x*x)) + x/3)
g(x) = a * cos(x)
# Plot
plot f(x) title 'err(x)' with lines linestyle 1