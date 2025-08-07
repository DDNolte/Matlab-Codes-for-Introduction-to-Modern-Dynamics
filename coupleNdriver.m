%coupleNdriver.m
% Calls: makeER, makerSF, makeSW, coupleN, coupleN0
%            makeglobal, make2Dlattice, makecycle, maketree, histfix
%            makehypercube, eigenlap, clustercoef, addlink

clear
format compact

% close(figure(7))
% close(figure(8))
% close(figure(1))
% close(figure(100))
close all

writeavi = 0;
example = 1;        % 1 = global     2 = distributed    3 = square lattice    4 = 1D lattice   5 = tree  6 = ER 7 = Scale-free
% 8 = small-world  9 = hypercube  10 = inverse scaling (black hole)   11 = linked node to cluster
inexcoupling = 1;       % 1 = intercoupling    2 = external coupling
Nfac = 50;   % 50  100  200

displine('Example = ',example);
displine('Coupling = ',inexcoupling);
displine('Nfac = ',Nfac);

if writeavi
    moviename = strcat('Couple.avi');
    aviobj = avifile(moviename,'fps',4);
end

%ch = colormap(lines);
%ch = newcolormap('fluoro');
% ch(32,:) = [0 0 0];
% ch(33,:) = [0 0 0];

ch = colormap(jet);
ch(32,:) = [0 0 0];
ch(33,:) = [0 0 0];

% h = colormap(gray);
% z = 1:32;
% h = zeros(64,3);
% h(1:32,1) = z/32;
% h(33:64,2) = (33-z)/32;
% h(32,:) = [0 0 0];
% h(33,:) = [0 0 0];




if example == 1     % Global coupling
    N = 50;        %100 256
    width = 0.2;
    facoef = 0.2;
    
    omegatemp = width*(rand(1,N)-1);
    meanomega = mean(omegatemp);
    omega = omegatemp - meanomega;
    sto = std(omega);
    
    node = makeglobal(N);
    
    [synch,l2,lmax] = eigenlap(node);
    displine('synch = ',synch)
    [cluscoef,eicoef,clus,ei] = clustercoef(node);
    displine('cluscoef = ',cluscoef)
    
    nodecouple = node;
    
    for loop = 1:N
        nodecouple(loop).element = omega(loop);
        lnk(loop) = nodecouple(loop).numlink;
    end
    
    avgdegree = mean(lnk)
    
    
elseif example == 2        % distributed example
    N = 11;
    width = 0.31;
    facoef = 0.3;
    
    omegat(1) = 0.16;
    omegat(2) = 0.24;
    omegat(3) = 0.28;
    omegat(4) = 0.30;
    omegat(5) = 0.31;
    omegat(6) = -0.16;
    omegat(7) = -0.24;
    omegat(8) = -0.28;
    omegat(9) = -0.30;
    omegat(10) = -0.31;
    omegat(11) = 0;
    
    for yloop = 1:N
        for xloop = 1:N
            g0(yloop,xloop) = 1;
        end
    end
    
    node = makeglobal(N);
    nodecouple = node;
    
    for loop = 1:N
        nodecouple(loop).element = omegat(loop);
        lnk(loop) = nodecouple(loop).numlink;
    end
    
    avgdegree = mean(lnk);
    displine('avgdegree =',avgdegree)
    sto = std(omegat);
    
    
elseif example ==3      % square lattice
    
    Row = 8;       %10
    Col = 8;           % 10
    N = Row*Col;
    width = 0.2;
    facoef = 0.35;
    
    omegatemp = width*(rand(1,N)-0.5);
    meanomega = mean(omegatemp);
    omega = omegatemp - meanomega;
    sto = std(omega);
    
    node = make2Dlattice(Row,Col);
    
    [synch,l2,lmax] = eigenlap(node);
    displine('synch = ',synch)
    [cluscoef,eicoef,clus,ei] = clustercoef(node);
    displine('cluscoef = ',cluscoef)
    
    nodecouple = node;
    
    for loop = 1:N
        nodecouple(loop).element = omega(loop);
        lnk(loop) = nodecouple(loop).numlink;
    end
    
    avgdegree = mean(lnk);
    displine('avgdegree =',avgdegree)
    
    
