% function DynamicDrawNet(node, kspring,varargin)
% input variables:
%          node is a clustered network structure
%          kspring is spring constant
%   >>> Spring constant not implemented yet
% See also DrawNetC.m for only endstate
%    drawnet.m
%    DrawNetC.m
%    DrawNetCname.m


function [xp,yp] = DynamicDrawNet(node,kspring,varargin)


mov_flag = 0;
if mov_flag == 1
    moviename = 'DrawNetMovie';
    aviobj = VideoWriter(moviename,'MPEG-4');
    aviobj.FrameRate = 10;
    open(aviobj);
end


%node = removezerok(node);   % Remove nodes with no links

fieldtest = isfield(node,'numval');
if fieldtest == 1
    mincval = 0;maxcval = 1;
    for loop = 1:length(node)
        if node(loop).numval > mincval
            mincval = node(loop).numval;
        end
        if node(loop).numval < maxcval
            maxcval = node(loop).numval;
        end
    end
end

[dum,N] = size(node);

stretch = 0.333;

hh = colormap(jet);
%hh = colormap(gray);
%rie = randintexc(255,255);       % Use this for random colors
rie = 1:255;                     % Use this for sequential colors
for loop = 1:255
    h(loop,:) = hh(rie(loop),:);
end
fh = gcf;
clf;
hh = figure(fh);
set(gcf,'Color','White')
axis off

[N,e,avgdegree,maxdegree,mindegree,numclus,meanclus,Lmax,L2,LmaxL2] = clusterstats(node);
disp(' ')
displine('Number of nodes = ',N)
disp(strcat('Number of edges = ',num2str(e)))
disp(strcat('Mean degree = ',num2str(avgdegree)))
displine('Maximum degree = ',maxdegree)
disp(strcat('Number of clusters = ',num2str(numclus)))
disp(strcat('mean cluster coefficient = ',num2str(meanclus)))
disp(' ')
disp(strcat('Lmax = ',num2str(Lmax)))
disp(strcat('L2 = ',num2str(L2)))
disp(strcat('Lmax/L2 = ',num2str(LmaxL2)))
disp(' ')


[A,degree,Lap] = adjacency(node);
deltheta = 2*pi/N;

rad = N/2;


%%%%%%%%%%% Position nodes
ind = 0;
Nby2 = round(N/2);
Mby2 = N - Nby2;
for loop = 1:Nby2
    theta = deltheta*loop;
    ind = ind+1;
    %x(ind) = rad*cos(theta) + N*((clusloop-1)/numclus)^stretch*cos(theta0);
    %y(ind) = rad*sin(theta) + N*((clusloop-1)/numclus)^stretch*sin(theta0);
    x(ind) = rad*cos(theta) + randn/N;
    y(ind) = rad*sin(theta) + randn/N;
    
    node(ind).pos = [y(ind),x(ind)];
end
for loop = 1:Mby2
    theta = -deltheta*(loop-1);
    ind = ind+1;
    %x(ind) = rad*cos(theta) + N*((clusloop-1)/numclus)^stretch*cos(theta0);
    %y(ind) = rad*sin(theta) + N*((clusloop-1)/numclus)^stretch*sin(theta0);
    x(ind) = rad*cos(theta) + randn/N;
    y(ind) = rad*sin(theta) + randn/N;
    
    node(ind).pos = [y(ind),x(ind)];
end


%%%%%%%% Run Dynamics

for nodeloop = 1:N
    y0(nodeloop) = node(nodeloop).pos(1);
    y0(nodeloop+N) = node(nodeloop).pos(2);
end


