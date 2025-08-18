% function [synch,l2,lmax,spec] = eigenlap(node)
% Calculates the eigenvalues 2 and N
% synch = ratio l2/lmax gives measure of synchronizabity
% spec is the full spectrum


function [synch,l2,lmax,spec] = eigenlap(node)

[A,degree,Lap] = adjacency(node);

[dum,N] = size(Lap);
l = eig(Lap);
spec = l;

flag = 0; ind = 1;
while flag == 0
    ind = ind + 1;
    l2tmp = min(l(ind:N));
    if l2tmp > 1/sqrt(N)
        l2 = l2tmp;
        flag = 1;
    end
end
        

lmax = l(N);
synch = lmax/l2;
