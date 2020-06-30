#include <time.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>

typedef double (*function)(double);

double x3 (double x) {
    return x * x * x;
}

double e (double x) {
    return exp(-x);
}

double random_number() {
    return (double) rand() / RAND_MAX;
}

double monte_carlo (int a, int b, int iters, function func) {
    double x, sum = 0;

    srand(time(NULL));

    for (int i = 0; i < iters; i++) {
        x = random_number() * (b - a) + a;
        sum += func(x);
    }
    
    return (sum / iters) * (b-a);
}

int main() {
    double res;
    
    res = monte_carlo(0, 1, 1e7, &sin);
    printf("%f\n", res);

    res = monte_carlo(3, 7, 1e7, &x3);
    printf("%f\n", res);
   
    res = monte_carlo(0, 9e3, 1e7, &e);
    printf("%f\n", res);
}