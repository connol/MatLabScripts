%x = 1:3; y = [2 3 5];
%figure(1); plot(x,y,'ko'); hold on;

xx = 0:0.01:2; 
%x values that will be used for plotting the spline
%Hermite calculations
f=@(x)1./(x+1);
fp=@(x)-1./((x+1).^2);
t=[0 1];
k=[1 2];
y=f(t);
yip=(fp(t));
yy=f(k);
yyip=fp(k);
tt=0:.01:1;
kk=1:.01:2;
s0herm = evalnewt(tt,t,divdif2(t,y,yip));
s1herm = evalnewt(kk,k,divdif2(k,yy,yyip));
d=divdif2(t,y,yip)
dd=divdif2(k,yy,yyip)
%Natural Spline
s0 = 1 + (-7/12)*xx + 0 + (1/12)*xx.^3;% put in your formula for s0 here
s1 = 1/2 + (-1/3)*(xx-1) + (1/4)*(xx-1).^2 + (-1/12)*(xx-1).^3;
%Clamped Spline
s2 = 1 + -1*(xx) + (13/18)*(xx).^2 + (-2/9)*(xx).^3;% put in your formula for s0 here
s3 = 1/2 + (-2/9)*(xx-1) + (1/18)*(xx-1).^2 + (0);
s4 = 1+-1.*xx+(3/4).*(xx).^2+(-1/4).*xx.^3;
s5 = 1/2+(-1/4).*(xx-1)+(1/9).*((xx-1)).^2+(-1/36).*((xx-1)).^3;

v = s0 .* (xx <= 1) + s1 .* (xx > 1); 
b = s2 .* (xx <= 1) + s3 .* (xx > 1);%plots the piecewise function

e =s4 .* (xx <= 1) + s5 .*(xx > 1);
%Regular functions plot
figure(1);
plot(xx,e,'c-');
hold on;
plot(xx,v,'b-');
plot(xx,b,'r-');
plot(xx,f(xx),'m-');
grid;
legend('Hermite','Natural','Clamped','Original');
hold off
%Error Plot
figure(2);
plot(xx,abs(f(xx)-e),'c-');
hold on
plot(xx,abs(f(xx)-v),'b-');
hold on;
plot(xx,abs(f(xx)-b),'r-');
grid;
legend('Hermite','Natural','Clamped');
title('Error question 1');
hold off;