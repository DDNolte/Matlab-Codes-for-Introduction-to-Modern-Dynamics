% function node = siteperc(N,p)
% makes 2D lattice site percolation with occupancy p
% 

function node = siteperc(N,p)

node = make2Dlattice(N,N);

prob = 1 - p;
Del = randintexc(floor(prob*N^2),N^2);

dnum = length(Del);

for loop = 1:dnum
    
    node = subnode(Del(loop),node);
    
end