elseif example == 4      % linear cycle
    N = 64;
    width = 0.2;
    facoef = 1.3;
    
    omegatemp = width*(rand(1,N)-1);
    meanomega = mean(omegatemp);
    omega = omegatemp - meanomega;
    sto = std(omega);
    
    node = makecycle(N);
    nodecouple = node;
    
    for loop = 1:N
        nodecouple(loop).element = omega(loop);
        lnk(loop) = nodecouple(loop).numlink;
    end
    
    avgdegree = mean(lnk);
    displine('avgdegree =',avgdegree)
    
elseif example == 5     % make a tree
    degree = 2;
    depth = 5;
    width = 0.2;
    facoef = 1;
    
    node = maketree(degree, depth);
    
    [dum,N] = size(node);
    
    omegatemp = width*(rand(1,N)-1);
    meanomega = mean(omegatemp);
    omega = omegatemp - meanomega;
    sto = std(omega);
    
    nodecouple = node;
    
    for loop = 1:N
        nodecouple(loop).element = omega(loop);
        lnk(loop) = nodecouple(loop).numlink;
    end
    
    avgdegree = mean(lnk);
    displine('avgdegree =',avgdegree)
    
    
elseif example == 6     % Erdos graph
    N = 64;
    p = 0.06;
    width = 0.2;
    facoef = 0.7;
    
    omegatemp = width*(rand(1,N)-1);
    meanomega = mean(omegatemp);
    omega = omegatemp - meanomega;
    sto = std(omega);
    
    node = makeER(N,p);
    [synch,l2,lmax] = eigenlap(node);
    displine('synch = ',synch)
    [cluscoef,eicoef,clus,ei] = clustercoef(node);
    displine('cluscoef = ',cluscoef)
    
    nodecouple = node;
    
    for loop = 1:N
        nodecouple(loop).element = omega(loop);
        lnk(loop) = nodecouple(loop).numlink;
    end
    
    avgdegree = mean(lnk);
    displine('avgdegree =',avgdegree)
    
    %keyboard
    
elseif example == 7     % scale-free graph
    N = 64;
    m = 3;
    width = 0.2;
    facoef = 0.75;
    
    omegatemp = width*(rand(1,N)-1);
    meanomega = mean(omegatemp);
    omega = omegatemp - meanomega;
    sto = std(omega);
    
    node = makeSF(N,m);
    [synch,l2,lmax] = eigenlap(node);
    displine('synch = ',synch)
    [cluscoef,eicoef,clus,ei] = clustercoef(node);
    displine('cluscoef = ',cluscoef)
    
    nodecouple = node;
    
    for loop = 1:N
        nodecouple(loop).element = omega(loop);
        lnk(loop) = nodecouple(loop).numlink;
    end
    
    avgdegree = mean(lnk);
    displine('avgdegree =',avgdegree)
    
    
elseif example == 8     % small-world graph
    N = 64;
    m = 3;
    p = 0.25;
    width = 0.2;
    facoef = 0.4;
    
    omegatemp = width*(rand(1,N)-1);
    meanomega = mean(omegatemp);
    omega = omegatemp - meanomega;
    sto = std(omega);
    
    node = makeSW(N,m,p);
    [synch,l2,lmax] = eigenlap(node);
    displine('synch = ',synch)
    [cluscoef,eicoef,clus,ei] = clustercoef(node);
    displine('cluscoef = ',cluscoef)
    
    nodecouple = node;
    
    for loop = 1:N
        nodecouple(loop).element = omega(loop);
        lnk(loop) = nodecouple(loop).numlink;
    end
    
    avgdegree = mean(lnk);
    displine('avgdegree =',avgdegree)
    
elseif example == 9     % hypercube
    B = 6;
    width = 0.2;
    N = 2^B;
    facoef = 0.3;
    
    omegatemp = width*(rand(1,N)-1);
    meanomega = mean(omegatemp);
    omega = omegatemp - meanomega;
    sto = std(omega);
    
    node = makehypercube(B);
    [synch,l2,lmax] = eigenlap(node);
    displine('synch = ',synch)
    [cluscoef,eicoef,clus,ei] = clustercoef(node);
    displine('cluscoef = ',cluscoef)
    
    nodecouple = node;
    
    for loop = 1:N
        nodecouple(loop).element = omega(loop);
        lnk(loop) = nodecouple(loop).numlink;
    end
    
    avgdegree = mean(lnk);
    displine('avgdegree =',avgdegree)
    
    
    
