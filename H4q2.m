load('a4q2.mat');
[a0,a,b]=dft1e(y);
figure(1);bar(a0);
hold on;
bar(a);
bar(b);
for k=1:63
    
   if(abs(a(k))< abs(a(6)))
      a(k) = 0; 
   end
   
   if(abs(b(k))<abs(a(6)))
       b(k)=0;
   end
    
    
end
if(abs(a(64))<abs(a(6)))
    a(64) =0;
end
a 
b
xx=(pi/64)*(0:.1:127);
yy=dft2e(xx,a0,a,b);
figure(2);
hold on;
plot(x,y,'bx');
plot(xx,yy,'m-');
