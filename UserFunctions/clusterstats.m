% function[N,e,avgdegree,maxdegree,mindegree,numclus,meanclus,Lmax,L2,LmaxL2,meandistance,diam] = clusterstats(node)
% Generates statistics on selected  graphs
% N = size of network
% e = number of edges
% avgdegree = average degree
% maxdegree = maximum degree
% mindegree = minimum degree
% numclus = number of clusters
% meanclus = cluster coef
% Lmax = maximum eigenvalue
% L2 = second eigenvalue
% LmaxL2 = ratio of Lmax to L2
% meandistance = mean of the distances

function [N,e,avgdegree,maxdegree,mindegree,numclus,meanclus,Lmax,L2,LmaxL2,meandistance,diam] = clusterstats(node)

[dum,N] = size(node);
[A,degree,Lap] = adjacency(node);

e = sum(degree)/2;  % number of edges
avgdegree = mean(degree);
maxdegree = max(degree);
mindegree = min(degree);

for loop = 0:maxdegree
   p(loop+1) = sum(degree == loop)/N; 
end


loop2 = trace(A^2);

[cluscoef,eicoef,clus,ei] = clustercoef(node);
meanclus = cluscoef;
dis = node2distance(node);
meandistance = mean(mean(dis))*(N^2/(N*(N-1)));
diam = max(max(dis));


Lam = eig(A);

LamL = eig(Lap);
Lmax = LamL(N);

% Calculate number of disconnected clusters
dflag = 0; loop = 0; cnt = 0;
while dflag == 0
    loop = loop + 1;
    if loop <=N
        if LamL(loop) < 0.1/N
            cnt = cnt + 1;
        else
            dflag = 1;
        end
    else
        dflag = 1;
    end
end
numclus = cnt;

if numclus == 1
    L2 = LamL(2);
    LmaxL2 = Lmax/L2;
else
    L2 = 0;
    LmaxL2 = 0;
end




