function couplext


for omegloop = 1:60

    fac = -0.15 + 0.1*omegloop/20;

    omega = 2*pi*0.0;
    wdrive = 2*pi*fac;
    g = 2*pi*0.025;

    y0 = 0;
    tspan = [0 20];
    [t,y] = ode45(@f2,tspan,y0);
    [sy,dum] = size(y);

    y0 = y(sy,1);

    tspan = [0 200];

    [t,y] = ode45(@f2,tspan,y0);

    [m,b] = linfit(t,y(:,1));

    om(omegloop) = fac;
    omegout(omegloop) = m/2/pi;

    figure(1)
    plot(t,y(:,1))
    %legend('drive','oscillator')
    xlabel('Time')
    ylabel('Phase')
    
    pause(0.5)

end

figure(2)
plot(om,omegout)
axis([-0.15 0.15 -0.025 0.025])
title('System Frequency')
xlabel('Detuning')

figure(3)
plot(om,(om - omegout))
xlabel('Detuning')
title('Frequency Difference (Beat Frequency)')

    function yd = f2(t,y)

        yp(1) = omega + g*sin(y(1) - wdrive*t);
        yd = [yp(1)];

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

