%lsqdemo.m
%Demo of doing a quadratic least squares fit in Matlab 

% data containing MPG (y) as a function of horsepower (x)
load mpgdata
format long

%plot the data as discrete points
figure(1); 
plot(x,y,'b.','MarkerSize',16); hold on; grid on   %the hold on command allows us to plot multiple data sets on the same axes
title('MPG vs horsepower'); ylabel('MPG'); xlabel('HP'); set(gca,'FontSize',16,'FontWeight','bold');

m = size(x,1);
A = [ones(m,1), x,x.^2];
B = [log(x),x];
C = [log(x),ones(m,1)];
n = inv(C'*C)*C'*log(y);
c = C*n;
p = exp(c);
z = inv(B'*B)*B'*log(y);
b = B*z;
l=exp(b);
v= inv(A'*A)*A'*y;
q=(A*v);

plot(x,q);
plot(x,l);
plot(x,p);


legend("Data","Qudratic", "Exponetial", "Power Function");
hold off; %turn off hold