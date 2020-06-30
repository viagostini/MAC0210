#include <stdio.h>

double simpson (int n, double f[], double step) {
    double sum = f[0] + f[n-1];

    for (int i = 1; i < n-1; i += 2)
        sum += f[i] * 4;

    for (int i = 0; i < n-1; i += 2)
        sum += f[i] * 2;

    return (sum / 3.0) * step;
}

int main () {
    int n = 7;
    int step = 5;
    double fcos[] = {0, 1.5297, 9.5120, 8.7025, 2.8087, 1.0881, 0.3537};

    double result = simpson(n, fcos, step);

    printf("Result is %f\n", result);

}