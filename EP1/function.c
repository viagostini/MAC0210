#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <complex.h>


void evalf (double complex x, void (*f)(double complex, double complex*), double complex *y) {
    (*f)(x, y);
}

void f_csin (double complex x, double complex *y) {
    *y = csin(x);
}

void evalDf (double complex x, void (*f)(double complex, double complex*), double complex *y) {
    (*f)(x, y);
}

void Df_csin (double complex x, double complex *y) {
    *y = ccos(x);
}


int main() {
    double complex x = I;
    double complex y;

    f_csin(x, &y);

    printf("%.5f + %.5f\n", creal(y), cimag(y));
}