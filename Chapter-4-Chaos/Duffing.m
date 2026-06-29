% function Duffing
% driven anharmonic oscillator

function Duffing

alpha = -1;      % -1
beta = 1;        % 1
gam = 0.15;        % 0.15
del = 0.3;     % 0.3
w = 1;        % 1

tspan = [0 1000];
y0 = [.1 .1 w];           % [1 1.705 w] for 0.01, sqrt(0.5) 0
[t,y] = ode45(@f5,tspan,y0);
[sy,dum] = size(y);

tspan = [1000 8000];           % 8000 for a good return map, 1000 for demo purposes
y0 = [y(sy,1) y(sy,2) y(sy,3)];

figure(1)
options = odeset('RelTol',1e-7);
%options = odeset('OutputFcn',@odephas3);
% options = odeset('OutputFcn',@odeplot);

[t,y] = ode45(@f5,tspan,y0,options);

siz = size(t);

xpos = y(:,1);
thetadot = y(:,2);
wt = cos(w*t);

%keyboard

h2 = figure(2);
h2.Position = [66 60 1317 745];
dum = set(h2);

lo = floor(siz/2);
hi = floor(siz/2 + 0.02*siz);
subplot(2,1,1),plot(t(lo:hi),y(lo:hi,2),'k')
xlabel('Time')
title('Speed')

Energy = 0.5*thetadot.^2 + 1 - xpos.^2 + beta*xpos.^4;

subplot(2,1,2),plot(t(lo:hi),Energy(lo:hi),'k')
xlabel('Time')
title('Energy')
set(gcf,'Color','white')


figure(3)
plot(xpos(400:siz),y(400:siz,2),'ok','MarkerSize',2,'MarkerFaceColor','k')
xlabel('theta')
ylabel('speed')
axis square

Dens = zeros(200,200);
for loop = 400:siz
    xp = 101 + ceil(199*(xpos(loop))/4);
    yp = 101 + ceil(199*(y(loop,2))/8);
    Dens(yp,xp) = Dens(yp,xp) + 1;
end
figure(30)
imagesc(Dens)
hh = colormap(gray);
colormap(reversevec(hh))

% Power Spectrum
Pow = 1;
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
    gamp = fft(yf);
    Pow = gamp.*conj(gamp);

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
    last = testwt(900);
    for loop = 901:siz
        if (last < 0)&(testwt(loop) > 0)
            cnt = cnt+1;
            th(cnt) = -xpos(loop);
            thd(cnt) = -((thetadot(loop) - thetadot(loop-1))*(-testwt(loop-1))/(testwt(loop)-testwt(loop-1)) + thetadot(loop-1));
            last = testwt(loop);
        elseif (last > 0)&(testwt(loop) < 0)
            cnt = cnt+1;
            th(cnt) = xpos(loop);
            thd(cnt) = ((thetadot(loop) - thetadot(loop-1))*(-testwt(loop-1))/(testwt(loop)-testwt(loop-1)) + thetadot(loop-1));
            last = testwt(loop);
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
    
% lo = floor(siz/2);
% hi = floor(siz/2 + 0.1*siz);
% Printfile4('DoubleDynamics.txt',t(lo:hi),xpos(lo:hi),thetadot(lo:hi),Energy(lo:hi))


% Model function
    function dy = f5(t,y)

        dy = zeros(3,1);
        dy(1) = y(2);
        dy(2) = del*cos(w*t) - alpha*y(1) - beta*y(1).^3 - gam*y(2);
        dy(3) = w;
        
%         dy(2) = F*sin(y(3)) - sin(y(1)) - c*y(2);
%         dy(3) = w;


    end     % end f5


end % end ltest

