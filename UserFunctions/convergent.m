%function [p q] = convergent(r,N)
% Nth convergent of real number r (up to N = 38)
% p and q are relatively prime
%
% see also continued.m


function [p q] = convergent(r,Ntmp)

N = Ntmp + 1;
a = continued(r,N);

num = 1;
denom = a(N);

flag = 1;
while flag == 1
    if denom == 0
        N = N-1;
        denom = a(N);
    else
        flag = 0;
    end
end
    
for loop = 1:N-1
    
    if(loop<(N-1))
        num = a(N-loop)*denom + num;
        tmp = denom;
        denom = num;
        num = tmp;
    else
        num = a(N-loop)*denom + num;
    end
end

p = num;
q = denom;

