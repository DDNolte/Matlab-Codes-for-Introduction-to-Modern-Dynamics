% function node = makeSF(N,m)
% Creates a Scale-Free graph of N nodes and m linksper new node
% node structure is ...
% node(1).element = node number;
% node(1).numlink = number_of_links;
% node(1).link = [set of linked node numbers];

function node = makeSF(N,m)

% Set node initial structure
node = makeER(2*m,1);
numnodes = 2*m;

for addloop = 2*m+1:N   % add nodes up to N

    node = addnode(addloop,node);

    sumdegree = 0;
    for dloop = 1:numnodes
        sumdegree = sumdegree + node(dloop).numlink;
    end     % end dloop
    for dloop = 1:numnodes
        nodeprob(dloop) = node(dloop).numlink/sumdegree;
    end     % end dloop

    for mloop = 1:m     % add m links preferentially

        flag = 1;   
        while flag == 1
            temp = nonuniformrand(numnodes,nodeprob);
            Ar = ismember(node(addloop).link,temp);
            if sum(Ar) == 0
                 nodetolink = temp;
                 flag = 0;
            end
        end

        node = addlink(addloop,nodetolink,node);

    end     % end mloop

numnodes = numnodes + 1;

end     % end node addition loop

