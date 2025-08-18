% function node = makeLB(N,m,)
% Creates a linear graph (cycle) of N nodes and 2*m neighbor links per new node
% node structure is ...
% node(1).element = node number;
% node(1).numlink = number_of_links;
% node(1).link = [set of linked node numbers];


function node = makeLB(N,m)

A = zeros(N,N);

node(1).element = 1;
node(1).numlink = 2*m;
node(1).link = [];
for loop = 2:N
    node = addnode(loop,node);
    node(loop).numlink = 2*m;
end

for loop = 1:N
    nlinks = 0;
        for neighloop = 1:m
            nlinks = nlinks + 1;
            if (loop+neighloop) <=N
                A(loop,loop+neighloop) = 1;
                node(loop).link(nlinks) = loop+neighloop;
            else
                A(loop,loop+neighloop-N) = 1;
                node(loop).link(nlinks) = loop + neighloop-N;
            end
            nlinks = nlinks+1;
            if (loop-neighloop) >=1
                A(loop,loop-neighloop) = 1;
                node(loop).link(nlinks) = loop-neighloop;
            else
                A(loop,N + loop - neighloop) = 1;
                node(loop).link(nlinks) = N + loop - neighloop;
            end
        end
end

% figure(1)
% imagesc(A)
% size(A)







