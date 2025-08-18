%function  [cluscoef,eicoef,clus,ei] = clustercoef(node)
% cluscoef = average of 2E/k(k-1)
% eicoef = average number of shared edges
% clus = clustering of node
% ei = shared edges of node

function [cluscoef,eicoef,clus,ei] = clustercoef(node)

[Adjac,degree,Lap] = adjacency(node);

[dum,N] = size(Adjac);

for iloop = 1:N
    temp = 0;
    for rowloop = 1:N
        for coloop = 1:N
            temp = temp + 0.5*Adjac(iloop,rowloop)*Adjac(rowloop,coloop)*Adjac(coloop,iloop);
        end
    end

    ei(iloop) = temp;
    ki = node(iloop).numlink;

    if ki > 1
        clus(iloop) = 2*ei(iloop)/ki/(ki-1);
    else
        clus(iloop) = 0;
    end
end

cluscoef = mean(clus);
eicoef = mean(ei);

%keyboard

