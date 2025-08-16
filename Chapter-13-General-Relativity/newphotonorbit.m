

function newphotonorbit
set(groot,'defaultAxesFontSize',14)
set(groot,'defaultTextFontSize',14)
set(groot,'defaultLegendFontSize',14)
set(groot,'defaultLineLineWidth',1.5)

b = 6;     % 5.2245
x0 = -50;

phi0 = atan(x0/b)

u0 = 1/x0; v0 = -1/b;
X0 = -sin(phi0)/u0
Y0 = -cos(phi0)/u0

y0 = [u0 v0];
tspan = [phi0 50/(b-3)];
%tspan = [phi0 20];

opts = odeset('RelTol',1e-4,'AbsTol',1e-6);
[t,y] = ode45(@f5,tspan,y0,opts);

figure(1)
plot(t,y(:,1),t,y(:,2));
legend('1','2')

figure(2)
plot(y(:,1),y(:,2))

X = -sin(t)./y(:,1);
Y = -cos(t)./y(:,1);

R = sqrt(X.^2 + Y.^2);
figure(3)
plot(R)

aa = b>Y;
w = where(aa,0);
I = min(w);
if I > 0
    XX = X(1:I-2);
    YY = Y(1:I-2);
else
    XX = X;
    YY = Y;
end

figure(4)
clf
plot(XX,YY)
%axis equal
axis([-20 20 -20 20])
% line([0 0],[min(YY) max(YY)],'Color','r')
% line([min(XX) max(XX)],[0 0],'Color','r')
rh = drawcircle(0,0,4,[0 0 0]);

keyboard

figure(5)
clf
for loop = 1:20
    fac = (20 - 5.2245)/18;
    b = 20 - fac*(loop-1);
    
    phi0 = atan(x0/b)
    u0 = 1/x0; v0 = -1/b;
    y0 = [u0 v0];
    tspan = [phi0 50/(b-3)];
    
    [t,y] = ode45(@f5,tspan,y0,opts);
    
    X = -sin(t)./y(:,1);
    Y = -cos(t)./y(:,1);
    
    aa = b>Y;
    w = where(aa,0);
    I = min(w);
    if I > 0
        XX = X(1:I-2);
        YY = Y(1:I-2);
    else
        XX = X;
        YY = Y;
    end
    
    figure(5)
    plot(XX,YY)
    axis([-20 20 -20 20])
    hold on
    
        
end
rh = drawcircle(0,0,4,[0 0 0]);
axis square
hold off


keyboard

    function yd = f5(t,y)
        
        yp(1) = y(2);
        yp(2) = -3*y(1).^2 - y(1);
        %yp(2) = -y(1);  % strainght line motion
        
        yd = [yp(1);yp(2)];
        
    end     % end f5

end
