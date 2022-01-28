%Code to get you started for A3Q3. Secant method is slightly trickier since
%we have to keep track of two points.

a = 5;

%Newton method iteration
x = 2;
fprintf('Newtons\nk\tx_k\n===================\n');
for k = 1:10
    x = 0.5*(x + a/x);
	fprintf('%d \t %1.14f \n',k,x)
end
fprintf('\n')

%secant method
xold = 2;  %this is x_(k-1)
xnew = 3;  %this is x_k
fprintf('Secant\nk\tx_k\n===================\n');
for k = 1:10
    x = xnew - ((xnew.^2-a)./(xnew + xold)); 
  	fprintf('%d \t %1.14f \n',k,x)

    %this just updates the two points
    xold = xnew;
    xnew = x;
end
fprintf('\n')
    
%Halley method iteration
x = 2;
fprintf('Halleys\nk\tx_k\n===================\n');
for k = 1:10
    x = x - ((2.*x.*(x.^2-a))./(3.*x.^2+a));
	fprintf('%d \t %1.14f \n',k,x)
end
fprintf('\n')
