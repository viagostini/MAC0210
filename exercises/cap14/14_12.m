x = 1.2;
k = 0:.5:8;
h = 10 .^ -k;

fp1 = sin(x+h);
fn1 = sin(x-h);
f2  = 2 * sin(x);

d2f = (fp1 - f2 + fn1) ./ h.^2;
err = abs(d2f + sin(x));

[maxv idx] = min(err);

disp('melhor h (aproximadamente):'), disp(h(idx))

disp("O gráfico tem esse formato em V pois no inicio o erro é dominado pelo erro \n\
na aproximação, que é da ordem de h^2, mas após certo ponto o h fica tão pequeno \n\
que o erro de arredondamento começa a crescer descontroladamente.")

pl = loglog(h, err);
waitfor(pl);