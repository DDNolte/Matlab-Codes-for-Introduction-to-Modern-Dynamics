% function y = coupledrossler(node)
% identical linearly-coupled Rossler osccilators

function [y,t] = coupledrossler(node)

 [N,e,avgdegree,maxdegree,mindegree,numclus,meanclus,Lmax,L2,LmaxL2] = clusterstats(node);
displine('numclus =',numclus)
displine('No. of edges = ',e)

a = 0.23;        % 0.15 is phase coherent   0.25 is phase incoherent
b = 0.4;         % 0.4
c = 8;           % 8
g = 0.1;         % (a=0.15 b=0.4 c=0.8 gc=0.2 for SW(50,4,0.1))

displine('N = ',N);
displine('Lmax/L2 = ',LmaxL2)

y0 =10*rand(3*N,1);

[d mxd] = node2distance(node);    % find pair of nodes max dist apart
[val ym xm] = max2(d);
displine('Diameter =',mxd);
y0(3*(ym-1)+1) = +10;
y0(3*(ym-1)+2) = +10;
y0(3*(ym-1)+3) = +10;
y0(3*(xm-1)+1) = -10;
y0(3*(xm-1)+2) = -10;
y0(3*(xm-1)+3) = -10;

tspan = [1 50];
%options = odeset('OutputFcn',@odephas3);
%[t,y] = ode45(@f5,tspan,y0,options);
[t,y] = ode45(@f5,tspan,y0);
[sy,sx] = size(y);
y0 = y(sy,:);
clear y

tspan = [1 200];
%options = odeset('OutputFcn',@odephas3);
%[t,y] = ode45(@f5,tspan,y0,options);
[t,y] = ode45(@f5,tspan,y0);
[sy,sx] = size(y);

% figure(2)
% plot(t,y(:,3),t,y(:,3*round(N/3)),t,y(:,3*round(2*N/3),t,y(:,3*N)))


figure(2)
plot(t,y(:,3*(ym-1)+1),t,y(:,3*(xm-1)+1))
title('Distant pair')

figure(3)
plot(y(:,3*(ym-1)+1),y(:,3*(ym-1)+2),'k','LineWidth',1.25)    % The first node of the pair
set(gcf,'color','white')
title('x1 and x2 from first node of pair')

% I = zeros(150,150);
% IP = zeros(150,150);
% for tloop = 1:sy
%     
%     xind = 80 + round(4.5*y(tloop,3*(ym-1)+1));
%     yind = 80 + round(4.5*y(tloop,3*(ym-1)+2));
%     
%     I(yind,xind) = 1;
%     
%     xind = 80 + round(4.5*y(tloop,3*(ym-1)+1));
%     yind = 80 + round(4.5*y(tloop,3*(xm-1)+2));
%     
%     IP(yind,xind) = 1;
%     
%     
%     
% end
% 
% figure(10)
% imagesc(IP)
% colormap(gray)

cc = corcoef2(y(:,3*(ym-1)+2),y(:,3*(xm-1)+2));

displine('Correlation = ',cc)


figure(4)
plot(y(:,3*(ym-1)+1),y(:,3*(xm-1)+2),'k','LineWidth',1.25)    % The first of the pair against the second
set(gcf,'color','white')
title('x1 and x2 from distant pair')

% figure(3)
% %plot(y(:,1),y(:,3*N/2-1),'k','LineWidth',1.25)
% plot(y(:,3*(13-1)+1),y(:,3*(33-1)+2),'k','LineWidth',1.25)  % Note: find 2 nodes that are 1 net diameter distant
% set(gcf,'color','white')


%keyboard



    function yd = f5(t,y)

        for nloop = 1:N
            ind1 = 3*nloop-2;
            ind2 = 3*nloop-1;
            ind3 = 3*nloop;

            yp(ind1) = -(y(ind2) + y(ind3));
            yp(ind2) = y(ind1) + a* y(ind2);
            yp(ind3) = b + y(ind3)*(y(ind1) - c);

            linksz = node(nloop).numlink;
            temp = 0;
            tmp1 = yp(ind1);
            for linkloop = 1:linksz
                cindex = node(nloop).link(linkloop);
                temp = temp + g*(y(3*cindex-2) - y(ind1));
            end % linkloop
            yp(ind1) = tmp1 + temp;


        end % nloop
        
        for nloop = 1:N
            ind1 = 3*nloop-2;
            ind2 = 3*nloop-1;
            ind3 = 3*nloop;
            yd(ind1,1) = yp(ind1);
            yd(ind2,1) = yp(ind2);
            yd(ind3,1) = yp(ind3);
         end

    end     % end f5


end % end ltest

