
function rksimple

beta = 2;
mu = 0.25;
nu = 0;


del1 = 0.9;
del2 = 0.9;
y0 = [del1 del2];
tspan = [0 100];

[t,y] = ode45(@f5,tspan,y0);

figure(1)
plot(t,y(:,1),t,y(:,2))

figure(2)
plot(y(:,1),y(:,2))

    function yd = f5(t,y)

%         yp(1) = y(2);
%         yp(2) = -y(1) +( y(2)*(1-y(1).^2));
        
%         w = 0.5;
%         yp(1) = w*y(2) + w*y(1).*(1 - y(1).^2 - y(2).^2);
%         yp(2) = -w*y(1) + w*y(2).*(1 - y(1).^2 - y(2).^2);


%         yp(1) = y(2);
%         yp(2) = -y(1).*(1-y(1)) - y(1).^4;
        
        %mu = 1; beta = 1; w02 = 1;
        %yp(1) = y(2);
        %yp(2) = mu*y(2)*(1-beta*y(1)^2)-w02*y(1);
        
%         yp(1) = -mu*y(1) + beta*y(1)*(1 - y(1) - y(2));
%         yp(2) = mu*y(1) - nu*y(2);

        kbeta = 1;
        yp = - mu*y(1) + kbeta*y(1).*(1-y(1));

        
        %yd = [yp(1);yp(2)];
        yd = yp(1);

    end     % end f5

end

