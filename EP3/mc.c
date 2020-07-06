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

int main() {
    double res;
    
    res = monte_carlo(1e7, &sin);
    printf("%f\n", res);

    res = monte_carlo(1e7, &x3);
    printf("%f\n", res);

    res = monte_carlo(1e7, &e);
    printf("%f\n", res);
}