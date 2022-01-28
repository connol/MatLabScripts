%%
% Stability Demo 
% Shown in class on Sept 30, 2019 
% An example of an *unstable* computation of the integral of x^n/(x+10) for
% increasing n.


%%

I = exp(1)-1;   %for n=0 we get ln(11/10)

for n = 1:25    %go up to n = 25
    val = exp(1)-(n.*(I(n)));    %I(n) instead of I(n-1) because of matlab indexing   
    I = [I val];                %Concatenate the values for printing
end

%print the output in a nicely formatted way using fprintf
fprintf('  n\t        I_n\n------\t-------------\n');
fprintf(' %d\t\t %1.10f\n',[(0:25); I]);