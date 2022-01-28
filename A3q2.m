B=[2 2 8/3 4;2 8/3 4 32/5;8/3 4 32/5 32/3;4 32/5 32/3 128/7];
b = [log(3) 2-log(3) log(3) 8/3-log(3)];
b=b';
f=@(i)1./(i+1);
cs = B\b;
x=0:.01:2;
q3=cs(1) + cs(2).*x + cs(3).*x.^2+cs(4).*x.^3;
s = cheb_points(5)+1;




cj=divdif(s,f(s));
cj=evalnewt(x,s,cj);


plot(x,abs(f(x)-q3),'g-');
hold on
plot(x,abs(f(x)-cj),'r-');

legend('q3','Cheb p3');
title('Error');