elseif example == 10     % inverse scaling
    N = 20;        %100 256
    
    tmp = 1:N;
    vert = tmp/N;
    delh = 1/N;
    
    R0 = 1;     % 4 = neutron star radius   1 = Schwarzschild radius
    
    gfactor = sqrt(1-1./(R0+vert));
    
    h = zeros(1,N);
    h(1) = 1/N;
    for nloop = 2:N
        h(nloop) = h(nloop-1) + delh + delh^2/(R0+h(nloop-1))^2;
    end
    
    spacetime = 2;      % 1 = goo   2 = both
    if spacetime == 1
        omegatemp = vert./(R0 + vert).^2;
    else
        omegatemp = h./(R0 + h).^2;
    end
    
    omegatemp = vert - mean(vert);  % evenly spaced frequencies
        
        
    width = 1.3*(max(omegatemp) - min(omegatemp));
    meanomega = mean(omegatemp);
    omega = omegatemp - meanomega;
    sto = std(omega);
    
    node = makeglobal(N); facoef = 0.225;
    
    [synch,l2,lmax] = eigenlap(node);
    displine('synch = ',synch)
    [cluscoef,eicoef,clus,ei] = clustercoef(node);
    displine('cluscoef = ',cluscoef)
    
    nodecouple = node;
    
    for loop = 1:N
        nodecouple(loop).element = omega(loop);
        lnk(loop) = nodecouple(loop).numlink;
    end
    
    avgdegree = mean(lnk);
  
    
elseif example == 11     % link one node to a cluster
    N = 20;        %100 256
    width = 0.2;
    facoef = 0.4;
    
    omegatemp = width*(rand(1,N)-1);
    meanomega = mean(omegatemp);
    omega = omegatemp - meanomega;
    omega(N+1) = width/2;
    sto = std(omega);
    
    node = makeglobal(N);
    node = addnode(N+1,node);
    node = addlink(N,N+1,node);
    N = N + 1;
    
    [synch,l2,lmax] = eigenlap(node);
    displine('synch = ',synch)
    [cluscoef,eicoef,clus,ei] = clustercoef(node);
    displine('cluscoef = ',cluscoef)
    
    nodecouple = node;
    
    for loop = 1:N
        nodecouple(loop).element = omega(loop);
        lnk(loop) = nodecouple(loop).numlink;
    end
    
    avgdegree = mean(lnk);
    displine('avgdegree =',avgdegree)
    
    
end         % end if example

mnomega = 1;

if writeavi == 1
    figure(2)
    clf
    colormap(h)
    caxis([-0.1 0.1])
    colorbar
end

xxx = zeros(1,Nfac+1);
yyy(1,:) = omega;

for facloop = 1:Nfac
    facloop
    tic
    
    fac = facoef*(16*facloop/(Nfac))*(1/avgdegree)*sto/mnomega;

    [dum,nodesz] = size(nodecouple);
    for nodeloop = 1:nodesz
        [dum,linksz] = size(nodecouple(nodeloop).link);
        for linkloop = 1:linksz
            nodecouple(nodeloop).coupling(linkloop) = fac;
        end
    end
    
    if facloop == 1     % Print the g-matrix
        for omloop = 1:N
            linksz = node(omloop).numlink;
            for cloop = 1:linksz
                ix = nodecouple(omloop).link(cloop);
                gtemp(omloop,ix) = 1;
            end
        end
        
        figure(100)
        imagesc(gtemp)
        colormap(jet)
    end
    
    facval(facloop) = fac;
    facdeg(facloop) = fac*avgdegree;
    
    if inexcoupling == 1        % internal coupling
        
        [omegout,yout] = coupleN(nodecouple,0);                           % Here is the subfunction call for the flow
        
        mean_field(facloop) = mean(abs((1/N)*sum(exp(i*yout),2)));
        mean_field2(facloop) = mean(abs((1/N)*sum(exp(i*yout),2)).^2);
        %keyboard
        
    elseif inexcoupling == 2        % external coupling
        g = 1;
        fac = 0.05*1.16^(30*facloop/Nfac);
        gext = fac*(1/N)*sto/mnomega;
        
        omegout = coupleN0(omega,zeros(N,N),gext);       % Here is the subfunction call for the flow
        
    end     % end if coupling
    
    if example == 30         % square lattice
        ind = 0;
        for yloop = 1:Row
            for xloop = 1:Col
                ind = ind+1;
                A(yloop,xloop) = omegout(ind);
            end
        end
        
        figure(2)
        imagesc(A)
        colormap(h)
        caxis([-width/2 width/2])
        if writeavi
            frame = getframe(gcf);
            aviobj = addframe(aviobj,frame);
        end
    end
    
    stdev(facloop) = std(omegout);
    
    [y,x] = histfix(omegout,11,-0.1,0.1);
    %    figure(3)
    %    plot(x,y)
    mx(facloop) = max(y);
    
    xx(N*(facloop-1)+1:facloop*N) = ones(1,N)*facval(facloop);
    yy(N*(facloop-1)+1:facloop*N) = omegout;
    
    for omloop = 1:N
        yyy(facloop+1,omloop) = omegout(omloop);
    end
    %xxx(facloop+1) = facval(facloop)/(0.293*width);
    xxx(facloop+1) = avgdegree*facval(facloop);
    
    tictoc(facloop) = toc;
    
    S = whos;
    [Ssz,dum] = size(S);
    stemp = 0;
    for sloop = 1:Ssz
        stemp = stemp + S(sloop).bytes;
    end
    bytesize(facloop) = stemp;
    
    if mod(facloop,10) == 0
        figure(1)
        hold on
        for omloop = 1:N
            plot(1:facloop+1,yyy(:,omloop),'LineWidth',1.5)
        end
        hold off
        pause(0.01)
    end

    
