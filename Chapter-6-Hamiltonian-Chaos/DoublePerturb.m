% function DoublePerturb
% driven Double-well

function DoublePerturb

F = 0.002;                    % driving strength 0.002
w = 1;                    % drive frequency 1
c = 0.0;                   % damping 0.0
k = 1.;                      % k = 1
lam = 1;                  % lam = 0.1
phase = rand*2*pi;

y0 = [0 0 0];                % [0 0 0] 
tspan = [1 25000];           % 25000 for a good return map, 1000 for demo purposes

options = odeset('RelTol',1e-8);
% options = odeset('OutputFcn',@odeplot);

[t,y] = ode45(@f5,tspan,y0,options);

siz = size(t);

xpos = y(:,1);
thetadot = y(:,2);
wt = cos(w*t-k*y(:,1));

%keyboard

h2 = figure(2);
h2.Position = [66 60 1317 745];
dum = set(h2);

lo = floor(siz/2);
hi = floor(siz/2 + 0.02*siz);
subplot(2,1,1),plot(t(lo:hi),y(lo:hi,2),'k')
xlabel('Time')
title('Speed')

Energy = 0.5*thetadot.^2 + 1 - xpos.^2 + lam*xpos.^4;

subplot(2,1,2),plot(t(lo:hi),Energy(lo:hi),'k')
xlabel('Time')
title('Energy')
set(gcf,'Color','white')


figure(3)
plot(xpos(400:siz),y(400:siz,2),'ok','MarkerSize',2,'MarkerFaceColor','k')
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
    T = 2*pi/w;
    testwt = mod(t,T)-0.5*T;
    %testwt = wt;
    %testwt = theta;
    cnt = 0;
    last = testwt(400);
    for loop = 401:siz
        if (last < 0)&(testwt(loop) > 0)
            cnt = cnt+1;
            th(cnt) = xpos(loop);
            thd(cnt) = (thetadot(loop) - thetadot(loop-1))*(-testwt(loop-1))/(testwt(loop)-testwt(loop-1)) + thetadot(loop-1);
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
    yy(1:cnt) = thd;

    figure(5)
    plot(xx,yy,'ok','MarkerSize',2,'MarkerFaceColor','k')
    %axis([0 2*pi -2.5 2.5])
    
end

set(gcf,'color','white')
    
lo = floor(siz/2);
hi = floor(siz/2 + 0.1*siz);
Printfile4('DoubleDynamics.txt',t(lo:hi),xpos(lo:hi),thetadot(lo:hi),Energy(lo:hi))


% Model function
    function dy = f5(t,y)

        dy = zeros(3,1);
        dy(1) = y(2);
        dy(2) = F*sin(-w*t + k*y(1) + phase) + 2*y(1) - 4*lam*y(1).^3 - c*y(2);
        dy(3) = w;
        
%         dy(2) = F*sin(y(3)) - sin(y(1)) - c*y(2);
%         dy(3) = w;


    end     % end f5


end % end ltest

