function lorenz

a = 10.;        % 10
b = 25;         % 50
c = 8./3;       % 8/3

y0 = [20 1 1];
%y0 = [12.8 10.955 53.455];
%y0 = [-4.3426   -9.3985 21.389];

tspan = [0 20];
[t,yy] = ode45(@f5,tspan,y0);
[sz,~] = size(yy);

y0 = yy(sz,:);
tspan = [0 100];

options = odeset('OutputFcn',@odephas3);
% options = odeset('OutputFcn',@odeplot);
options = odeset('RelTol',1e-5);

[t,y] = ode45(@f5,tspan,y0,options);

figure(2)
colormap(jet)
plot(t,y(:,1),'k',t,y(:,2),'r',t,y(:,3),'b')
legend('x','y','z')

figure(19)
colormap(jet)
plot3(y(:,1),y(:,2),y(:,3),'k')
set(gcf,'Color','white')
axis([-25 25 -25 25 0 45])
grid on

figure(20)
colormap(jet)
plot3(y(:,1),y(:,2),y(:,3),'k')
set(gcf,'Color','white')
axis([-25 25 -25 25 0 45])
grid on
patch([-25 -25 25 25],[-25 -25 25 25],[0 45 45 0],'green','EdgeColor','none')
alpha 0.1
hold on
xm = -25:25;
ym = -25:25;
zm = xm'*ym/c;
surf(xm,ym,zm,'FaceColor','red','LineStyle','none'); alpha 0.1;
zn = b - ym'*(1./(xm + 0));
surf(xm,ym,zn,'FaceColor','blue','LineStyle','none'); alpha 0.1;
hold off

figure(21)
set(gcf,'Color','white')
axis([-25 25 -25 25 0 45])
grid on
patch([-25 -25 25 25],[-25 -25 25 25],[0 45 45 0],'green','EdgeColor','none')
alpha 0.1
hold on
surf(xm,ym,zm,'FaceColor','red','LineStyle','none'); alpha 0.1;

figure(22)
set(gcf,'Color','white')
axis([-25 25 -25 25 0 45])
grid on
patch([-25 -25 25 25],[-25 -25 25 25],[0 45 45 0],'green','EdgeColor','none')
alpha 0.1
hold on
surf(xm,ym,zn,'FaceColor','blue','LineStyle','none'); alpha 0.1;
hold off

figure(23)
set(gcf,'Color','white')
surf(xm,ym,zm,'FaceColor','red','LineStyle','none'); alpha 0.1;
hold on
surf(xm,ym,zn,'FaceColor','blue','LineStyle','none'); alpha 0.1;
hold off

figure(3)
plot(y(:,1),y(:,2))
xlabel('x-value')
ylabel('y-value')

figure(4)
plot(y(:,1),y(:,3))
xlabel('x-value')
ylabel('z-value')

figure(5)
plot(y(:,2),y(:,3))
xlabel('y-value')
ylabel('z-value')

u = sqrt(y(:,1).^2 + y(:,2).^2);
z = y(:,3);

figure(6)
plot(u,z)
xlabel('u-value')
ylabel('z-value')
title('Phase View')

xp = u - 18;
yp = z - 52;

theta = atan2(yp,xp);
signal = sin(theta);

figure(7)
plot(signal,'LineWidth',2)


PowS = 1;
% Power Spectrum
if PowS == 1        % Turn this off by setting PowS = 0
    [st dum] = size(t);
    tshort = t(400:st,1);
    %yshort = y(400:st,1);
    yshort = u(400:st,1);
    [st dum] = size(tshort);
    dt = (max(tshort)-min(tshort))/st;
    df = 1/st/dt;
    fmax = 1/dt;
    freq = df:df:fmax;

    yf = yshort(:,1);
    F = fft(yf);
    Pow = F.*conj(F);

    mid = round(st/4);
    figure(8)
    semilogx(freq(2:mid),Pow(2:mid))
    title('Power Spectrum')
    xlabel('Frequency (Hz)')
    

    [Pmax I] = max(Pow);
    f0 = freq(I)
    T0 = 1/f0
%     T0nat = 2*pi/sqrt(w02)
end




d = y(:,1);
e = y(:,2);
f = y(:,3);
Printfile4('lout',t',d',e',f')


    function yd = f5(t,y)

        yp(1) = a*(y(2) - y(1));
        yp(2) = y(1)*(b - y(3)) - y(2);
        yp(3) = y(1)*y(2) - c*y(3);

        yd = [yp(1);yp(2);yp(3)];

    end     % end f5


end % end ltest

