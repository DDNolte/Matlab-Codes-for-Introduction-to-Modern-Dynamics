   function NagumoStream

% I = 12, EL = -78, Vn = -45, tau = 1               pg. 117  supercritical Hopf bifurcation
% I = 4.53, EL = -80, Vn = -25, tau = 1             pg. 113  Homoclinic
% I = 3, EL = -80, Vn = -25, tau = 0.152            pg. 110  Bistability y0=[-20,0.4],[-70,0.1]
% I=43-50,gL=1,gNa=gK=4,Vm=-30,km=7,EL=-78,Vn=-45,tau=1   pg. 176  subcritical Hopf

I = -1 ;     % -1 4  
gL = 8;     % 8
EL = -80;   % -80   -78
gNa = 20;    % 20
ENa = 60;   % 60
gK = 10;     % 10
EK = -90;   %-90
C = 1;      % 1
Vn = -25;   % -25   -45
kn = 5;     % 5
Vm = -20;   % -20
km = 15;     % 15
tau = 0.152;    % 1  0.152

sNorm = 0;

[X,Y] = meshgrid(-80:1:20, 0:0.01:1);

[x,y] = f5(X,Y);

clf
figure(1)
for xloop = 1:11
    xs = -80 + 10*(xloop-1);
    for yloop = 1:11
        ys = 0 + 0.1*(yloop-1);
        
        streamline(X,Y,x,y,xs,ys)
        
    end
end

hold on
[XQ,YQ] = meshgrid(-80:10:20,0:0.1:1);
[xq,yq] = f5(XQ,YQ);
%quiver(XQ,YQ,xq,yq,'g')
hold off

axis([-80 20 0 1])

for loop = 1:100
    xp(loop) = -80 + 100*loop/100;
    ninf = 1./(1 + exp((Vn - xp(loop))/kn));
    minf = 1./(1 + exp((Vm - xp(loop))/km));
    yp(loop) = ninf;
    yyp(loop) = (I - gL*(xp(loop) - EL) - gNa*minf*(xp(loop) - ENa))/(gK*(xp(loop) - EK));
end

hold on
plot(xp,yp,'r','LineWidth',1.2);
plot(xp,yyp,'k','LineWidth',1.2);
hold off
set(gcf, 'color', 'white')




    function [x,y] = f5(X,Y)
        
        ninf = 1./(1 + exp((Vn - X)/kn));
        minf = 1./(1 + exp((Vm - X)/km));
        
        f = I/C - gL*(X - EL)/C - gNa*minf.*(X - ENa)/C - gK*Y.*(X - EK)/C;
        g = (ninf - Y)./tau;
        s = sqrt(f.^2 + g.^2);
        
        if sNorm == 1
            x = f./s;
            y = g./s;
        else
            x = f;
            y = g;
        end
            
        
        
    end     % end f5




end % end vandpolStream

