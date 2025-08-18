%function newnode = subnode(nodenum,node)
% deletes all links to node, but keeps node

function newnode = subnode(nodenum,node)

[dum sz] = size(node);

tempnode = node;

for nodeloop = 1:sz
    nlink = node(nodeloop).numlink;
    for linkloop = 1:nlink
        linknum = node(nodeloop).link(linkloop);
        if (linknum == nodenum)
            gonode.label(1) = nodenum;
            gonode.label(2) = node(nodeloop).element; 
            tempnode = sublink(gonode.label(1),gonode.label(2),tempnode);
        end
    end
end

%newnode = removezerok(tempnode);
newnode = tempnode;

