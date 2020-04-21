
#include <stdio.h>
#include <math.h>

#define		f(x)  	(exp(x) - 2 * x * x)
#define 	df(x) 	(exp(x) - 4 * x)
//#define   g(x)   	exp(x) / (2 * x)
#define 	g(x)  	x - f(x) / df(x)
//#define	g(x)	log(2) + 2 * log(x)

void fixed_point (double x0, double eps, int max_iters) {
	int step;
	double x1;

	printf("\nStep\t x\t\t g(x)\t\t f(x)\n");

	for (step = 1; step <= max_iters && fabs(f(x1)) > eps; step++) {
		x1 = g(x0);
		printf("%d\t %lf\t %lf\t %.15lf\n", step, x0, g(x0), f(x0));		  
		x0 = x1;
	}

	printf("%d\t %lf\t %lf\t %.15lf\n", step, x0, g(x0), f(x0));

	if (step > max_iters)
		printf("\nMethod did not converge.");
	else
		printf("\nRoot is %.15lf\n", x1);
}

int main() {
	int max_iters;
	double x0, eps;

	printf("Enter initial guess: ");
	scanf("%lf", &x0);
	printf("Enter tolerable error: ");
	scanf("%lf", &eps);
	printf("Enter maximum iteration: ");
	scanf("%d", &max_iters);

	fixed_point(x0, eps, max_iters);

	return 0;
}