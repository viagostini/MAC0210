default: all

part1:
	@gcc trabalho.c -o trabalho

part2:
	@gcc monte_carlo_1d.c -o monte_carlo_1d -lm


part3:
	@gcc pi.c -o pi -lm

all: part1 part2 part3
	./trabalho 0 30 19
	./monte_carlo_1d
	./pi

clean:
	rm trabalho
	rm monte_carlo_1d
	rm pi