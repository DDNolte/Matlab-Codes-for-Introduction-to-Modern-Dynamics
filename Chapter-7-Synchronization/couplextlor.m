% Externally driven Lorenz
%

function couplextlor


aa = 10.;        % 10
bb = 50;         % 50
cc = 8./3;       % 8/3


% Show Lorenz with no external drive
omega = 2*pi*1.0;
wdrive = 2*pi*1.0;
g = 0;

y0 = [1,1,1];
tspan = [0 50];
[t,y] = ode45(@fode,tspan,y0);
[sy,dum] = size(y);

y0 = y(sy,:);

tspan = [0 200];

[t,y] = ode45(@fode,tspan,y0);

z = y(:,3);
u = sqrt(y(:,1).^2 + y(:,2).^2);
xp = u - 18;
yp = z - 50;

theta = atan2(yp,xp);
signal = sin(theta);

figure(1)
subplot(1,2,1),plot(u,y(:,3))
axis([0 60 0 100])

PowS = 1;
% Power Spectrum
if PowS == 1        % Turn this off by setting PowS = 0
    [st dum] = size(t);
    tshort = t(400:st,1);
    yshort = signal(400:st) - mean(signal(400:st));
    [st dum] = size(tshort);
    dt = (max(tshort)-min(tshort))/st;
    df = 1/st/dt;
    fmax = 1/dt;
    freq = df:df:fmax;
    
    yf = yshort(:,1);
    F = fft(yf);
    Pow = F.*conj(F);
    
    mid = round(st/4);
    
    subplot(1,2,2),loglog(freq(2:mid),Pow(2:mid)),axis([0.01 100 1e-2 1e7])
    title('Power Spectrum','FontSize',18)
    xlabel('Frequency (Hz)','FontSize',16)
    
    
end



keyboard




% Turn on and sweep external drive
for omegloop = 1:240
    
    fac = 1.0 + 2*omegloop/240;
    
    omega = 2*pi*1.0;
    wdrive = 2*pi*fac;
    g = 2*pi*1;
    
    y0 = [1,1,1];
    tspan = [0 50];
    [t,y] = ode45(@fode,tspan,y0);
    [sy,dum] = size(y);
    
    y0 = y(sy,:);
    
    tspan = [0 200];
    
    [t,y] = ode45(@fode,tspan,y0);
    
    om(omegloop) = fac;
    
    z = y(:,3);
    u = sqrt(y(:,1).^2 + y(:,2).^2);
    xp = u - 20;
    yp = z - 50;
    
    theta = atan2(yp,xp);
    signal = sin(theta);
    
    
    %     figure(1)
    %     plot(t,signal)
    %     xlabel('Time')
    %     title('sin(u)')
    
    
    figure(2)
    subplot(1,2,1),plot(u,y(:,3))
    text(5,95,num2str(fac),'FontSize',18)
    axis([0 60 0 100])
    
    PowS = 1;
    % Power Spectrum
    if PowS == 1        % Turn this off by setting PowS = 0
        [st dum] = size(t);
        tshort = t(400:st,1);
        %yshort = u(400:st) - mean(u(400:st));
        yshort = signal(400:st) - mean(signal(400:st));
        [st dum] = size(tshort);
        dt = (max(tshort)-min(tshort))/st;
        df = 1/st/dt;
        fmax = 1/dt;
        freq = df:df:fmax;
        
        yf = yshort(:,1);
        F = fft(yf);
        Pow = F.*conj(F);
        
        mid = round(st/4);
        
        %semilogy(freq(1:mid),Pow(1:mid))
        subplot(1,2,2),loglog(freq(2:mid),Pow(2:mid)),axis([0.01 100 1e-2 1e7])
        line([fac fac],[1e1 1e7],'Color','r')
        title('Power Spectrum','FontSize',18)
        xlabel('Frequency (Hz)','FontSize',16)
        
        minP(omegloop) = min(log(abs(Pow(2:mid)) + 1e-6))/10;
        
        %keyboard
        
        Fmean = sum(freq(1:mid).*Pow(1:mid)')/sum(Pow(1:mid));
        F2 = sum(freq(1:mid).^2.*Pow(1:mid)')/sum(Pow(1:mid));
        
        [Pmax I] = max(Pow);
        
        [Psortmp,Isort] = sort(Pow(2:mid),'descend');
        Psort(omegloop,1:20) = freq(Isort(1:20));
        
        f0(omegloop) = freq(I);
        f1(omegloop) = Fmean;
        f2(omegloop) = sqrt(F2 - Fmean.^2);
        %T0 = 1/f0
        %     T0nat = 2*pi/sqrt(w02)
    end
    
    
    
    pause(0.01)
    %keyboard
    clear t y
    
end

figure(4)
plot(om,Psort,'o')
hold on
plot(om,0.92*f1,'LineWidth',2,'Color','k')
hold off
%axis([1 3 0 4])
set(gcf,'Color','White')
h = gca;
set(h,'FontSize',14)
xlabel('Drive Frequency (Hz)','FontSize',16)
ylabel('Response Frequency (Hz)','FontSize',16)
title('External Drive on Lorenz','FontSize',18)
print -dtiff -r600 lorensynch

figure(5)
plot(om,(om - 0.92*f1 + 1.95))
axis([1 3 1 3])
line([1 3],[1 3],'LineStyle','--','Color','k')
Printfile2('lorensynch.txt',om,f1)

%keyboard


    function yd = fode(t,y)
        
        %         yp(1) = omega + g*sin(y(1) - wdrive*t);
        %         yd = [yp(1)];
        
        yp(1) = aa*(y(2) - y(1));
        yp(2) = y(1)*(bb - y(3)) - y(2);
        yp(3) = y(1)*y(2) - cc*y(3) + g*wdrive*sin(wdrive*t);
        
        yd = [yp(1);yp(2);yp(3)];
        
    end     % end f2

    function [m,b] = linfit(x,y)
        
        meanx = mean(x);
        meany = mean(y);
        meanxy = mean(x.*y);
        meanx2 = mean(x.^2);
        
        m = (meanxy - meanx*meany)/(meanx2 - meanx^2);
        b = meany - m*meanx;
        
        f = m*x + b;
    end

end % end vandpol

