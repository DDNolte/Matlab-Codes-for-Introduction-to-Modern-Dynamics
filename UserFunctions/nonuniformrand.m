% function nur = nonuniformrand(N,wt)
% wt is size N vector with sum(wt) = 1
% output is whole number between 1 and N with prob given by wt(N)

function nur = nonuniformrand(N,wt)

[Y,I] = sort(wt);

S(1) = wt(I(1));
for loop = 2:N
    S(loop) = S(loop-1) + wt(I(loop));
end

R = rand;

nur = 0;
flag = 1;
i = 1;
while flag == 1
    if max(S(i),R) == R
        i = i+1;
    else
        nur = I(i);
        flag = 0;
    end
    
end % end while flag

