% function node = make2Dlattice(N,M)
% Creates 2D lattice graph with N rows and M columns
% Periodic boundary conditions

function node = make2Dlattice(N,M)

node(1).element = 1;
node(1).numlink = 0;
node(1).link = [];

% Make nodes and internal links
for rowloop = 1:N
    for colloop = 2:M-1
        index = (rowloop-1)*M + colloop;
        
        node = addnode(index,node);
        node(index).element = index;
        node(index).numlink = 4;
        node(index).link = [index-1 index+1];
        
    end
    
    node((rowloop-1)*M+1).element = (rowloop-1)*M+1;
    node((rowloop-1)*M+1).numlink = 4;
    node((rowloop-1)*M+1).link = [M*rowloop (rowloop-1)*M+2];
    
    node(rowloop*M).element = rowloop*M;
    node(rowloop*M).numlink = 4;
    node(rowloop*M).link = [rowloop*M-1 (rowloop-1)*M+1];
    
end

% Make edge  links
for rowloop = 2:N-1
    for colloop = 1:M
        index = (rowloop-1)*M + colloop;
        
        node(index).link(3) = (rowloop-2)*M + colloop;
        node(index).link(4) = rowloop*M + colloop;
        
    end
end

for colloop = 1:M
    node(colloop).link(3) = (N-1)*M + colloop;
    node(colloop).link(4) = M + colloop;
    
    node((N-1)*M + colloop).link(3) = (N-2)*M + colloop;
    node((N-1)*M + colloop).link(4) = colloop;
    
end



