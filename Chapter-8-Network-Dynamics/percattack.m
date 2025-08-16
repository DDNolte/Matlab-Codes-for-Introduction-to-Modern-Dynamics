
clear
format compact

net_type = 1;

N = 1000;

if net_type == 1
    p = 0.006;
    node = makeER(N,p);
elseif net_type == 2
    m = 3;
    p = 0.1;
    node = makeSW(N,m,p);
else
    m = 3;
    node = makeSF(N,m);
end
[N,e,avgdegree,maxdegree,mindegree,numclus,meanclus,Lmax,L2,LmaxL2,meandistance,diam] = clusterstats(node)


Nstep = 5;
Nit = ceil(e/Nstep) + 1;

AccumP = zeros(1,Nit);
Accumk = zeros(1,Nit);
Accumk2 = zeros(1,Nit);

Nens = 20;
for eloop = 1:Nens
    eloop
    
    if net_type == 1
        node = makeER(N,p);
    elseif net_type == 2
        node = makeSW(N,m,p);
    else
        node = makeSF(N,m);
    end
    %     [N,e,avgdegree,maxdegree,mindegree,numclus,meanclus,Lmax,L2,LmaxL2,meandistance,diam] = clusterstats(node);
    
    for loop = 1:Nit
        
        node = netlinkattack(node,Nstep);
        
        [~,degree] = adjacency(node);
        
        meank(loop) = mean(degree);
        meank2(loop) = mean(degree.^2);
        
        [~,~,~,~,~,P] = netperc(node);
        [Y,I] = max(P);
        Perc(loop) = Y/N;
        
    end
    
    AccumP = AccumP + Perc/Nens;
    Accumk = Accumk + meank/Nens;
    Accumk2 = Accumk2 + meank2/Nens;
    
    
end


xx = 1:Nit;
figure(1)
plot(xx,Accumk,xx,Accumk2,xx,(Accumk2-2*Accumk))
legend('Mean k','Mean k^2','Molloy-Reed')
line([0 Nit],[0 0],'Color','k')

figure(2)
plot(xx,AccumP)
title('Percolation')

figure(3)
plot(Accumk,AccumP)
xlabel('Mean k')
ylabel('Perc')
title('Percolation')

Printfile4('percattack.txt',xx,AccumP,Accumk,Accumk2);



