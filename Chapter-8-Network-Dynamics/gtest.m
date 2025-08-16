% Growth and Decay of networks


clear
format compact
close all

net_type = 3;                 % 1 ER    2 SW    3 SF
attack_type = 0;   % 0  None  % 1 min   2 rand  3 max
attach_type = 3;   % 0  None  % 1 min   2 rand  3 max
growth_type = 3;   % 0  None  % 1 ER    2 SW    3 SF
net_decrease = 0.0;    % attrition as fraction


Nnet = 300;   % 300  Size of initial net
Nit = 100;    % 300  Numbert of attacks
Nens = 30;   % 100

tmp = net_decrease*Nnet;
del = round(Nit/tmp);


AccumP = zeros(1,Nit);
Accumk = zeros(1,Nit);
Accumk2 =  zeros(1,Nit);
AccumN = zeros(1,Nit);
for eloop = 1:Nens
    eloop
    
    if net_type == 1
        p = 0.006;
        node = makeER(Nnet,p);
    elseif net_type == 2
        m = 3;
        p = 0.1;
        node = makeSW(Nnet,m,p);
    else
        m = 3;
        node = makeSF(Nnet,m);
    end
    
    
    
    for loop = 1:Nit
        
        node = netattack(node,1,attack_type);    % attack one node
        node = attachzerok(node,attach_type);    % reattach any zero-k nodes
        
        Z = findzerok(node);
        if Z > 0
            if numel(node) > 1
                displine('Zero degree node',Z)
            end
%             keyboard
%             node = removezerok(node);
        end
        if mod(loop,del) ~= 0
            node = netgrowth(node,1,growth_type);    % add one node
        end
        if mod(loop,50) == 0
            loop
        end
        
        N(loop) = numel(node);
        [~,degree] = adjacency(node);
        meank2(loop) = mean(degree.^2);
        meank(loop) = mean(degree);
%         [N,e,avgdegree,maxdegree,mindegree,numclus,meanclus,Lmax,L2,LmaxL2,meandistance,diam] = clusterstats(node);
%         diameter(loop) = diam;
        
        [~,~,~,~,~,P] = netperc(node);
        [Y,I] = max(P);
        %Perc(loop) = Y/N(loop);
        Perc(loop) = Y;
        
    end
    
    AccumP = AccumP + Perc/Nens;
    Accumk = Accumk + meank/Nens;
    Accumk2 = Accumk2 + meank2/Nens;
    AccumN = AccumN + N/Nens;
    
    xx = 1:Nit;
    figure(1)
    plot(xx,N)
    title('N vs iteration')
    
    figure(2)
    plot(xx,meank,xx,meank2,xx,meank2-2*meank)
    title('Mean Degree vs iteration')
    legend('Mean','Mean^2','Molloy-Reed')
    line([0 Nit],[0 0],'Color','k')
    
    figure(3)
    plot(xx,Perc)
    title('Percolation')
    %axis([0 Nit 0 1])
    
    figure(4)
    plot(xx,diamter)
    title('Network Diameter')
    
end

figure(12)
plot(xx,Accumk,xx,Accumk2,xx,Accumk2-2*Accumk)
title('Mean Degree vs iteration')
legend('Mean','Mean^2','Molloy-Reed')
line([0 Nit],[0 0],'Color','k')

figure(13)
plot(xx,AccumP)
title('Percolation')
axis([0 Nit 0 1])

Percola = AccumP.*N./(Nit+1-xx + 1e-6);
figure(14)
plot(Nit-AccumN,Percola)
title('Percolation')
axis([0 Nit 0 1])

Printfile6('nodeattack.txt',xx,AccumP,Accumk,Accumk2,Percola,Nit-AccumN);

% if numel(node) > 1
%     figure(4)
%     DrawNetC(node)
% end



