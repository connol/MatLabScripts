xx = pi*(-1:0.01:1);    
yy =exp(-abs(xx));
yyy = exp(-xx);
figure(1); plot(xx,yy,'k-'); hold on;
plot(xx,yy,'k-');
colors = {'r-','b-','g-'};
N = [5 10 20];
syms p;
for j = 1:3
    a0 = (-exp(-pi)+exp(pi))/(2.*pi);%put in your expression for a0
    b0 = 1./pi.*(((-exp(-pi)+exp(0)))+(exp(0)-exp(-pi)));
    S = a0*ones(size(xx));
    D = b0/2*ones(size(xx)); %start with a0
    for k = 1:N(j)
        ak = 1/pi.*((exp(pi).*cos(-k.*pi)-(exp(-pi).*cos(k.*pi)))/(k.^2+1));%put in your expression for ak
        bk= 1/pi.*(((exp(pi).*k.*cos(-k.*pi))-(exp(-pi).*k.*cos(k.*pi)))./(k.^2+1));
        ck = 2/pi.*(((-exp(-pi).*cos(k.*pi))+(exp(0).*cos(k.*0)))/(k.^2+1));
        S = S + ((ak * cos(k*xx))+(bk * sin(k*xx)));
        D = D + ck*cos(k*xx);
    end
    
    subplot(1,2,1),plot(xx,S,colors{j}); hold on
    plot(xx,yyy,'k-');
    subplot(1,2,2),plot(xx,D,colors{j});
    hold on;
    plot(xx,yy,'k-');
end
axis tight; grid on;
hold off;