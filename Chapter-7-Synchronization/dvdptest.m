% dvdptest.m

clear
format compact

y1 = 1;y2 = 1;y3 = 0;
for floop = 1:50

    fre = 0.4 + 0.025*(floop-1);

    beta = 1;   %1
    mu = 2.5;   %2.5
    f20 = 1;    %1
    b = 9;     %10

    y0 = [y1 y2 y3];


    [y t] = drivenvanderpol(beta,mu,f20,fre,b,y0);


    [st dum] = size(y);

    y1 = y(st,1);
    y2 = y(st,2);
    y3 = y(st,3);

    figure(1)
    plot(t,y(:,1))
    pause(0.2)


    tshort = t(400:st,1);
    yshort = y(400:st,1);
    [st dum] = size(tshort);
    dt = (max(tshort)-min(tshort))/st;
    df = 1/st/dt;
    fmax = 1/dt;
    freq = df:df:fmax;

    yf = yshort(:,1);
    F = fft(yf);
    Pow = F.*conj(F);

    mid = round(st/4);
    figure(2)
    loglog(freq(1:mid),Pow(1:mid))
    title('Power Spectrum')
    xlabel('Frequency (Hz)')

    flo = freq(231);
    fhi = freq(810);

    [Pmax I] = max(Pow(231:810));
    f0 = freq(I+230)
    T0 = 1/f0;

    fdep(floop) = f0;
    fvar(floop) = fre;


end

figure(3)
plot(fvar,fdep,'o','MarkerFaceColor','b')

