#include <stdio.h>
#include <math.h>

#define		f(x)  	(exp(x) - 2 * x * x)
#define 	df(x) 	(exp(x) - 4 * x)
#define 	g(x)  	x - f(x) / df(x)

//#define   g(x)   	exp(x) / (2 * x)
//#define	g(x)	log(2) + 2 * log(x)


/*
 * Function: fixed_point
 * ----------------------------
 *   Executes Fixed Point Method
 *
 *   x0: initial guess
 *   eps: precision to consider a root found 
 *   max_iters: maximum number of iterations to perform
 *
 *   returns: a root or NAN if method did not converge
 */
double fixed_point (double x0, double eps, int max_iters, int *iters) {
	int step;
	double x1;

	for (step = 1; step <= max_iters && fabs(f(x1)) > eps; step++) {
		x1 = g(x0);
		x0 = x1;
	}

	*iters = (fabs(f(x1)) < eps) ? step : -1;
	return (fabs(f(x1)) < eps) ? x1 : NAN;
}

int main() {
	int max_iters, iter;
	double x, x0, eps;

	printf("\nEnter initial guess: ");
	scanf("%lf", &x0);
	printf("Enter tolerable error: ");
	scanf("%lf", &eps);
	printf("Enter maximum iteration: ");
	scanf("%d", &max_iters);

	printf("\nFixed Point Method for g(x) = exp(x) / (2 * x):\n");

	x = fixed_point(x0, eps, max_iters, &iter);

	// if x0 is NAN, x0 != x0
	if (x != x)
		printf("\nMethod did not converge after %d steps.\n\n", max_iters);
	else
		printf("\nMethod converged to %lf in %d steps.\n\n", x, iter);

	return 0;
}