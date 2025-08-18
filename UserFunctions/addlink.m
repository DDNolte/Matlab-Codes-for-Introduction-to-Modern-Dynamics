%function node = addlink(node1,node2,node)
function node = addlink(node1,node2,node)

ind = node(node1).numlink;
node(node1).link(ind+1) = node2;
node(node1).numlink = ind + 1;

ind = node(node2).numlink;
node(node2).link(ind+1) = node1;
node(node2).numlink =ind+1;

end

