% function [A,degree,Lap] = adjacency(node)
% Extract adjacency matrix, node degree and Laplacian of a graph
% node structure is ...
% node(1).element = node number;
% node(1).numlink = number_of_links;
% node(1).link = [set of linked node numbers];


function [A,degree,Lap] = adjacency(node)

[dum,N] = size(node);
A = zeros(N,N);
Lap = zeros(N,N);

for Nloop = 1:N
    
    [dum,L] = size(node(Nloop).link);
    
    for Lloop = 1:L
        
        A(Nloop,node(Nloop).link(Lloop)) = 1;
        A(node(Nloop).link(Lloop), Nloop) = 1;
        
    end     % end Lloop
    
end     % end Nloop

degree = sum(A);

Lap = -A;
for loop = 1:N
    Lap(loop,loop) = degree(loop);
end

