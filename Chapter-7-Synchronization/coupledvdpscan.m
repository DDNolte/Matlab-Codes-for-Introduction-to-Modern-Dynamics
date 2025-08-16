function vandpol

delnu = 1/40;
for nuloop = 1:40
    ddnu = -0.5 + (nuloop-1)*delnu;

beta1 = 1.0;     % 1.0 nonlinear term
F1 = 0.0;        % 0.0 DC drive amplitude
mu1 = 2.5;       % 2.5 gain
w021 = (2*pi*1)^2;      % 1.0 natural frequency


    dnu = 2*pi*ddnu;      % Frequency offset (0.1/1.618)
    eps =2*pi*0.25;      % Coupling (8.4)

    beta2 = 1.0;
    F2 = 0.0;
    mu2 = 2.5;
    w022 = (sqrt(w021) + dnu).^2;



    PowS = 1;

    y0 = [0 1 1 0];
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

%     %extract phase
%     ph1 = asin(y(:,1)/max(y(:,1)));
%     ph2 = asin(y(:,2)/max(y(:,2)));
%     phdiff = ph2-ph1;
%     figure(6)
%     plot(phdiff)


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
        lpPow1 = lpfilter(abs(Pow1)',0.5);

        yf3 = yshort3;
        F3 = fft(yf3);
        Pow3 = F3.*conj(F3);
        lpPow3 = lpfilter(abs(Pow3)',0.5);

        mid = round(st/4);
        figure(4)
        semilogy(freq(1:mid),abs(lpPow1(1:mid)),freq(1:mid),abs(lpPow3(1:mid)))
        title('Power Spectrum')
        xlabel('Frequency (Hz)')


        [Pmax1 I] = max(lpPow1(1:mid));
        f01 = freq(I)
        [Pmax3 I] = max(lpPow3(1:mid));
        f03 = freq(I)

        T01 = 1/f01;
        T03 = 1/f03;
        T0nat = 2*pi/sqrt(w021);
    end


    freq1out(nuloop) = f01;
    freq2out(nuloop) = f03;
    nuout(nuloop) = ddnu;
    
    pause(0.25)

end

figure(7)
plot(nuout,freq1out,'o','MarkerFaceColor','b')
hold on
plot(nuout,freq2out,'o','MarkerFaceColor','r')
hold off

Printfile3('cvdp',nuout,freq1out,freq2out)


    function yd = f5(t,y)

        yp(1) = y(2) - eps*(y(1)-y(3));
        yp(2) = F1 + 2*mu1*y(2)*(1-beta1*y(1)^2)-w021*y(1);
        yp(3) = y(4) + eps*(y(1)-y(3));
        yp(4) = F2 + 2*mu2*y(4)*(1-beta2*y(3)^2)-w022*y(3);
        yd = [yp(1);yp(2);yp(3);yp(4)];

    end     % end f5


end % end vandpol

