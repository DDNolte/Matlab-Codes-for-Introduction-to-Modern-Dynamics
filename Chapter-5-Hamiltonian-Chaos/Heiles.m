function Heiles

c(1) = 'r';
c(2) = 'b';
c(3) = 'g';
c(4) = 'k';
c(5) = 'c';
c(6) = 'm';
c(7) = 'y';

h = colormap(lines);


E = 0.15;         % 0.09 0.1 0.11    0.15       

epsE = 1;         % 1               0.2  0.3  0.3425   

prms = sqrt(E);
pmax = sqrt(2*E);

% Potential Function
for xloop = 1:100
    x = -2 + 4*xloop/100;
    for yloop = 1:100
        y = -2 + 4*yloop/100;

        V(yloop,xloop) = 0.5*x^2 + 0.5*y^2 + epsE*(x^2*y - 0.33333*y^3);
        %V(yloop,xloop) = 0.5*x^2  + 0.5*(y - 2*x^3);

    end
end
figure(6)
colormap(gray)
imagesc(V)
hold on
contour(V,30,'LineColor','k')
hold off
caxis([-0.5 1])
colorbar

%keyboard

h2 = figure(2);
h2.Position = [11 -31 560 420];
dum = set(h2);

h3 = figure(3);
h3.Position = [10 381 560 420];
dum = set(h3);


h5 = figure(5);
h5.Position = [229 1 1008 804];
dum = set(h5);
clf
hold on
repnum = 128;                % 256 for good coverage   32 for testing
mulnum = 64/repnum;
for reploop = 1:repnum
    
    clear yvar py
    
%     % Random split among all degrees of freedom
%     px = 2*(rand-0.499)*pmax;
%     yp1 = 2*(rand-0.499)*sqrt(2*(E-px^2/2));
%     py = 2*(rand-0.499)*sqrt(2*(E-px^2/2-yp1^2/2));
%     xp1 = sign(rand-0.5)*real(sqrt(2*(E-px^2/2-yp1^2/2-py^2/2)));
    
    %Random split E between px and py
    px = 2*(rand-0.499)*pmax;
    py = sign(rand-0.5)*real(sqrt(2*(E-px^2/2)));
    xp1 = 0;
    yp1 = 0;

%      % No randomness
%     px = sign(rand-0.5)*pmax;
%     py = 0;
%     xp1 = 1;
%     yp1 = 1;

%     % Random split E between px and x
%     px = 2*(rand-0.499)*pmax;
%     py = 0;
%     xp1 = sign(rand-0.5)*real(sqrt(2*(E-px^2/2)));
%     yp1 = 0;

    
    Etest(reploop) = px^2/2 + py^2/2 + xp1^2/2 + yp1^2/2;
    
    y0 = [xp1 yp1 px py];
    
    
    tspan = [1 2000];            % 500   2000

%     figure(1)
    %options = odeset('OutputFcn',@odephas3);
    options = odeset('RelTol',1e-9);

    [t,y] = ode45(@f1,tspan,y0,options);

    siz = size(t);
    y1 = y(:,1);
    y2 = y(:,2);
    y3 = y(:,3);
    y4 = y(:,4);

    tlim = round(siz/5);
    figure(2)
    plot(t(1:tlim),y(1:tlim,3),t(1:tlim),y(1:tlim,4))
    xlabel('Time')
    legend('x-speed','y-speed')

    figure(3)
    plot(y(1:tlim,1),y(1:tlim,2))
    xlabel('x')
    ylabel('y')


    % Power Spectrum
    Pow = 0;
    if Pow == 1
        yf = y(:,1);
        F = fft(yf);
        Pow = F.*conj(F);

        figure(4)
        plot(Pow)
    end


    %First Return Map
    Fst = 1;
    if Fst == 1
        cnt = 0;
        last = y1(1);
        for loop = 2:siz
            if (last < 0)&(y1(loop) > 0)
                cnt = cnt+1;
                del1 = -y1(loop-1)./(y1(loop) - y1(loop-1));
                py(cnt) = y4(loop-1) + del1*(y4(loop)-y4(loop-1));
                yvar(cnt) = y2(loop-1) + del1*(y2(loop)-y2(loop-1));
                last = y1(loop);
            else
                last = y1(loop);
            end
        end

        figure(5)
        plot(yvar,py,'o','MarkerSize',2,'Color',h(floor(0.9*mulnum*reploop)+1,:),'MarkerFaceColor',h(floor(0.9*mulnum*reploop)+1,:))
        xlabel('y')
        ylabel('py')
    end
    
    pause(0.001)

end     % end reploop

figure(5)
hold off
print -dtiff HeilesPrint


% Model function
    function dy = f1(t,y)

        B = 0.000;          %0.002
        dy = zeros(4,1);
        dy(1) = y(3);
        dy(2) = y(4);
        dy(3) = -y(1) - epsE*(2*y(1)*y(2) + B*y(3));
        dy(4) = -y(2) - epsE*(y(1)^2 - y(2)^2 + B*y(4));

    end     % end f5


end % end ltest

