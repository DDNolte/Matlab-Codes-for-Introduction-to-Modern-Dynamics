%sinecircle1.m

clear

omega = 1.618033988749895-1;   %exp(1)/2     pi/2     golden
%omega = 3/2;
%omega = 1;
%omega = 1.5;
%omega = sqrt(2)-1;
%omega = 21/13;
%omega = 13/8;
%omega = 8/5;
%omega = 5/3;
%omega = 2/3;
%omega = 0.125;

testcase = 2;           % 1 = iterate at a single g     2= scan g

if testcase == 1
    gval = 0.8;         % 43 76
    glooplo = gval;
    gloophi = gval;
elseif testcase == 2   % scan g
    figure(3)
    close
    glooplo = 0;
    gloophi = 2;
end


delg = 0.001;
for gloop = glooplo:delg:gloophi

    g = gloop;

    if testcase == 1
        disp(strcat('g = ',num2str(g)))
    end

    thet0 = rand;
    thet1last = thet0;
    N = 1000;
    for loop = 1:N

        thet1emp = mod(thet1last + 2*pi*omega + g*sin(thet1last),2*pi);
        thet1last = thet1emp;

    end

    N2 = 100;
    for loop = 1:N2

        thet1(loop) = mod(thet1last + 2*pi*omega + g*sin(thet1last),2*pi);
        thet1last = thet1(loop);

    end

    if testcase == 1
        figure(1)
        plot(thet1,thet1last,'o')
        axis([0 2*pi 0 2*pi])

        figure(2)
        plot(thet1,(thet1last-thet1),'o')
        axis([0 2*pi 0 2*pi])
    elseif testcase == 2
        x = g*ones(1,N2);
        y = thet1;
        hold on
        figure(3)
        plot(x,y,'.k')
        axis([0 gloophi 0 2*pi])
        hold off
        set(gcf,'Color','White')
    end

end


