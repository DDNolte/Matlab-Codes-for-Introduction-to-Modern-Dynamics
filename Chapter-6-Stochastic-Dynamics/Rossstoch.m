% Rossstoch.m
% Rossler with stochastic force
% Called by stochRossdriver.m



function [X,Y,Z,T] = Rossstoch

global escape_count

a = 0.15;        % 0.15 (defined phase)     0.3 (chaotic phase)
b = 0.4;         % 0.4
c = 8;       % 6 8.0

mft = .1;                  % mft = 0.1  mean free time
D = .000;                   % D = 0.05
sig = sqrt(2*D*mft);        % sig = 0.1  Dv

y0 = 5 + .1*randn(1,3);

tspan = [0 100];

Opt    = odeset('Events', @myEvent);
[t,y] = ode45(@f5,tspan,y0,Opt);

y0 = y(end,:);

tmax = 500;
endtime = 0;
t1 = 0;
X = y0(1); Y = y0(2); Z = y0(3); T = 0;
while endtime < tmax
    
    t2 = t1 + mft*randexp(1,1);
    %t2 = t1 + 5.81;
    %t2 = t1 + mft;
    
    
    tspan = [t1 t2];
    
    Opt    = odeset('Events', @myEvent);
    [t,y] = ode45(@f5,tspan,y0,Opt);
    
    [sz,dum] = size(t);
    
    X = appendvec(X,y(:,1)');
    Y = appendvec(Y,y(:,2)');
    Z = appendvec(Z,y(:,3)');
    T = appendvec(T,t');
    
    t1 = t2;
    endtime = t2;
    y0(1) = y(sz,1) + sig*randn;
    y0(2) = y(sz,2);
    y0(3) = y(sz,3);
    
    if sum(abs(y(end,:))) > 1000
        escape_count = escape_count + 1;
        endtime = tmax+1;
    end
    
end


figure(1)
plot(T,X,T,Y,T,Z,'LineWidth',1)
legend('y1','y2','y3')

figure(2)
plot(X,Y,'Color','k')

% figure(3)
% plot(T,X,T,Z)
% legend('y1','y2')
%
% figure(4)
% plot(X,Z)



    function yd = f5(t,y)
        
        yp(1) = -(y(2) + y(3));
        yp(2) = y(1) + a* y(2);% + 3*sin(y(4));
        yp(3) = b + y(3)*(y(1) - c);
        %yp(4) = 2*pi*0.1176;
        
        yd = [yp(1);yp(2);yp(3)];
        %yd = [yp(1);yp(2);yp(3);yp(4)];
        
    end     % end f5

% https://www.mathworks.com/help/matlab/math/ode-event-location.html
    function [value, isterminal, direction] = myEvent(T, y)
        value = sum(abs(y(1))+abs(y(2))+abs(y(3))) < 1000;
%         if value == 0
%             %keyboard
%         end
        isterminal = 1;   % Stop the integration
        direction  = [];
    end


end % end ltest

