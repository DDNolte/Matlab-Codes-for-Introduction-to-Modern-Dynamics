function vdp

beta =0.4;     % 1.0 nonlinear term
F = 0.0;        % 0.0 DC drive amplitude
mu = 100;       % 1.0 gain
%w02 = (2*pi*1.0)^2;      % 1.0 natural frequency
w02 = 1;

PowS = 1;

y0 = [0 .15];
tspan = [0 400];

figure(1)
options = odeset('OutputFcn',@odephas2);
 %options = odeset('OutputFcn',@odeplot);

[t,y] = ode45(@f5,tspan,y0,options);
xlim = ceil(max(y(:,1)));
ylim = ceil(max(y(:,2)));


figure(2)
plot(t,y(:,1),t,y(:,2))
legend('y1','y2')
xlabel('Time')

figure(3)
plot(y(:,1),y(:,2),'LineWidth',1.5)
title('Configuration Space')
xlabel('x1','FontSize',14)
ylabel('x2','FontSize',14)

xx = -4:0.001:4;
yy  = -F+w02*xx./(mu*(1-beta*xx.^2));
hold on
plot(xx,yy)
axis([-xlim xlim -ylim ylim])
line([-xlim, xlim],[0,0])
hold off

%keyboard

% Power Spectrum
if PowS == 1        % Turn this off by setting PowS = 0
    [st dum] = size(t);
    indstart = floor(st/2);
    tshort = t(indstart:st,1);
    yshort = y(indstart:st,1);
    [st dum] = size(tshort);
    dt = (max(tshort)-min(tshort))/st;
    df = 1/st/dt;
    fmax = 1/dt;
    freq = df:df:fmax;

    yf = yshort(:,1);
    FT = fft(yf);
    Pow = FT.*conj(FT);

    mid = round(st/4);
    figure(4)
    semilogy(freq(1:mid),Pow(1:mid))
    title('Power Spectrum')
    xlabel('Frequency (Hz)')
    
    %keyboard

    [Pmax I] = max(Pow);
    f0 = freq(I)
    T0 = 1/f0
    T0nat = 2*pi/sqrt(w02)
end



%keyboard


    function yd = f5(t,y)

        yp(1) = y(2);
        yp(2) = F + mu*y(2)*(1-beta*y(1)^2)-w02*y(1);   % van der Pol limit cycle
        %yp(2) = F + mu*y(2) - beta*y(2)^3-w02*y(1);   % Rayleigh limit cycle (1883 Phil. Mag, pg. 229)
        yd = [yp(1);yp(2)];

    end     % end f5


end % end vandpol

