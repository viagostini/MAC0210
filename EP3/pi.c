#include <time.h>
#include <stdio.h>
#include <stdlib.h>

double monte_carlo_pi (int iters) {
    int inside = 0;
    double x, y, pi;

    srand(time(NULL));

    for (int i = 0; i < iters; i++) {
        x = (double) rand() / RAND_MAX;
        y = (double) rand() / RAND_MAX;
    
        if (x*x + y*y < 1)
            inside++;
    }

    return 4.0 * inside / iters;
}

int main() {
    int iters = (int) 1e7;

    double pi = monte_carlo_pi(iters);

    printf("Pi = %f\n", pi);
}