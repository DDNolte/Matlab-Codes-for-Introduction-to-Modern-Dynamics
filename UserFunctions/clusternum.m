% function numclus = clusternum(node)
% Number of disconnected clusters

function numclus = clusternum(node)

[dum,N] = size(node);
[A,degree,Lap] = adjacency(node);
LamL = eig(Lap);

% Calculate number of disconnected clusters
dflag = 0; loop = 0; cnt = 0;
while dflag == 0
    loop = loop + 1;
    if LamL(loop) < 1e-3
        cnt = cnt + 1;
    else
        dflag = 1;
    end
end
numclus = cnt;
