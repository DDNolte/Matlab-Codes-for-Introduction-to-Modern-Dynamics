% function [w,N] = where(invec,num)
% finds where num is located in 1D vector invec
% returns all N instances
% See also where2.m for 2D matrix

function [w,N] = where(invec,num)
eps = 1e-3;

[sy,sx] = size(invec);
if sx == 1
    invec = invec';
end
[~,sz] = size(invec);

w = -1;
ind = 0;
for loop = 1:sz
        tst = abs(invec(loop)-num);
    if tst < eps
        ind = ind+1;
        w(ind) = loop;
    end
end
N = ind;

[~,Ntemp] = size(w);
if (Ntemp==1 && w==-1)
    N = 0;
end



