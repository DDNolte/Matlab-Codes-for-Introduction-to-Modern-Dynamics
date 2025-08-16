
function FitzS

% selected stream functions for Fitz

a = -0.2;
I = 0.0;

ind = 0;
for xloop = -120:1:20
    ind = ind+1;
    xx(ind) = xloop;
    Vnullcline(ind) = (xloop + 60).*(a-xloop/75-0.8).*(xloop/75 - 0.2)/25 + I;
    Wnullcline(ind) = 0.03*(xloop/75 + 0.8)/0.02;
end

close all
figure(1)
plot(xx,Vnullcline,'Color','k','LineWidth',1.2)
hold on
plot(xx,Wnullcline,'Color','r','LineWidth',1.2)


for yloop = 1:4
    for xloop = 1:3
        
        x1 = -80 + 20*(xloop - 1) + 4*yloop;
        y1 = -0.25 + 0.25*(yloop - 1) + 0.05*xloop;
        
        y0 = [x1  y1];
        tspan = [0 500];
        
        [t,y] = ode45(@f5,tspan,y0);
        
        plot(y(:,1),y(:,2),'LineWidth',1.05)
        axis([-120 20 -0.5 1])
        set(gcf, 'color', 'white')
        
    end
end

hold off


    function yd = f5(t,y)
        
        yp(1) = (y(1) + 60).*(a-y(1)/75-0.8).*(y(1)/75 - 0.2) - 25*y(2) + I;
        yp(2) = 0.03*(y(1)/75 + 0.8) - 0.02*y(2);
        
        
        yd = [yp(1);yp(2)];
        
    end     % end f5

end

