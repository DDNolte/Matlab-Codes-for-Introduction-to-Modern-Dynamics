function Pendulum3


F = 0.7;                    % driving strength (0.7) 0.5  0.56  0.58 (0.1 0.2 0.3 0.35 0.375 0.4 0.45 0.7) %1.2    %0.1 0.2 0.28  0.283 0.285  0.3
w = 0.7;                    % drive frequency (0.7)  0.667
c = .19;                   % damping (0.1)   0.5 0.45 0.4 0.39 0.35    %0.5   %0.001

% (0.7,0.7,0.27) roughly divides regular from chaotic long-term behavior(??)
% The sequence (0.7,0.7,0.3),(0.7,0.7,0.25),(0.7,0.7,0.21),(0.7,0.7,0.195),(0.7,0.7,0.19) is interesting
% The sequence (0.3,0.7,0.1),(0.5,0.7,0.1),(0.537,0.7,0.1),(0.538,0.7,0.1),(0.543,0.7,0.1),(0.544,0.7,0.1),(0.56,0.7,0.1),(0.56,0.7,0.1) is interesting

tspan = [0 6000];
y0 = [1 1. w];           % [1 1.705 w] for 0.01, sqrt(0.5) 0
[t,y] = ode45(@f5,tspan,y0);
[sy,dum] = size(y);

tspan = [1000 8000];           % 8000 for a good return map, 1000 for demo purposes
y0 = [y(sy,1) y(sy,2) y(sy,3)]

figure(1)
options = odeset('RelTol',1e-7);
%options = odeset('OutputFcn',@odephas3);
% options = odeset('OutputFcn',@odeplot);

[t,y] = ode45(@f5,tspan,y0,options);

siz = size(t)

theta = mod(y(:,1)-pi,2*pi)-pi;
thetadot = y(:,2);
wt = y(:,3);

figure(2)
plot(t(400:siz/10),y(400:siz/10,2),'k')
xlabel('Time')
legend('speed')

figure(3)
plot(theta(400:siz),y(400:siz,2),'ok','MarkerSize',2,'MarkerFaceColor','k')
axis([-pi pi -pi pi])
set(gcf,'Color','white')
%axis off
title('Phase Space Trajectories')
xlabel('Theta')
ylabel('Theta-dot')


% Power Spectrum
Powx = 1;
if Powx == 1
    [st dum] = size(t);
    tshort = t(50:st,1);
    yshort = y(50:st,2);
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
    last = testwt(1);
    for loop = 2:siz
        if (last < 0)&(testwt(loop) > 0)
            cnt = cnt+1;
            th(cnt) = (theta(loop) - theta(loop-1))*(-testwt(loop-1))/(testwt(loop)-testwt(loop-1)) + theta(loop-1);
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

    figure(5)
    plot(th,thd,'ok','MarkerSize',2,'MarkerFaceColor','k')
    axis([-pi pi -4 4])
    xlabel('Theta')
    ylabel('Theta-dot')
    title('First Return Map')
end

% %First Return Map
% Fst = 1;
% if Fst == 1
%     cnt = 0;
%     last = wt(399);
%     for loop = 400:siz
%         if (last < 0)&(wt(loop) > 0)
%             cnt = cnt+1;
%             th(cnt) = theta(loop);
%             thd(cnt) = thetadot(loop);
%             last = wt(loop);
%         else
%             last = wt(loop);
%         end
%     end
% 
%     figure(5)
%     plot(th,thd,'ok','MarkerSize',2,'MarkerFaceColor','k')
%     axis([-pi pi -4 2])
% end

set(gcf,'color','white')
    
%keyboard

Dens = zeros(200,200);
for loop = 400:siz
    xp = 101 + ceil(199*(mod(y(loop,1)+pi,2*pi) - pi)/(2.1*pi));
    yp = 101 + ceil(199*(y(loop,2))/(4*pi));
    Dens(yp,xp) = Dens(yp,xp) + 1;
end
figure(30)
pcolor(Dens)
shading interp
hh = colormap(gray);
colormap(reversevec(hh))
mx = max(max(Dens));
caxis([0 mx/4])
title('Phase Space Density')
xlabel('Theta')
ylabel('Theta-dot')


% Model function
    function dy = f5(t,y)

        dy = zeros(3,1);
        dy(1) = y(2);
%         dy(2) = F*y(3) - sin(y(1)) - c*y(2);
%         dy(3) = -w*sin(w*t);
        
        dy(2) = F*sin(y(3)) - sin(y(1)) - c*y(2);
        dy(3) = w;


    end     % end f5


end % end ltest

