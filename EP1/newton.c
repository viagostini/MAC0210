#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <complex.h>

#define EPS 1E-8

int c[11] = {0};

double complex rootlist_f1[4] = {-1, 1, -I, I};
double complex rootlist_f2[10] = {
    -1, 1,
    0.809016994 + 0.587785252*I, -0.809016994 - 0.587785252*I,
    0.309016994 + 0.951056516*I, -0.309016994 - 0.951056516*I,
    -0.309016994 + 0.951056516*I, 0.309016994 - 0.951056516*I,
    -0.809016994 + 0.587785252*I, 0.809016994 - 0.587785252*I
};
double complex rootlist_f3[11] = {
    0,
    -5 * M_PI, 5 * M_PI,
    -4 * M_PI, 4 * M_PI,
    -3 * M_PI, 3 * M_PI,
    -2 * M_PI, 2 * M_PI,
    -M_PI, M_PI
};

double complex rootlist_f4[8] = {
    -2, 2, -1, 1, -I, I, 2*I, -2*I
};

/* double complex evalf (double complex x) {
   return cpow(x, 8) - 17 * cpow(x, 4) + 16;
}

double complex evalDf (double complex x) {
   return 8 * cpow(x, 7) - 68 * cpow(x, 3);
} */

double complex evalf (double complex x) {
    return csin(x);
}

double complex evalDf (double complex x) {
    return ccos(x);
}

void generate_points (double *arr, double left, double right, int n) {
    double step = (fabs(left)+fabs(right)) / (n-1);
    arr[0] = left;
    for (int i = 1; i < n; i++)
        arr[i] = arr[i-1] + step;
}

void generate_initial_guesses (double complex *arr, double *x, double *y, int p1, int p2) {
    for (int k = 0, i = 0; i < p1; i++)
        for (int j = 0; j < p2; j++)
            arr[k++] = x[i] + y[j]*I;
}

double complex newton (double complex x0, double eps, int max_iters) {
    int i = 0;
    double complex x = x0;
    
    while (cabs(evalf(x)) > eps && i++ <= max_iters)
        x = x - evalf(x) / evalDf(x);

    return (cabs(evalf(x)) < eps) ? x : NAN;
}

int get_root_id (double complex x) {
    // if x is NaN then x != x
    if (x != x) return -1;
    
    int i, n = sizeof(rootlist_f3) / sizeof(rootlist_f3[0]);
    
    for (i = 0; i < n; i++)
        if (cabs(rootlist_f3[i]-x) < EPS)
            return i;
    //fprintf(stderr, "%f + %f\n", creal(x), cimag(x));
    return -1;
}

void newton_basins (double l1, double l2, double u1, double u2, int p1, int p2) {
    double *X = malloc(p1 * sizeof(*X));
    double *Y = malloc(p2 * sizeof(*Y));

    int *iters = malloc(p1*p2 * sizeof(*iters));
    int *root_ids = malloc(p1*p2 * sizeof(*root_ids));
    double complex *Z = malloc(p1*p2 * sizeof(*Z));
    double complex *ans = malloc(p1*p2 * sizeof(*ans));

    generate_points(X, l1, u1, p1);
    generate_points(Y, l2, u2, p2);
    generate_initial_guesses(Z, X, Y, p1, p2);

    //printf("%.2f //printf("ans[%d] = %f%+fi, root_ids[%d] = %d\n", i, creal(ans[i]), cimag(ans[i]), i, root_ids[i]);%.2f %.2f %.2f %d %d\n", l1, l2, u1, u2, p1, p2);

    for (int i = 0; i < p1*p2; i++) {
        ans[i] = newton(Z[i], EPS, 200);
        root_ids[i] = get_root_id(ans[i]);
        //printf("%d %d\n", root_ids[i], iters[i]);
        printf("%.10lf %.10lf %d\n", creal(Z[i]), cimag(Z[i]), root_ids[i]);
    }
}

int main() {
    newton_basins(-10, -10, 10, 10, 1000, 1000);
    return 0;
}