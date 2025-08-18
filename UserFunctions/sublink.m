%function node = sublink(node1,node2,node)

function newnode = sublink(node1,node2,node)

templink1 = node(node1).link;
templink2 = node(node2).link;

tempnode = node;
clear node

% templink1
% node2
% templink2
% node1
w1 = where(templink1,node2);
w2 = where(templink2,node1);

if (w1(1) == -1)||(w2(1) == -1)
    disp('Error in sublink: node missing')
    newnode = tempnode;
    return
end

nlink1 = tempnode(node1).numlink;
if nlink1 == 1                          % only one linke in set 
    tempnode(node1).numlink = 0;
    tempnode(node1).link = [];
elseif w1 == nlink1             % target at end of set
    newnlink = nlink1 - 1;
    temp1 = templink1(1:newnlink);
    tempnode(node1).numlink = newnlink;
    tempnode(node1).link = temp1;
    tempnode(node1).numlink = newnlink;
else
    newnlink = nlink1 - 1;
    tempnode(node1).link(w1) = tempnode(node1).link(nlink1);
    temp1 =  tempnode(node1).link(1:newnlink);
    tempnode(node1).link = temp1;
    tempnode(node1).numlink = newnlink;
end

nlink2 = tempnode(node2).numlink;
if nlink2 == 1                          % only one linke in set 
    tempnode(node2).numlink = 0;
    tempnode(node2).link = [];
elseif w2 == nlink2             % target at end of set
    newnlink = nlink2 - 1;
    temp2 = templink2(1:newnlink);
    tempnode(node2).numlink = newnlink;
    tempnode(node2).link = temp2;
    tempnode(node2).numlink = newnlink;
else
    newnlink = nlink2 - 1;
    tempnode(node2).link(w2) = tempnode(node2).link(nlink2);
    temp2 = tempnode(node2).link(1:newnlink);
    tempnode(node2).link = temp2;
    tempnode(node2).numlink = newnlink;
end


newnode = tempnode;


