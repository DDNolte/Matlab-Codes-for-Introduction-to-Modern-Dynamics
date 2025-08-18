% function newnode = removezerok(node)

function newnode = removezerok(node)

tempnode = node;

flag = 1;
while flag == 1
    
    [dum sz] = size(tempnode);
    if sz < 2
        flag = 0;
    end
    
    tempflag = flag; ind = 1;
    while (tempflag == 1)&&(ind <=sz)
        if tempnode(ind).numlink == 0
            tempnode = removenode(ind,tempnode);
            tempflag = 0;
        end
        ind = ind + 1;
    end
    if tempflag == 1
        flag = 0;
    end
        
end

newnode = tempnode;