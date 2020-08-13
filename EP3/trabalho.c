#include <stdio.h>
#include <stdlib.h>

typedef struct Point {
    double x, y;
} Point;

double interpolate (Point points[], double xi, int n) { 
    double result = 0;
  
    for (int i = 0; i < n; i++) { 
        double term = points[i].y;

        for (int j = 0; j < n; j++) { 
            if (j==i) continue;
            term *= (xi - points[j].x) / (points[i].x - points[j].x); 
        }  
        result += term; 
    }
    
    return result;
} 

Point *interpolate_interval (Point points[], int sz, int a, int b, int n, double *step) {
    *step = ((double) b - a) / (n-1);
    Point *res = (Point*) calloc(n, sizeof(Point));

    for (int i = 0; i < n; i++) {
        Point new_point = {a + i*(*step), interpolate(points, a + i*(*step), sz)};
        res[i] = new_point;
    }
    
    return res;
}

double trapezoidal (int n, Point points[], double step) {
    double sum = 0.5 * (points[0].y + points[n-1].y);

    for (int i = 1; i < n-1; i++)
        sum += points[i].y;

    return step * sum;
}

double simpson (int n, Point points[], double step) {
    double sum = points[0].y + points[n-1].y;

    for (int i = 1; i < n-1; i += 2)
        sum += points[i].y * 4;

    for (int i = 0; i < n-1; i += 2)
        sum += points[i].y * 2;

    return (sum / 3.0) * step;
}

int main (int argc, char **argv) {
    int a = 0, b = 30, n = 7, new_a, new_b, new_n;

    if (argc != 1 && argc != 4) {
        printf("Uso: ./trapezoidal a b n\n");
        exit(EXIT_FAILURE);
    }
    
    if (argc == 1)
        new_a = 0, new_b = 30, new_n = 7;
    else
        new_a = atoi(argv[1]), new_b = atoi(argv[2]), new_n = atoi(argv[3]);


    double step = 5.0;
    Point points[] = {
        {0, 0},
        {5, 1.5297},
        {10, 9.5120},
        {15, 8.7025},
        {20, 2.8087},
        {25, 1.0881},
        {30, 0.3537}
    }; 

    double new_step;
    Point *interpolated = interpolate_interval(points, n, new_a, new_b, new_n, &new_step);

    double result = trapezoidal(n, points, step);
    printf("Trapezoidal (n = %d): %f\n", n, result);

    result = trapezoidal(new_n, interpolated, new_step);
    printf("Trapezoidal (n = %d): %f\n\n", new_n, result);

    result = simpson(n, points, step);
    printf("Simpson (n = %d): %f\n", n, result);

    result = simpson(new_n, interpolated, new_step);
    printf("Simpson (n = %d): %f\n\n", new_n, result);

    free(interpolated);
}