% double3stoch.m
% double well with stochastic force and drive function (Duffing)
% called by stochendriver.m


 function [X,Y,T] = double3stoch

gamma = 0.15;                      % a = 1  viscosity
drv = 0.3;                    % drive strength
mft = 0.1;                  % mft = 0.1  mean free time
%D = 0.015;                   % D = 0.05   0.005       0  0.0005  0.001  0.005  0.02

msv = 0.015;
arg = 2*gamma*msv*mft;

%y0 = [0.0 1.0];
%y0 = randn(1,2);
%y0 = [1 1 1];
ytmp = [0 0 0];
y0(1:2) = ytmp(1:2) + 0.03*randn;
y0(3) = ytmp(3);


%A = zeros(21,21);

tmax = 1000;   % 100
endtime = 0;
t1 = 0;
X = y0(1); Y = y0(2); T = 0;
while endtime < tmax
    
    t2 = t1 + mft*randexp(1,1);
    %t2 = t1 + mft;
    
    
    tspan = [t1 t2];
    
    
    [t,y] = ode45(@f5,tspan,y0);
    
    [sz,~] = size(t);
    
    X = appendvec(X,y(:,1)');
    Y = appendvec(Y,y(:,2)');
    T = appendvec(T,t');
    
    t1 = t2;
    endtime = t2;
    y0(1) = y(sz,1);
    y0(2) = y(sz,2) + sqrt(arg)*randn;
    %y0(2) = y(sz,2) + 0.03*randn;
    y0(3) = y(sz,3);
    
    %displine('t = ',t2)

end


figure(1)
plot(T,X,T,Y)
legend('y1','y2','LineWidth',1.5)

figure(2)
plot(X,Y)

Xmx = 1.2*max(abs(X));

E = X.^2 + Y.^2;

figure(3)
plot(T,E)
title('Energy')

histfixplot(X,120,-Xmx,Xmx);

keyboard



    function yd = f5(t,y)
        
        del = 1;
        alpha = 1;  %1
        beta = 1;   %1
        
        yp(1) = y(2);
        
        %yp(2) = del*(alpha*y(1) - beta*y(1)^3) - a*y(2);
        %yp(2) = -del*alpha*y(1) - a*y(2);
        %yd = [yp(1);yp(2)];
        
        yp(2) = del*(alpha*y(1) - beta*y(1)^3) - gamma*y(2) + drv*sin(y(3));
        yp(3) = 1;
        yd = [yp(1);yp(2);yp(3)];

        
    end     % end f5


end % end ltest

