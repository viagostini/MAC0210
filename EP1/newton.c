#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <complex.h>

/*
 * Global Constants and Output File
 * --------------------------------
 */
#define EPS 1E-8
#define ITERS_COLOR_SHADING 0
FILE *out;

/*
 * Global Array: rootlist
 * ----------------------------
 *   Contains roots of x^10 - 1
 */
double complex rootlist[10] = {
    -1, 1,
    0.809016994 + 0.587785252*I, -0.809016994 - 0.587785252*I,
    0.309016994 + 0.951056516*I, -0.309016994 - 0.951056516*I,
    -0.309016994 + 0.951056516*I, 0.309016994 - 0.951056516*I,
    -0.809016994 + 0.587785252*I, 0.809016994 - 0.587785252*I
};

/*
 * Function: evalf
 * ----------------------------
 *   Evaluates x^10 - 1
 *
 *   x: point to evaluate function at
 *
 *   returns: x^10 - 1
 */
double complex evalf (double complex x) {
    return cpow(x, 10) - 1;
}

/*
 * Function: evalDf
 * ----------------------------
 *   Evaluates 10x^9
 *
 *   x: point to evaluate function at
 * 
 *   returns: 10x^9
 */
double complex evalDf (double complex x) {
    return 10 * cpow(x, 9);
}


/*
 * Function: generate_points
 * ----------------------------
 *   Generates n equidistant points in interval [left, right]
 *
 *   arr must point to an array of size n
 *   arr[i] contains i-th point when function is finished
 */

void generate_points (double *arr, double left, double right, int n) {
    double step = (fabs(left)+fabs(right)) / (n-1);
    arr[0] = left;
    for (int i = 1; i < n; i++)
        arr[i] = arr[i-1] + step;
}


/*
 * Function: generate_initial_guesses
 * ----------------------------
 *   Generate p1 x p2 complex numbers to use as initial
 *   guesses to Newton's Method
 * 
 *   For every x_i in x and for every y_j in y, generates
 *   x_i + y_j*I
 *
 *   arr: array of size p1 x p2
 *   x: array containing p1 numbers (real part of guesses)
 *   y: array containing p2 numbers (imag part of guesses)
 *   p1: number of points in the real axis x 
 *   p2: number of points in the imag axis y
 *  
 *   arr[i] contains i-th initial guess when function is finished
 */

void generate_initial_guesses (double complex *arr, double *x, double *y, int p1, int p2) {
    for (int k = 0, i = 0; i < p1; i++)
        for (int j = 0; j < p2; j++)
            arr[k++] = x[i] + y[j]*I;
}


/*
 * Function: newton
 * ----------------------------
 *   Executes Newton's Method
 *
 *   x0: initial guess
 *   eps: precision to consider a root found 
 *   max_iters: maximum number of iterations to perform
 *   iters: pointer to array to save number of iterations
 *
 *   returns: a root or NAN if method did not converge
 */
double complex newton (double complex x0, double eps, int max_iters, int* iters) {
    int i = 0;
    double complex x = x0;
    
    while (cabs(evalf(x)) > eps && i++ <= max_iters)
        x = x - evalf(x) / evalDf(x);

    if (cabs(evalf(x)) < eps) {
        *iters = i;
        return x;
    } else {
        *iters = -1;
        return NAN;
    }
}

/*
 * Function: get_root_id
 * ----------------------------
 *   Searches rootlist for the root found by function 'newton'
 *   and returns its index to be used for plotting.
 *
 *   x: root to search for
 *
 *   returns: index of root or -1 if it is not in rootlist
 */
int get_root_id (double complex x) {
    // if x is NaN then x != x
    if (x != x) return -1;
    
    int n = sizeof(rootlist) / sizeof(rootlist[0]);
    
    for (int i = 0; i < n; i++)
        if (cabs(rootlist[i]-x) < EPS)
            return i;
    return -1;
}


/*
 * Function: newton_basins
 * ----------------------------
 *   Driver function for this project.
 *   Generates p1 x p2 initial guesses in the plane [l1, u1] x [l2, u2],
 *   runs function 'newton' for each one, finds the index of the root
 *   found and outputs one line for each root in the following format: 
 * 
 *                    "creal(x) cimag(x) root_id"
 *
 *   l1: lower limit of real axis
 *   l2: lower limit of imag axis
 *   u1: upper limit of real axis
 *   u2: upper limit of imag axis
 *   p1: number of points in real axis
 *   p2: number of points in imag axis
 *
 *   Produces the output needed to plot newton's basins with gnuplot
 */
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

    int max_iters = -1;
    for (int i = 0; i < p1*p2; i++) {
        ans[i] = newton(Z[i], EPS, 400, iters+i);
        root_ids[i] = get_root_id(ans[i]);
        max_iters = (iters[i] > max_iters ? iters[i] : max_iters);

        if (!ITERS_COLOR_SHADING)
            fprintf(out, "%.10lf %.10lf %d\n", creal(Z[i]), cimag(Z[i]), root_ids[i]);
    }

    // apply color shading if desired
    if (ITERS_COLOR_SHADING) {
        for (int i = 0; i < p1*p2; i++) {
            if (iters[i] > 0) {
                // used only for bonus image
                // double logiters = (double) iters[i];
                double logiters = root_ids[i] - 0.99 * log((double)iters[i] / max_iters);
                fprintf(out, "%.10lf %.10lf %.2f\n", creal(Z[i]), cimag(Z[i]), logiters);
            } else {
                fprintf(out, "%.10lf %.10lf %d\n", creal(Z[i]), cimag(Z[i]), root_ids[i]);
            }
        }
    }
}

int main() {
    out = fopen("newton_basins.txt", "w");

    newton_basins(-2, -2, 2, 2, 1000, 1000);

    fclose(out);
    
    return 0;
}