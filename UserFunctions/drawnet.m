% function y = drawnet(node,opt)
% draws a graph of the node network
% opt = 0 draws all nodes in a circle (default if no option stated)
% opt = 1 draws nodes at radius proportional to degree
% opt = 2 draw circle of nodes with color according to node.value
% See also:
%    DynamicDrawnet.m
%    drawnetC.m

function drawnet(node,opt)

if nargin < 2
    opt = 0;
end

[dum,N] = size(node);

% if opt == 2
%     mx = node(1).value;
%     for loop = 2:N
%         if node(loop).value > mx
%             mx = node(loop).value;
%         end
%     end
%     mn = node(1).value;
%     for loop = 2:N
%         if node(loop).value < mn
%             mn = node(loop).value;
%         end
%     end
% end


h = colormap(jet);
%h = newcolormap('heated');
fh = gcf;
clf;
%figure(fh)

if opt~=2
    [N,e,avgdegree,maxdegree,mindegree,numclus,meanclus,Lmax,L2,LmaxL2,meandistance] = clusterstats(node);
    disp(' ')
    displine('Number of nodes = ',N)
    disp(strcat('Number of edges = ',num2str(e)))
    disp(strcat('Mean degree = ',num2str(avgdegree)))
    displine('Maximum degree = ',maxdegree)
    disp(strcat('Number of clusters = ',num2str(numclus)))
    disp(strcat('mean cluster coefficient = ',num2str(meanclus)))
    disp(strcat('mean distance = ',num2str(meandistance)))
    disp(' ')
    disp(strcat('Lmax = ',num2str(Lmax)))
    disp(strcat('L2 = ',num2str(L2)))
    disp(strcat('Lmax/L2 = ',num2str(LmaxL2)))
    disp(' ')
end


if (opt == 0)||(opt == 2)  % Circle of nodes
    [A,degree,Lap] = adjacency(node);
    [N,e,avgdegree,maxdegree,mindegree,numclus,meanclus,Lmax,L2,LmaxL2] = clusterstats(node);
    deltheta = 2*pi/N;
    
    % Draw nodes
    for loop = 1:N
        theta = deltheta*loop;
        rad = 2*N;
        x(loop) = rad*cos(theta);
        y(loop) = rad*sin(theta);

        if opt == 2
            colorval = ceil(230*maskbilevel(node(loop).value,0,1,0,1)) + 1;
        else
            colorval = ceil(rand*255);
        end

        crad = pi/1.;
        rectangle('Position',[x(loop)-crad,y(loop)-crad,2*crad,2*crad],...
            'Curvature',[1,1],...
            'LineWidth',0.1,'LineStyle','-','FaceColor',h(colorval,:))
    end
    
    % Draw links
    ind = 0;
     for nloop = 1:N
        nlink = node(nloop).numlink;
        deg = degree(nloop);
        for linkloop = 1:nlink
            target = node(nloop).link(linkloop);
            looptarget = target;
            if deg == maxdegree
                maxnode(ind+1) = node(nloop).element;
            end
            line([x(nloop) x(looptarget)],[y(nloop) y(looptarget)],'Color', 'b');
        end
     end
   
    axis equal


end % end if opt == 0


if opt == 1  % Radius proportional to degree

    % Similarity matrix
    for rowloop = 1:N
        for coloop = rowloop+1:N

            a = node(rowloop).link;
            b = node(coloop).link;
            c = intersect(a,b);
            [dum,szc] = size(c);
            D(rowloop,coloop) = szc;
            D(coloop,rowloop) = szc;
        end
    end


    [newDis,finallabel] = hierarchcluster(D);
    [A,degree,Lap] = adjacency(node);


    [N,e,avgdegree,maxdegree,mindegree,numclus,meanclus,Lmax,L2,LmaxL2] = clusterstats(node);
    maxrad = 1.2*2*N/(mindegree+2);
    %circle(0,0,maxrad);

    % Draw Nodes
    deltheta = 2*pi/N;
    for loop = 1:N

        nodelabel(loop) = finallabel(loop);
        looplabel(nodelabel(loop)) = loop;

        rad = 2*N/(node(nodelabel(loop)).numlink+2);
        theta = deltheta*loop;

        x(loop) = rad*cos(theta);
        y(loop) = rad*sin(theta);

        colorval = ceil(rand*255);

        rectangle('Position',[x(loop)-1,y(loop)-1,2,2],...
            'Curvature',[1,1],...
            'LineWidth',0.1,'LineStyle','-','FaceColor',h(colorval,:))

        %pause(0.5)
    end

    % Draw Links
    for nloop = 1:N

        nlink = node(nodelabel(nloop)).numlink;
        deg = degree(nodelabel(nloop));

        for linkloop = 1:nlink

            target = node(nodelabel(nloop)).link(linkloop);
            looptarget = looplabel(target);

            if deg == maxdegree
                line([x(nloop) x(looptarget)],[y(nloop) y(looptarget)],'Color','r');
                %nlink
            else
                line([x(nloop) x(looptarget)],[y(nloop) y(looptarget)],'Color', 'b');

            end

        end



    end

    for loop = 1:N
        theta = deltheta*loop;

        colorval = ceil(rand*255);

        rectangle('Position',[x(loop)-1,y(loop)-1,2,2],...
            'Curvature',[1,1],...
            'LineWidth',0.1,'LineStyle','-','FaceColor',h(colorval,:))

    end
end % if opt == 1



