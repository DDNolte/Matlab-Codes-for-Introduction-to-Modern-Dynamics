function PenPerturb

F = .02;                    % driving strength (0.02) (0.7) 0.5  0.56  0.58 (0.1 0.2 0.3 0.35 0.375 0.4 0.45 0.7)
w = 1;                    % drive frequency (0.75) (0.7)
c = 0.00;                   % damping (0.1)   0.5 0.45 0.4 0.39 0.35
%k = 3.7;                      % (2)

v = 1;
k = w/v;

% (0.7,0.7,0.27) roughly divides regular from chaotic long-term behavior(??)
% The sequence (0.7,0.7,0.5), (0.7,0.7,0.45), (0.7,0.7,0.4), (0.7,0.7,0.39), (0.7,0.7,0.35) is interesting

y0 = [0 2 0];           % [1 1.705 w] for 0.01, sqrt(0.5) 0 (1.9848)
tspan = [1 2500];           % 8000 for a good return map, 1000 for demo purposes

options = odeset('RelTol',1e-8);
% options = odeset('OutputFcn',@odeplot);

[t,y] = ode45(@f5,tspan,y0,options);

siz = size(t)

theta = mod(y(:,1)-pi,2*pi)-pi;
thetadot = y(:,2);
wt = cos(w*t-k*y(:,1));

%keyboard

figure(2)
plot(t(400:siz),y(400:siz,2),'k')
xlabel('Time')
legend('speed')

figure(3)
plot(theta(400:siz),y(400:siz,2),'ok','MarkerSize',2,'MarkerFaceColor','k')
xlabel('theta')
ylabel('speed')
axis square



% Power Spectrum
Pow = 0;
if Pow == 1
    [st dum] = size(t);
    tshort = t(50:st,1);
    yshort = y(50:st,1);
    [st dum] = size(tshort);
    dt = (max(tshort)-min(tshort))/st;
    df = 1/st/dt;
    fmax = 1/dt;
    freq = df:df:fmax;

    yf = yshort(:,1);
    F = fft(yf);
    Pow = F.*conj(F);

    mid = round(st/4);
    figure(4)
    loglog(freq(1:mid),Pow(1:mid))
    title('Power Spectrum')
    xlabel('Frequency (Hz)')
    

    [Pmax I] = max(Pow(2:mid));
    f0 = freq(I)
    T0 = 1/f0
end


%First Return Map
Fst = 1;
if Fst == 1
    %T = 2*pi/w;
    T = 2*pi;
    testwt = mod(t,T)-0.5*T;
    %testwt = wt;
    %testwt = theta;
    cnt = 0;
    last = testwt(1);
    for loop = 2:siz
        if (last < 0)&(testwt(loop) > 0)
            cnt = cnt+1;
            del = (-testwt(loop-1))/(testwt(loop)-testwt(loop-1));
            th(cnt) = (theta(loop) - theta(loop-1))*del + theta(loop-1);
            thd(cnt) = (thetadot(loop) - thetadot(loop-1))*del + thetadot(loop-1);
            last = testwt(loop);
%         elseif (last > 0)&(testwt(loop) < 0)
%             cnt = cnt+1;
%             th(cnt) = theta(loop);
%             thd(cnt) = (thetadot(loop) - thetadot(loop-1))*(-testwt(loop-1))/(testwt(loop)-testwt(loop-1)) + thetadot(loop-1);
%             last = testwt(loop);
        else
            last = testwt(loop);
        end
    end
    
    xx(1:cnt) = th;
    xx(cnt+1:2*cnt) = th+2*pi;
    yy(1:cnt) = thd;
    yy(cnt+1:2*cnt) = thd;

    figure(5)
    plot(xx,yy,'ok','MarkerSize',2,'MarkerFaceColor','k')
    %axis([0 2*pi -2.5 2.5])
    hold on
    
end

set(gcf,'color','white')
hold off
%keyboard


% Model function
    function dy = f5(t,y)

        dy = zeros(3,1);
        dy(1) = y(2);
        dy(2) = F*sin(-w*t + k*y(1)) - 1*sin(y(1)) - c*y(2);
        dy(3) = w;
        
%         dy(2) = F*sin(y(3)) - sin(y(1)) - c*y(2);
%         dy(3) = w;


    end     % end f5


end % end ltest

