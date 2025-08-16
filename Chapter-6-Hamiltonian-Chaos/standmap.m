% standmap.m

clear
close all

Jphi = 0;

eps = 0.97;      % 0.3  0.5  0.7  0.8  0.9   0.97  1.0

h = newcolormap('fluoro');


figure(1)
if Jphi == 0
    axis([-pi pi 0 1])
else
    axis([-pi pi -pi 2*pi])
end
hold on
for icloop = 1:200      % 200 initial conditions
    rn = ceil(63*rand);
    
    rold = 2.0*pi*(0.5-rand);
    thetold = 2.0*pi*rand;

%     rold = 0 + 2*pi*(icloop-1)/199;
%     %thetold = 2*pi*(icloop-1)/199;
%     thetold = -pi;
      
    
    for nloop = 1:200       % 200  iterates for each orbit
        r = rold + eps*sin(thetold);
        theta = mod(thetold + r,2*pi);
        
        if Jphi == 0
            
            thetaplot = mod(theta-pi,2*pi) - pi;
            if r > pi
                rtemp = r-2*pi;
            elseif r < -pi
                rtemp = 2*pi + r;
            else
                rtemp = r;
            end
            rplot = mod(0.5 + (rtemp + pi)/2/pi,1);
        else
            rplot = r;
            thetaplot = mod(theta-pi,2*pi) - pi;
        end
        
        %x = r*cos(theta);
        %y = r*sin(theta);
        
        plot(thetaplot,rplot,'o','MarkerSize',6,'LineWidth',1,'Color',h(rn,:))
        %plot(thetaplot,rplot,'o','MarkerSize',2,'LineWidth',0.5,'Color','k')
        
        
        rold = r;
        thetold = theta;
        
        
        
        
    end
    
    pause(0.1)
    
end %icloop

hold off

