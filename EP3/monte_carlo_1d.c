#include <time.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>

typedef double (*function)(double);

double x3 (double x) {
    return pow(4*x + 3, 3) * 4;
}

double e (double x) {
    return exp(1 - 1/x) / (x*x);
}

double monte_carlo (int iters, function func) {
    double x, sum = 0;

    srand(time(NULL));

    for (int i = 0; i < iters; i++) {
        x = (double) rand() / RAND_MAX;
        sum += func(x);
    }
    
    return sum / iters;
}

int main(int argc, char **argv) {
    int iters;
    double res;
    
    if (argc != 1 && argc != 2) {
        printf("Uso: ./monte_carlo_1d iters\n");
        exit(EXIT_FAILURE);
    }

    if (argc == 1)
        iters = 1e7;
    else
        iters = atoi(argv[1]);


    printf("iters = %d\n", iters);

    res = monte_carlo(iters, &sin);
    printf("1) %f\n", res);

    res = monte_carlo(iters, &x3);
    printf("2) %f\n", res);

    res = monte_carlo(iters, &e);
    printf("3) %f\n\n", res);
}