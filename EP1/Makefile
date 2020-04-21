CC=gcc
CFLAGS=-lm -Wall -pedantic

.PHONY: clean
.PHONY: all

all: fixed_point newton

fixed_point: fixed_point.c
	$(CC) fixed_point.c $(CFLAGS) -o fixed_point

newton: newton.c
	$(CC) newton.c $(CFLAGS) -o newton

clean:
	rm -f fixed_point
	rm -f newton