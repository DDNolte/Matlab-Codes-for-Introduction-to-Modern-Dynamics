% Lorentz.m

clear

%beta = 0;
%beta = 0.333;
%beta = -0.333
beta = 0.333;
gamma = 1/sqrt(1-beta^2);

L = [gamma beta*gamma 0 0;beta*gamma gamma 0 0;0 0 1 0;0 0 0 1];

g = [-1 0 0 0;0 1 0 0;0 0 1 0;0 0 0 1];

figure(1)
clf
hold on
for loop = -10:10
    
    ct = loop;
    x = 0.0*loop;
    y = 0;
    z = 0;
    
    V = [ct x y z]';
    Vp = L*V;
    
    plot(V(2),V(1),'*r',Vp(2),Vp(1),'or')
    
    ct = 0.0*loop;
    x = loop;
    
    V = [ct x y z]';
    Vp = L*V;
    
    plot(V(2),V(1),'*b',Vp(2),Vp(1),'ob')
    
    x = loop;
    ct = sqrt(x^2 + 5^2);
    
    V = [ct x y z]';
    Vp = L*V;
    
    plot(V(2),V(1),'*g',Vp(2),Vp(1),'og')
    
    Vs = [-ct x y z];
    S2 = Vs*V;
    
end

hold off

% Coordinate axes
figure(2)
clf
axis equal
hold on
for xloop = 1:20
    x = xloop-10;
    y = 0;
    z = 0;
    for yloop = 1:20
        ct = yloop-10;
        V = [ct x y z]';
        Vpx(:,yloop) = L*V;
    end
    plot(Vpx(2,:),Vpx(1,:),'b')
    if (x == 0)
        plot(Vpx(2,:),Vpx(1,:),'r','Linewidth',1)
    end
end
for yloop = 1:20
    ct = yloop-10;
    y = 0;
    z = 0;
    for xloop = 1:20
        
        x = xloop-10;
        
        V = [ct x y z]';
        Vpy(:,xloop) = L*V;
    end
    plot(Vpy(2,:),Vpy(1,:),'b')
    if (ct == 0)
        plot(Vpy(2,:),Vpy(1,:),'r','Linewidth',1)
    end
end
hold off
set(gcf, 'color', 'white')

% Invariant hyperbola

figure(3)
clf
hold on
xmx = 5; tmx = 1;
mx = gamma*(xmx+beta*tmx);
x = -mx:0.01:mx;  %continuous x variable for hyperbola plotting
for xloop = 1:11
    x0 = xloop-6;
    ct0 = tmx;         % simultaneity
    V = [ct0 x0 0 0]';
    Vp = L*V;
    
    %plot(V(2),V(1),'*r',Vp(2),Vp(1),'or','Linewidth',1)
    
    y1 = real(sqrt(x.^2 - (x0.^2 - ct0^2)));
    
    if ct0 > x0
        plot(x,y1,'b','Linewidth',1.0)
    else
        plot(x,y1,'b','Linewidth',1.0)
        plot(x,-y1,'b','Linewidth',1.0)
    end
    
    s(:,2*xloop-1) = x';
    s(:,2*xloop) = y1;
    
    v(xloop,1) = V(1);
    v(xloop,2) = V(2);
    vp(xloop,1) = Vp(1);
    vp(xloop,2) = Vp(2);
    
    %keyboard
    
end
s(:,12) = x';
hold off
axis equal
axis([-6 6 -6 6])
xlabel('x','FontSize',18)
ylabel('ct','FontSize',18)
h = gca;
set(h,'FontSize',18)

figure(4)
clf
hold on
xmx = 5; tmx = 1;
mx = gamma*(xmx+beta*tmx);
x = -mx:0.01:mx;  %continuous x variable for hyperbola plotting
for xloop = 1:11
    x0 = xloop-6;
    ct0 = tmx;         % simultaneity
    V = [ct0 x0 0 0]';
    Vp = L*V;
    
    plot(V(2),V(1),'*r',Vp(2),Vp(1),'or','Linewidth',1)
    
    y1 = real(sqrt(x.^2 - (x0.^2 - ct0^2)));
    
    if ct0 > x0
        plot(x,y1,'b','Linewidth',1.0)
    else
        plot(x,y1,'b','Linewidth',1.0)
        plot(x,-y1,'b','Linewidth',1.0)
    end
    
    s(:,2*xloop-1) = x';
    s(:,2*xloop) = y1;
    
    v(xloop,1) = V(1);
    v(xloop,2) = V(2);
    vp(xloop,1) = Vp(1);
    vp(xloop,2) = Vp(2);
    
    %keyboard
    
end
s(:,12) = x';
hold off
axis equal
axis([-6 6 -6 6])
xlabel('x','FontSize',18)
ylabel('ct','FontSize',18)
h = gca;
set(h,'FontSize',18)

figure(5)
clf
hold on
xmx = 2; tmx = 5;
mx = gamma*(xmx+beta*tmx);
x = -mx:0.01:mx;  %continuous x variable for hyperbola plotting
for tloop = -5:5
    xu = xmx;                 % ticking clock
    ct = tloop;
    V = [ct xu 0 0]';
    Vp = L*V;
    
    plot(V(2),V(1),'*r',Vp(2),Vp(1),'or','Linewidth',1)
    
    y1 = real(sqrt(x.^2 - (2^2 - tloop^2)));
    y2 = -y1;
    plot(x,y1,x,y2,'b','Linewidth',1)
    
end
hold off
axis equal




