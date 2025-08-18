% function M = threshmask(A,thrsh)
% (Questionable functionality)

function M = threshmask(A,thrsh)

if thrsh == 0
    mxA = max(max(A));
    M = round(fermi(500*A/mxA));
else
B = sign(thrsh).*1e6*(1 - A/(thrsh + 1e-20));

M = round(fermi(B));

end



