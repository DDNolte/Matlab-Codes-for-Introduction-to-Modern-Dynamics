
function NaK

I = 10;     % 10   
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
tau = 1;    % 1  0.152

%I = 12; EL = -78; Vn = -42.5; tau = 1;                    % pg. 117  supercritical Hopf bifurcation
%I = 4.53; EL = -80; Vn = -25; tau = 1;                  % pg. 113  Homoclinic
I = 5; EL = -80; Vn = -25; tau = 0.152;                 % pg. 110  Bistability Try I = 4 vs. I = 5  y0=[-20,0.4],[-70,0.1]
%I=76;gL=1;gNa=4;gK=4;Vm=-30;km=7;EL=-78;Vn=-45;tau=1;    % pg. 176  subcritical Hopf


%y0 = [-61,0.001];
y0 = [-20  0.4];
%y0 = [10  0.81];
%y0 = [-50  0.25];



tspan = [0 100];

figure(1)
options = odeset('OutputFcn',@odephas2);
[t,y] = ode45(@f5,tspan,y0,options);

figure(2)
plot(t,y(:,1),t,y(:,2))


figure(3)
plot(y(:,1),y(:,2))
set(gcf, 'color', 'white')

for loop = 1:100
    xp(loop) = -80 + 100*loop/100;
    ninf0 = 1./(1 + exp((Vn - xp(loop))/kn));
    minf0 = 1./(1 + exp((Vm - xp(loop))/km));
    ypn(loop) = ninf0;
    ypV(loop) = (I - gL*(xp(loop) - EL) - gNa*minf0*(xp(loop) - ENa))/(gK*(xp(loop) - EK));
end

hold on
plot(xp,ypn,'r',xp,ypV,'k')
hold off

printfile = 0;

if printfile == 1
    [sz,dum] = size(t);
    ty1 = y(1:300,1)';
    ty2 = y(1:300,2)';
    tyV = y(1:sz,1);
    Printfile3('Nullclines.txt',xp,ypn,ypV);
    Printfile2('Trajectory.txt',ty1,ty2);
    Printfile2('TimeSeries.txt',t',tyV');
end
    



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    function yd = f5(t,y)
        
        ninf = 1./(1 + exp((Vn - y(1))/kn));
        minf = 1./(1 + exp((Vm - y(1))/km));
        
        yp(1) = I/C - gL*(y(1) - EL)/C - gNa*minf*(y(1) - ENa)/C - gK*y(2).*(y(1) - EK)/C;
        yp(2) = (ninf - y(2))./tau;
        
        
        
        yd = [yp(1);yp(2)];
        
    end     % end f5

end

