#include <time.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>

double monte_carlo_sin (int iters) {
    double x, sum = 0;

    srand(time(NULL));

    for (int i = 0; i < iters; i++) {
        x = (double) rand() / RAND_MAX;
        sum += sin(x);
    }

    return sum / iters;
}

int main() {
    double res = monte_carlo_sin(1e7);

    printf("Result is %f\n", res);
}