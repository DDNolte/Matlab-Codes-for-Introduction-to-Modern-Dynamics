% stochendriver.m
% for ensembles
% calls double2stoch.m

clear
numbins = 100;
A = zeros(numbins,numbins);

Nens = 20;
for enloop = 1:Nens
    displine('enloop = ',enloop)
    B = zeros(numbins,numbins);
    
    [X,Y,T] = double2stoch;
    %[X,Y,T] = double3stoch;   % Driven stochastic double well (Duffing with noise)
    
    if enloop == 1
        Xmx = 1.3*max(abs(X));
        Ymx = 1.3*max(abs(Y));
    end
    
    [~,sz] = size(T);
    for tloop = 1:sz
        indx = round(1 + numbins*(X(tloop)+Xmx)/(2*Xmx));
        indy = round(1 + numbins*(Y(tloop)+Ymx)/(2*Ymx));
        if indx>0&&indx<=numbins
            if indy>0&&indy<=numbins
                B(indy,indx) = B(indy,indx) + 1;
            end
        end
    end
    
    figure(4)
    imagesc(B)
    %pcolor(A)
    %shading interp
    h = newcolormap('graycolor');
    colormap(h)
    colorbar
    
    A = A + B/Nens;
    
    
end


    figure(5)
    imagesc(A)
%     pcolor(A)
%     shading interp
    h = newcolormap('graycolor');
    colormap(h)
    colorbar
   
    
figure(6)
plot(sum(A,1))
title('X-distribution')

sig = 0.5;
gamma = 0.5;
xxtmp = 0:0.01:100;
fxd = 50/Xmx;
xx = (xxtmp-51)/fxd;
Vx = -0.5*xx.^2 + 0.25*xx.^4;
fitfun = 3.7e3*exp(-2*gamma*Vx/sig^2);
hold on
plot(xxtmp,fitfun)
hold off





