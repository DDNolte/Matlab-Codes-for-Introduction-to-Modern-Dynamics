% function node = maketree(degree,depth)
% Creates a tree of given degree and depth
% node structure is ...
% node(1).element = node number;
% node(1).numlink = number_of_links;
% node(1).link = [set of linked node numbers];


function node = maketree(degree,depth)

% First calculate size of tree
temp = 0;
for loop = 0:depth
    temp = temp + degree^loop;
end
treesize = temp;
disp(strcat('treesize = ',num2str(treesize)))

% Set node structure
node(1).element = 1;
node(1).numlink = 0;
node(1).link = [];

level(1) = 0;

activestack.data(1) = 1;
activestack.top = 1;

availnum = 2;   % Next available node number

test = 1;
while test >= 1

    [activestack,activenode] = pop(activestack);    % take top stack element
    if level(activenode) < depth

        for loop = 1:degree

            newnodenum = availnum;

            activestack = put(newnodenum,activestack);      % add an element to the stack for later expansion
            node = addnode(newnodenum,node);
            level(newnodenum) = level(activenode) + 1;
            node = addlink(newnodenum,activenode,node);

            availnum = availnum + 1;

        end     % end degreeloop

    end     % end if level < depth

    test = activestack.top;

end     % end whileloop


end     % end function maketree

