%function node = addnode(newnodenum,node)

function node = addnode(newnodenum,node)

[dum,sz] = size(node);

node(sz+1).element = newnodenum;
node(sz+1).numlink = 0;
node(sz+1).link = [];

end


