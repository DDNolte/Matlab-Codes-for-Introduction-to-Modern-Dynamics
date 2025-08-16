% function node = makeSW(N,m, p)
% Creates a Small-world graph of N nodes and 2*m links per new node
% p is the re-wiring probability
% node structure is ...
% node(1).element = node number;
% node(1).numlink = number_of_links;
% node(1).link = [set of linked node numbers];
% Calls:
%  makeLB
%  sublink
%  addlink


function node = makeSW(N,m,p)

% Set node initial structure
node = makeLB(N,m);             % linear cycle with 2*m neighbors

for loop = 1:N
    %loop
    nlink = node(loop).numlink;
    linknum = node(loop).link;

    for linkloop = 1:nlink
        oldtarget = linknum(linkloop);

        if oldtarget > loop

            test = rand;
            if test < p

                node = sublink(loop,oldtarget,node);

                flag = 1;
                while flag == 1
                    ind = round(rand*(N-1)) + 1;
                    if ind ~= loop
                        flag = 0;
                        node = addlink(loop,ind,node);
                    end
                end     % end while
                
%                 drawnet(node)
%                 keyboard

            end     % end test

        end     % end if oldtarget

    end     % end linkloop

end     % end loop
