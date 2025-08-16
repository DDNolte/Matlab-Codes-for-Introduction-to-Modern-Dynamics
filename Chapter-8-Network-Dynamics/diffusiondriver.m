% diffusiondriver.m
% 3-24-12

clear
format compact
%close all

N = 128;
p = 0.01;
m = 4;
beta = 0.001;


node = makeER(N,p);
%node = makeSW(N,m,0.3);
%node = makeSF(N,m);


% A = adjacency(node);
% A = ham2adj(N);
% node = adj2node(A);

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
 
 [V,D] = eig(Lap);
 
 for loop = 1:N
     eigval(loop) = D(loop,loop);
 end
 
 figure(1)
 plot(eigval)
 title('Eigenvalues')
 
 % initial values
 c = zeros(N,1);
 c(1) = 1;
 
 % eigvec decomposition
 
 for eigloop = 1:N
     Vtemp = V(:,eigloop);
     v(eigloop) = sum(c.*Vtemp);
 end
 
 % time loop
 Ntime = 10000;
 for timeloop = 1:Ntime       % 200
     
     for nodeloop = 1:N
         
         temp = 0;
         for eigloop = 1:N 
             
             temp = temp + V(nodeloop,eigloop)*v(eigloop)*exp(-eigval(eigloop)*beta*(timeloop-1));
                  
         end    % end eigloop
         
                       concentration(timeloop,nodeloop) = temp;

     end    % endnodeloop
     

 end % end timeloop
 
 figure(2)
 imagesc(real(log(concentration)))
 colormap(jet)
 colorbar
 caxis([-10 0])
 title('Log Concentrations vs. time')
 xlabel('Node Number')
 
 figure(3)
 plot(concentration(100,:))
 title('Ending Concentrations')
 xlabel('Node Number')
 
 
  x = 0:Ntime-1;
 h = colormap(jet);
 figure(4)
 for nodeloop = 1:N
     rn = round(rand*255 + 1);
     y =  concentration(:,nodeloop)+0.001;
     semilogy(x,y,'Color',h(rn,:))
      hold on
 end
 hold off
title('Concentrations vs. time')

kern = concentration(:,1) - concentration(:,end);
tau = sum(x'.*kern)/sum(kern)
 
 
 x = 0:Ntime-1;
 h = colormap(jet);
 figure(5)
 for nodeloop = 1:10
     rn = round(rand*255 + 1);
     y =  concentration(:,nodeloop*10)+0.001;
     semilogy(x,y,'Color',h(rn,:),'LineWidth',1.1)
     %semilogy(x,y,'k','LineWidth',1.2)
      hold on
 end
 hold off
 set(gcf,'Color','White')
 title('Selected Nodes: Continuous time')
 
 
 % Now try the discrete-time-map approach
 
 c0 = c;
 dt = 1;    % 5
 M = eye(N,N) - beta*Lap*dt;
 
 for timeloop = 1:200   %40
     
     c = (M^timeloop)*c0;
     
     Con(timeloop,:) = c';
 end
 
 x = 0:1:199;   % 0:5:199
 h = colormap(jet);
 figure(6)
 for nodeloop = 1:10
     rn = round(rand*255 + 1);
     y =  Con(:,nodeloop*10)+0.001;
     semilogy(x,y,'Color',h(rn,:),'LineWidth',1.1)
     %semilogy(x,y,'k','LineWidth',1.2)
      hold on
 end
 hold off
 set(gcf,'Color','White')
 title('Selected Nodes: Discrete time')

 
 
 
 
 
 
 
 
 