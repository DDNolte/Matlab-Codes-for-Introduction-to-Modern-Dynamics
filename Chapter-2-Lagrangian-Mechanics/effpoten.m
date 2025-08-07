% effpoten.m

function effpoten

clear

alpha = 1;      % 1
beta = 1;       % 1

inv = 0;    % 0: xx = r   1: xx = 1/r

figure(1)
for loop = 1:10
    
    y0 = [loop 0];
    tspan = [0 8*loop];
    
    [y t] = effpotenfun(alpha,beta);
    yy = y(:,2);
    if inv == 0
        xx = y(:,1);
    else
        xx = 1./y(:,1);
    end
    plot(xx,yy,'r','LineWidth',1.0)
    %axis square
     hold on

%keyboard
    
end

for loop = 1:10
    
    radvel = -loop*0.1 - 0.0475
    
    y0 = [10 radvel];
    tspan = [0 60];
    
    [y t] = effpotenfun(alpha,beta);
    yy = y(:,2);
    if inv == 0
        xx = y(:,1);
    else
        xx = 1./y(:,1);
    end
    
    if abs(radvel) < sqrt(0.2)
        plot(xx,yy,'r','LineWidth',1.0)
    elseif (abs(radvel) - sqrt(0.2))<0.01
        plot(xx,yy,'--k','LineWidth',1.0)
    else
        plot(xx,yy,'b','LineWidth',1.0)
    end
    if inv == 0
        axis([0.25 10 -1.2 1.2])
    else
        axis([0. 2.5 -1.25 1.25])
        axis square
    end
     hold on

%keyboard
    
end

hold off
set(gcf,'Color','white')

% hold on
% [XQ,YQ] = meshgrid(0.1:0.5:10,-1:0.25:1);
% [xq,yq] = f5(XQ,YQ);
% quiver(XQ,YQ,xq,yq,400,'b','MaxHeadSize',0.5)
% hold off

print -dtiff -r600 effpoten


    function [y t] = effpotenfun(alpha,beta)
        
        options = odeset('RelTol',1e-5,'AbsTol',1e-6);
        [t,y] = ode45(@f,tspan,y0,options);
        
        function yd = f(t,y)
            
            yp(1) = y(2);
            yp(2) = (1./y(1).^2).*(alpha./y(1) - beta);
            yd = [yp(1);yp(2)];
            
        end     % end f
        
        
    end % end effpotenfun


    function [x,y] = f5(X,Y)
        x = Y;
        y = (1./X.^2).*(alpha./X - beta);
    end     % end f5

end

