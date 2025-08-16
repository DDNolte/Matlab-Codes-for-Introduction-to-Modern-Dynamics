% couplelorenz
% 2 coupled Lorenz systems


function couplelorenz

a = 10.;        % 10
b = 50;         % 50
c = 8./3;       % 8/3
%g = 1.618033988749895;            % 0.85  0.88
g = 1;

epsc = 0.00;        % 0.01 for g = 1.8
aa = a*(1+epsc*randn);
bb = b*(1+epsc*randn);
cc = c*(1+epsc*randn);

y0 = [20 1 1 -20 1 1];
%y0 = [12.8 10.955 53.455];
%y0 = [-4.3426   -9.3985 21.389];
tspan = [0 30];

%options = odeset('OutputFcn',@odephas3);
% options = odeset('OutputFcn',@odeplot);

%[ttmp,ytmp] = ode45(@f5,tspan,y0,options);
[ttmp,ytmp] = ode45(@f5,tspan,y0);
[sy,dum] = size(ytmp);
y0 = ytmp(sy,:);

tspan = [0 100];
%[t,y] = ode45(@f5,tspan,y0,options);
[t,y] = ode45(@f5,tspan,y0);

figure(2)
colormap(jet)
plot(t,y(:,1),'k',t,y(:,2),'r',t,y(:,6),'b')
legend('x','y','w')

figure(3)
plot(y(:,1),y(:,5))
xlabel('x-value')
ylabel('v-value')

u = sqrt(y(:,1).^2 + y(:,2).^2);
w = y(:,6);

figure(4)
plot(u,w)
xlabel('(x,y)-value')
ylabel('w-value')

% xp = u - 18;
% yp = z - 52;
% 
% theta = atan2(yp,xp);
% signal = sin(theta);

% figure(5)
% plot(signal,'LineWidth',2)


PowS = 1;
% Power Spectrum
if PowS == 1        % Turn this off by setting PowS = 0
    [st dum] = size(t);
    tshort = t(400:st,1);
    %yshort = y(400:st,1);
    yshort = u(400:st,1);
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
Printfile4('lout',t',d',e',f')


    
    
    function yd = f5(t,y)

        yp(1) = a*(y(2) - y(1));
        yp(2) = y(1)*(b - y(3)) - y(2);
        yp(3) = y(1)*y(2) - c*y(3) - g*(y(3) - y(6));
        
        yp(4) = aa*(y(5) - y(4));
        yp(5) = y(4)*(bb - y(6)) - y(5);
        yp(6) = y(4)*y(5) - cc*y(6)- g*(y(6) - y(3));

        yd = [yp(1);yp(2);yp(3);yp(4);yp(5);yp(6)];

    end     % end f5


end % end ltest

