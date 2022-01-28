f=@(x) exp(sin(x));
g=@(x) exp(x).*sin(x);
h=@(x) x.*asin(x);
fval=2*pi*besseli(0,1);
gval=.5.*(1+exp(pi));
hval=(pi./4);
nodes=33;
ints={f; g; h};
trap=[0; 0; 0];
Rom={0;0;0};
Gaus=[0;0;0];
%Comp trap
trap(1)=comp_trap(f,0,2.*pi,nodes);
trap(2)=comp_trap(g,0,pi,nodes);
trap(3)=comp_trap(h,-1,1,nodes);
%Romberg
Rom1=romberg(f,0,2.*pi,6);
Rom2=romberg(g,0,pi,6);
Rom3=romberg(h,-1,1,6);
%Gaussian
[x,w]=lgwt(nodes,0,2.*pi);
Gaus(1)=sum(f(x).*w);
[x,w]=lgwt(nodes,0,pi);
Gaus(2)=sum(g(x).*w);
[x,w]=lgwt(nodes,-1,1);
Gaus(3)=sum(h(x).*w);
%Trap error
fval-trap(1)
gval - trap(2)
hval- trap(3)
%Rom error
fval-Rom1(6,6)
gval - Rom2(6,6)
hval- Rom3(6,6)
%Gaus error
fval-Gaus(1)
gval - Gaus(2)
hval- Gaus(3) 

