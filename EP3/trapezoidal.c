#include <stdio.h>

double trapezoidal (int n, double f[], double step) {
    double sum = 0.5 * (f[0] + f[n-1]);

    for (int i = 0; i < n-1; i++)
        sum += f[i];

    return step * sum;
}

int main () {
    int n = 7;
    int step = 5;
    double fcos[] = {0, 1.5297, 9.5120, 8.7025, 2.8087, 1.0881, 0.3537};

    double result = trapezoidal(n, fcos, step);

    printf("Result is %f\n", result);

}