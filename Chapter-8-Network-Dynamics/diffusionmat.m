% diffusionmat.m
% converted from diffusion driver on 11/14/14
% calculates diffusion on network using two methods
% 1) eigenvalue decomposition
% 2) iterated matrix

clear
format compact
close all

N = 100;         % 50
beta = 0.01;    % 0.05

p = .5;       % 0.3
m = 2;        % 2

Cinf = 1/N;
Cmin = 1e-3;

mxc = -log(Cmin);

node = makeSF(N,m);
%node = makeER(N,0.08);
%node = makeSW(N,m,p);
%node = makeglobal(N);

[N,e,avgdegree,maxdegree,mindegree,numclus,meanclus,Lmax,L2,LmaxL2,meandistance,diam] = clusterstats(node);

disp(' ')
displine('Number of nodes = ',N)
disp(strcat('Number of edges = ',num2str(e)))
disp(strcat('Mean degree = ',num2str(avgdegree)))
displine('Maximum degree = ',maxdegree)
disp(strcat('Number of clusters = ',num2str(numclus)))
disp(strcat('mean cluster coefficient = ',num2str(meanclus)))
disp(strcat('diameter = ',num2str(diam)))
disp(' ')
disp(strcat('Lmax = ',num2str(Lmax)))
disp(strcat('L2 = ',num2str(L2)))
disp(strcat('Lmax/L2 = ',num2str(LmaxL2)))
disp(' ')

[A,degree,Lap] = adjacency(node);

[V,D] = eig(Lap);


for loop = 1:N
    eigval(loop) = D(loop,loop);
end

figure(1)
plot(eigval)
title('Eigenvalues')

% initial values
a = Cmin*ones(N,1);
[Y,I] = max(degree);
a(I) = 1;

% eigvec decomposition

for eigloop = 1:N
    Vtemp = V(:,eigloop);
    v(eigloop) = sum(a.*Vtemp);
end

%keyboard

% time loop

timeset = round(logbasis(1,400,15));

figure(2)
for timeloop = 1:300
    
    for nodeloop = 1:N
        
        temp = 0;
        for eigloop = 1:N
            
            temp = temp + V(nodeloop,eigloop)*v(eigloop)*exp(-eigval(eigloop)*beta*(timeloop-1));
            
        end    % end eigloop
        
        
        concentration(timeloop,nodeloop) = temp;
        tmpval = (log(temp) + mxc)/mxc;
        node(nodeloop).value = tmpval;
        
    end    % endnodeloop
    
    %keyboard
    
    if where(timeset,timeloop) ~= -1
        drawnet(node,2);
        colormap(jet)
        colorbar
        pause(0.5)
    end
    
    
    
end % end timeloop

figure(3)
imagesc(log(concentration))
colorbar
title('Concentration')

figure(4)
plot(concentration(100,:))
title('Concentration')


x = 0:299;
h = colormap(jet);
figure(5)
for nodeloop = 1:N
    rn = round(rand*63 + 1);
    y =  concentration(:,nodeloop);
    semilogy(x,y,'Color',h(rn,:))
    hold on
end
hold off
title('Concentration')

xx = 1:100;
conp = concentration(1:100,I) - concentration(300,I);
tau = sum(conp'.*xx)/sum(conp)
text(300,0.5,strcat('tau = ',num2str(tau)))

compmethod = 1;

if compmethod == 1
    
    x = 0:299;
    h = colormap(jet);
    figure(6)
    for nodeloop = 1:10
        rn = round(rand*63 + 1);
        y =  concentration(:,nodeloop*5);
        %semilogy(x,y,'Color',h(rn,:),'LineWidth',1.1)
        semilogy(x,y,'k','LineWidth',1.2)
        hold on
    end
    hold off
    set(gcf,'Color','White')
    xlabel('Time')
    ylabel('Concentration')
    title('Continuous Time')
    
    
    % Now try the discrete-time approach
    
    c0 = a;
    dt = 1;
    M = eye(N,N) - beta*Lap*dt;
    
    Con(1,:) = a;
    for timeloop = 2:300
        
        c = (M^timeloop)*c0;
        
        Con(timeloop,:) = c';
    end
    
    x = 0:299;
    h = colormap(jet);
    figure(7)
    for nodeloop = 1:10
        rn = round(rand*63 + 1);
        y =  Con(:,nodeloop*5)+0.0000;
        %semilogy(x,y,'Color',h(rn,:),'LineWidth',1.1)
        semilogy(x,y,'k','LineWidth',1.2)
        hold on
    end
    hold off
    set(gcf,'Color','White')
    xlabel('Time')
    title('Discrete Time')
    
end







