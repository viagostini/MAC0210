f = @(x) (x .* cos(x) .- sin(x)) ./ (x.*x);
g = @(x) -x/3;

a = -2:0.01:2;
fa = f(a);
ga = g(a);
err = abs(fa - ga);

figure(1);
plot(a, fa, "-;f(x);", a, ga, "-b;g(x);");

figure(2);
plot(a, err, "-;abs(f(x) - g(x));");

pause