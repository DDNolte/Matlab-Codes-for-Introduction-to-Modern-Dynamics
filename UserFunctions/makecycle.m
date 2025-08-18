% function node = makecycle(N)
% Creates cyclic (linear) graph with N nodes

function node = makecycle(N)

node(1).element = 1;
node(1).numlink = 0;
node(1).link = [];

for loop = 2:N-1
    node = addnode(loop,node);
    node(loop).element = loop;
    node(loop).numlink = 2;
    node(loop).link = [loop-1 loop+1];
end

node(1).element = 1;
node(1).numlink = 2;
node(1).link = [N 2];

node(N).element = N;
node(N).numlink = 2;
node(N).link = [N-1 1];


end