% Time loop
difep = 100; difepmx = 100;  lastdis = 1;
xp = zeros(1,N); yp = zeros(1,N);
loop = 1;
while difepmx > 0.0005
    loop = loop + 1;
    
    eploop = loop;
    
    delt = 0.01;
    tspan = [0 loop*delt];
    [t,y] = ode45(@f5,tspan,y0);
    
    %%%%%%%%% Plot Final Positions
    
    [szt,szy] = size(y);
    
    % Set nodes
    ind = 0; xpold = xp; ypold = yp;
    for nloop = 1:N
        ind = ind+1;
        xp(ind) = y(szt,ind+N);
        yp(ind) = y(szt,ind);
    end
    delxp = xp - xpold;
    delyp = yp - ypold;
    maxdelx = max(abs(delxp));
    maxdely = max(abs(delyp));
    maxdel = max(maxdelx,maxdely);
    
    rngx = max(xp) - min(xp);
    rngy = max(yp) - min(yp);
    maxrng = max(abs(rngx),abs(rngy));
    
    difepmx = maxdel/maxrng;
    
    crad = min(rngx,rngy)/100;   % div by 100
    
    %     if eploop == 30
    %         keyboard
    %     end
    
    
    
    clf
    %figure(fh)
    
    
    % Draw Links
    Distemp = 0;
    for nloop = 1:N
        nlink = node(nloop).numlink;
        if fieldtest == 1
            colorval = 1;
        else
            colorval = ceil(255*nloop/N);
        end
        
        for linkloop = 1:nlink
            
            target = node(nloop).link(linkloop);
            line([xp(nloop) xp(target)],[yp(nloop) yp(target)],'Color', 1-exp(-3*h(colorval,:)),'LineWidth',1);
            
            ds = sqrt((xp(nloop)-xp(target))^2 + (yp(nloop) - yp(target))^2);
            Distemp = Distemp + ds;
            
        end
    end
    
    %Distemp
    Dis(loop) = Distemp;
    difep = abs(Distemp - lastdis)/N^2;
    lastdis = Distemp;
    
    %keyboard
    
    % Draw nodes
    for nloop = 1:N
        rn = rand*63+1;
        if fieldtest == 1
            colorval = ceil(255*(node(nloop).numval - mincval)/(maxcval-mincval)/1.04) + 1;
        else
            colorval = ceil(255*nloop/N);
        end
        
        rectangle('Position',[xp(nloop)-crad,yp(nloop)-crad,2*crad,2*crad],...
            'Curvature',[1,1],...
            'LineWidth',0.1,'LineStyle','-','FaceColor',h(colorval,:))
        
        %text(xp(nloop)+crad,yp(nloop),num2str(nloop))
        
        xt = xp(nloop)-1;
        yt = yp(nloop);
        %text(xt,yt,num2str(newnode(clusloop).data(loop)))
        
        
    end
    
    [syy,sxy] = size(y);
    y0(:) = y(syy,:);
    
    
    axis equal
    scal = 4/avgdegree;
    if numclus>1
        %axis([-scal*rad scal*rad -scal*rad scal*rad])
    end
    drawnow
    pause(0.1)
    
    hh = figure(1);
    
    if mov_flag == 1
        frame = getframe(hh);
        writeVideo(aviobj,frame);
    end
    
end     % end  time loop

% figure(10)
% plot(Dis)

% if mov_flag == 1
%     close(aviobj);
% end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function yd = f5(t,y)
        
        Ac = 100;      % Coulomb factor
        B = 1;      % Spring constant  (1 or 0.125 for global)
        gam = 1;  % Damping
        eps = 1;  % 0.1
        
        for nodeloop = 1:N
            linksz = node(nodeloop).numlink;
            
            posy = y(nodeloop);
            posx = y(nodeloop+N);
            tempkx = 0; tempky = 0;
            tempcx = 0; tempcy = 0;
            
            
            for cloop = 1:linksz   % Local
                cindex = node(nodeloop).link(cloop);
                
                cposy = y(cindex);
                cposx = y(cindex+N);
                
                KFx = B*(cposx-posx);
                KFy = B*(cposy-posy);
                
                tempkx = tempkx + KFx/gam;
                tempky = tempky + KFy/gam;
            end
            tempkx = tempkx - 0.1*B*posx/gam;
            tempky = tempky - 0.1*B*posy/gam;
            
            for nloop = 1:N
                if nloop ~=nodeloop
                    cposy = y(nloop);
                    cposx = y(nloop+N);
                    
                    dis = sqrt((cposy-posy)^2 + (cposx-posx)^2 + (eps+10/sqrt(eploop))^2);
                    CFx = Ac*(posx-cposx)/dis^3;
                    CFy = Ac*(posy-cposy)/dis^3;
                    
                    %                     KFx = B*positive(SimMat(nodeloop,nloop))*(cposx-posx); %  global
                    %                     KFy = B*positive(SimMat(nodeloop,nloop))*(cposy-posy);
                    %                     tempx = tempx + KFx/gam;
                    %                     tempy = tempy + KFy/gam;
                    
                    
                    tempcx = tempcx + CFx/gam;
                    tempcy = tempcy + CFy/gam;
                    
                end
            end
            
            ypp(nodeloop) = tempky + tempcy;
            ypp(nodeloop+N) = tempkx + tempcx;
        end
        
        for nodeloop = 1:N
            yd(nodeloop,1) = ypp(nodeloop);
            yd(nodeloop+N,1) = ypp(nodeloop+N);
        end
        
    end     % end f5


end % end Dynamic DrawNet

