#! /bin/octave -qf

% Exercise 1 from Section 1.4

e = exp(1);

x0 = 0.5;
f0 = e^(-2*x0);
fp = -2 * e^(-2*x0);
i = -20:0.5:0;
h = 10.^i;
err = abs (fp - (sin(x0+h) - f0) ./ h );
d_err = f0/2*h;
loglog (h,err,'-*');
hold on
loglog (h,d_err,'r-.');
xlabel('h')
ylabel('Absolute error')
axis([10^(-20) 1 10^(-15) 1])

#pause