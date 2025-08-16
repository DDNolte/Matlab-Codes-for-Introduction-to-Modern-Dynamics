function coupledvdp

beta1 = 1.0;     % 1.0 nonlinear term
F1 = 0.0;        % 0.0 DC drive amplitude
mu1 = 2.5;       % 2.5 gain
w021 = (2*pi*1)^2;      % 1.0 natural frequency

dnu = 2*pi*0.15;      % Frequency offset (0.1/1.618)
eps =2*pi*0.16;      % Position coupling (0.25)
epsv = 2*pi*0.;    % Velocity coupling

beta2 = 1.0;
F2 = 0.0;
mu2 = 2.5;
w022 = (sqrt(w021) + dnu).^2;



PowS = 1;

y0 = [1 -8 -1 8];
tspan = [0 20];
[t,y] = ode45(@f5,tspan,y0);
[sy,dum] = size(y);

y0 = [y(sy,1) y(sy,2) y(sy,3) y(sy,4)]


tspan = [0 50];

figure(1)
options = odeset('OutputFcn',@odephas2);
% options = odeset('OutputFcn',@odeplot);

[t,y] = ode45(@f5,tspan,y0,options);

figure(2)
plot(t,y(:,1),t,y(:,3))
legend('y1','y3')
xlabel('Time')

% %extract phase
% ph1 = asin(y(:,1)/max(y(:,1)));
% ph2 = asin(y(:,2)/max(y(:,2)));
% phdiff = ph2-ph1;
% figure(6)
% plot(phdiff)


figure(3)
plot(y(:,1),y(:,3),'LineWidth',1.5)
title('Configuration Space')
xlabel('x1','FontSize',14)
ylabel('x3','FontSize',14)

% Printfile2('vdp.out',y(501:800,1)',y(501:800,2)')
% Printfile3('vdpt.out',t(501:1000)',y(501:1000,1)',y(501:1000,2)')

% d = y(:,1);
% e = y(:,2);
% Printfile3('lout',t',d',e')

% Power Spectrum
if PowS == 1
    [st dum] = size(t);
    tshort = t(400:st,1);
    yshort1 = y(400:st,1);
    yshort3 = y(400:st,3);
    [st dum] = size(tshort);
    dt = (max(tshort)-min(tshort))/st;
    df = 1/st/dt;
    fmax = 1/dt;
    freq = df:df:fmax;

    yf1 = yshort1;
    F1 = fft(yf1);
    Pow1 = F1.*conj(F1);
%     lpPow1 = lpfilter(Pow1,0.5);

    yf3 = yshort3;
    F3 = fft(yf3);
    Pow3 = F3.*conj(F3);
%     lpPow3 = lpfilter(Pow3,0.5);

    mid = round(st/4);
    figure(4)
    semilogy(freq(1:mid),Pow1(1:mid),freq(1:mid),Pow3(1:mid))
    title('Power Spectrum')
    xlabel('Frequency (Hz)')
    

    [Pmax1 I] = max(Pow1);
    f01 = freq(I)
    [Pmax3 I] = max(Pow3);
    f03 = freq(I)
    
    T01 = 1/f01;
    T03 = 1/f03;
    T0nat = 2*pi/sqrt(w021);
end

Printfile3('phaselock',t',y(:,1)',y(:,3)')

    function yd = f5(t,y)

        yp(1) = y(2) - eps*(y(1)-y(3));
        yp(2) = F1 + 2*mu1*y(2)*(1-beta1*y(1)^2)-w021*y(1)  - epsv*(y(2)-y(4));
        yp(3) = y(4) + eps*(y(1)-y(3));
        yp(4) = F2 + 2*mu2*y(4)*(1-beta2*y(3)^2)-w022*y(3)  + epsv*(y(2)-y(4));
%         yp(1) = y(2) - eps*(y(1)-y(3));
%         yp(2) = F1 + 2*mu1*(y(2) - eps*(y(1)-y(3)))*(1-beta1*y(1)^2)-w021*y(1)  - epsv*(y(2)-y(4));
%         yp(3) = y(4) + eps*(y(1)-y(3));
%         yp(4) = F2 + 2*mu2*(y(4) + eps*(y(1)-y(3)))*(1-beta2*y(3)^2)-w022*y(3)  + epsv*(y(2)-y(4));
        yd = [yp(1);yp(2);yp(3);yp(4)];

    end     % end f5


end % end vandpol

