
function FitzS

% selected stream functions for simple Fitzhugh-Nagumo

a = -0.25;
I = 0.0;

ind = 0;
for xloop = -1.5:.01:1.5
    ind = ind+1;
    xx(ind) = xloop;
    Vnullcline(ind) = xloop*(1-xloop^2);
end

close all
figure(1)
plot(xx,Vnullcline,'Color','k','LineWidth',1.2)
hold on
line([-a -a],[-2 2],'Color','k')
axis([-1.5 1.5 -2 2])
options = odeset('MaxStep',.1);

for yloop = 1:6
    for xloop = 1:2
        
        x1 = -1.5 + 3*(xloop-1);
        y1 = -1 + 0.5*(yloop - 1);
        
        y0 = [x1  y1];
        tspan = [0 10];
        
        [t,y] = ode45(@f5,tspan,y0,options);
        
        plot(y(:,1),y(:,2),'LineWidth',1.05)
        
    end
end

y0 = [-a  -a*(1-a^2)+0.01];
tspan = [0 500];
[t,y] = ode45(@f5,tspan,y0,options);
plot(y(:,1),y(:,2),'LineWidth',1.05)

y0 = [-a  -a*(1-a^2)-0.01];
tspan = [0 500];
[t,y] = ode45(@f5,tspan,y0,options);
plot(y(:,1),y(:,2),'LineWidth',1.05)


axis([-1.5 1.5 -2 2])
set(gcf, 'color', 'white')

hold off

figure(2)
plot(t,y(:,1),t,y(:,2))

figure(1)
keyboard


    function yd = f5(t,y)
        
        yp(1) = y(1).*(1-y(1).^2) - y(2);
        yp(2) = a + y(1);
        
        
        yd = [yp(1);yp(2)];
        
    end     % end f5

end

