% function node = makeglobal(N)
% Creates complete graph with N nodes

function node = makeglobal(N)

node(1).element = 1;
node(1).numlink = 0;
node(1).link = [];

for loop = 2:N

    node = addnode(loop,node);

    for linkloop = 1:loop-1

        node = addlink(loop,linkloop,node);

    end

end

end
