% function node = makeLN(N,m)
% Creates a linear graph (non-cycle) of N nodes and 2*m neighbor links per new node
% node structure is ...
% node(1).element = node number;
% node(1).numlink = number_of_links;
% node(1).link = [set of linked node numbers];


function node = makeLN(N,m)

node(1).element = 1;
node(1).numlink = 0;
node(1).link = [];
for loop = 2:N
    node = addnode(loop,node);
end


for loop = 1:N
    nlinks = 0;
    for neighloop = 1:m
        if (loop+ neighloop) <=N
            node = addlink(loop,loop+neighloop,node);
        end
%         if (loop - neighloop) >=1
%             node = addlink(loop,loop-neighloop,node);
%         end

    end
end








