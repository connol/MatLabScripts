
r=[2;4;6;8;16;32];
f = @(x) 1./(x+1);
df=@(x) (log(x+1));
T=zeros(6,1);
M = zeros(6,1);
S = zeros(6,1);
h=zeros(6,1);
for k= 1:length(r)
    
[T(k),M(k),S(k)]=comp_trap(f,0,1,r(k));

end
err = df(1)-df(0);
subplot(3,1,1);
loglog(r,abs(T-err),'m-');
hold on;
title('Trap rule');
subplot(3,1,2);
loglog(r,abs(M-err),'b-');
title('Midpoint Rule');
subplot(3,1,3);
loglog(r,abs(S-err),'r-');
title('Simpsons Rule');