end     % end facloop

duration = sum(tictoc)

figure(4)
plot(bytesize)
title('Byte Size')

figure(5)
plot(tictoc)
title('Durations')

figure(6)
plot(xx,yy,'.')


% Entrainment graph
fig = figure(7);
axis([0 max(avgdegree*facval) -1.2*width/2 1.2*width/2])
%axes('LineWidth',1.1,'FontSize',14)

hold on
for omloop = 1:N
    plot(xxx,yyy(:,omloop),'-','Color',ch(round(34-omloop*32/N),:),'LineWidth',1.5)
end
hold off
fig.Color = [1 1 1];

% Running average to smooth
fig = figure(8);
axis([0 max(avgdegree*facval) -1.2*width/2 1.2*width/2])
title('Entrainment')

[syy,~] = size(yyy);
window = 3;
for tloop = 1:syy-window
    yra(tloop,:) = mean(yyy(tloop:tloop+window,:),1);
    %yra(tloop,:) = 0.25*(yyy(tloop,:)+yyy(tloop+1,:)+yyy(tloop+2,:)+yyy(tloop+3,:));
    %yra(tloop,:) = 0.5*(yyy(tloop,:)+yyy(tloop+1,:));
end
xra = xxx(1:syy-window);

hold on
for omloop = 1:N
    %plot(xra,yra(:,omloop),'-','Color',ch(round(64-omloop*63/N),:),'LineWidth',1.5)
    plot(xra,yra(:,omloop),'-','Color',ch(round(256-omloop*240/N),:),'LineWidth',1.5)
end
hold off
fig.Color = [1 1 1];



figure(10)
plot(xxx(1:Nfac),mean_field2);
title('Mean Field')
axis([0 max(facval/width) 0 1])

figure(11)
xxi = 1./(xxx(2:Nfac+1)*avgdegree + 1e-3);
plot(xxi,mean_field2)
title('Order Parameter')
xlabel('Dw/g<k>')


xp = 1:Nfac;

mins = min(stdev);
maxs = max(stdev);
%Responst = (1 - (stdev-mins)/(maxs-mins)).^2;
Responst = (1 - stdev/maxs);

minm = min(mx);
maxm = max(mx);
%Responmx = (mx-minm)/(maxm-minm);
Responmx = (mx-minm)/(1-minm);
figure(9)
%plot(1./facval,1-Responst,'r',1./facval,1-Responmx,'b')
plot(1./facval,1-Responst,'b')
title('Respon')
legend('std','max')

Printfile3('cNdout',facval,Responst,Responmx)

figure(8); pause(0.5)
print -dtiff cNdriver

if writeavi
    aviobj = close(aviobj);
end


aa = clock;
ID = round(100*aa(6));
save(strcat('meanf',num2str(ID)),'avgdegree','mean_field', 'xxx','yyy','xra','yra')



