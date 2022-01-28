% Examples 1.2--1.3 and Figure 1.3

x0 = 1.2;
f0 = sin(x0);                           %value of the function at x0
fp = cos(x0);                           %true value of f'(x0)
i = -20:0.5:0;
h = 10.^i;                              %this creates an array of h values from 10^(-20) up to 10^0
err = abs (2.*cos((2.*x0+h)./2)).*(sin(h./2));  %calculates the absolute error between fp and the derivative approximation
d_err = 1/2*h;                          %this is the discretization error predicted by Taylor's theorem (or at least, an upper bound)

%plot the actual error and the predicted error on a log-log plot.
loglog (h,err,'-*');
hold on
loglog (h,d_err,'r-.');
xlabel('h')
ylabel('Absolute error')
axis([10^(-20) 1 10^(-15) 1])
hold off;