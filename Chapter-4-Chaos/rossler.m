% function rossler

function rossler

a = 0.15;        % 0.15 (defined phase)     0.3 (chaotic phase)
b = 0.4;         % 0.4
c = 8;       % 6 8.0 

y0 = [1 1 0];
tspan = [1 30];
[t,y] = ode45(@f5,tspan,y0);
[sz dum] = size(y);

y0 =[y(sz,1) y(sz,2) y(sz,3)];
tspan = [1 200];
options = odeset('OutputFcn',@odephas3);
[t,y] = ode45(@f5,tspan,y0,options);

figure(2)
plot(t,y(:,1),t,y(:,2),t,y(:,3))

figure(20)
colormap(jet)
plot3(y(:,1),y(:,2),y(:,3),'k')
set(gcf,'Color','white')
grid on


figure(3)
plot(y(:,1),y(:,3))
title('x-z')

figure(4)
plot(y(:,2),y(:,3))
title('y-z')

figure(5)
plot(y(:,1),y(:,2))
title('x-y')

PowS = 1;
% Power Spectrum
if PowS == 1        % Turn this off by setting PowS = 0
    [st dum] = size(t);
    tshort = t(400:st,1);
    yshort = y(400:st,1);
    %yshort = u(400:st,1);
    [st dum] = size(tshort);
    dt = (max(tshort)-min(tshort))/st;
    df = 1/st/dt;
    fmax = 1/dt;
    freq = df:df:fmax;

    yf = yshort(:,1);
    F = fft(yf);
    Pow = F.*conj(F);

    mid = round(st/4);
    figure(6)
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
Printfile4('lout',t',d',e',f');

%keyboard


    function yd = f5(t,y)

        yp(1) = -(y(2) + y(3));
        yp(2) = y(1) + a* y(2);
        yp(3) = b + y(3)*(y(1) - c);

        yd = [yp(1);yp(2);yp(3)];

    end     % end f5


end % end ltest

