f=@(x)x.^(1/2);
f3a=@(x) (3/8).*x.^-(5/2);
format long
h=[0 0 0 0 0 0 0 0 0 0 0 0 0];
h(1)=1;
for k=2:12
   h(k)= h(k-1)/10; 
end
h=h';
x0=3;
f3=@(z)((-2.*(f(x0+z)-f(x0-z))+f(x0+(2.*z))-f(x0-(2.*z)))./(2.*(z.^3)));

figure(1);
loglog(h,h.^2,'m-')
hold on;
loglog(h,abs(f3a(x0)-f3(h)),'b-')