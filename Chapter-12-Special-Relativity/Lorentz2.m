% Lorentz2.m

clear

%beta = 0;
%beta = 0.333;
%beta = -0.333
beta = -0.5;
gamma = 1/sqrt(1-beta^2);

L = [gamma beta*gamma;beta*gamma gamma];

figure(1)
clf
hold on
axis equal
axis square
set(gcf,'Color','White')

if beta > 0
    axis([-1 4.5 -1 4.5])   % beta = +0.33
    c1 = [0.2 0.2 1];
    c2 = [1 0.2 0.2];
else
    axis([-2 3.5 -2 3.5])      % beta = -0.33
    c1 = [1 0.2 0.2];
    c2 = [0.2 0.2 1];
end

Nevent = 3;
Event(1).loc = [0;0];
Event(2).loc = [2;0];
Event(3).loc = [0;2/gamma];

for tloop = 1:11
    t = -5 + (tloop-1);
    line([-5 5],[t t],'Color',c1)
end
for xloop = 1:11
    x = -5 + (xloop-1);
    line([x x],[-5 5],'Color',c1)
end
% for eloop = 1:Nevent
%    plot(Event(eloop).loc(2),Event(eloop).loc(1),'o','MarkerFaceColor',c1) 
% end
plot(0,0,'o','MarkerFaceColor','k','MarkerSize',10)

for tloop = 1:22
    t = -10 + (tloop-1);
    for xloop = 1:2
        x = -10 + 30*(xloop-1);
        
        tmp = L*[t;x];
        T(tloop,xloop) = tmp(1);
        X(tloop,xloop) = tmp(2);
        
    end
    line([X(tloop,1) X(tloop,2)],[T(tloop,1) T(tloop,2)],'Color',c2)
end

clear X T
for xloop = 1:22
    x = -10 + (xloop-1);
    for tloop = 1:2
        t = -10 + 30*(tloop-1);
        
        tmp = L*[t;x];
        T(tloop,xloop) = tmp(1);
        X(tloop,xloop) = tmp(2);
        
    end
    line([X(1,xloop) X(2,xloop)],[T(1,xloop) T(2,xloop)],'Color',c2)
end
for eloop = 1:Nevent
    v = Event(eloop).loc;
    vp = L*v;
   plot(vp(2),vp(1),'o','MarkerFaceColor',c2) 
end

line([-5 5],[-5 5],'LineStyle','--','Color','k')
line([5 -5],[-5 5],'LineStyle','--','Color','k')

hold off


