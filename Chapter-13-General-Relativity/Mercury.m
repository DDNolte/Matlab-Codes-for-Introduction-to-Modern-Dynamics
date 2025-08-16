function Mercury

% Last stable circular orbit:  y0 = [2 0.0];  ep = 0.2500;  Ro = 0.5  Rs =  1/6
% Rorbit = 3*Rschwarzshild

ep = 0.220361;              % 0.02     0.23205     0.23206    0.220361(nonRel=0)
Rs = 2*ep/3
RL = 3*Rs

y0 = [1 0];          % [1 0.75]    [1 0.0]
tspan = [0 100];        % [0 100]

nonRel = 0;

figure(1)
options = odeset('OutputFcn',@odephas2,'Reltol',1e-8);
%options = odeset('OutputFcn',@odeplot);

[t,y] = ode45(@f5,tspan,y0,options);

figure(2)
plot(t,y(:,1),t,y(:,2))
legend('y1','y2')
xlabel('Time')

figure(3)
plot(y(:,1),y(:,2),'LineWidth',1.5)
title('Configuration Space')
xlabel('x1','FontSize',14)
ylabel('x2','FontSize',14)

phi = t;
r = 1./y(:,1);
figure(4)
plot(r.*cos(phi),r.*sin(phi),'k','LineWidth',1.0)
axis equal
%axis([-3 5 -4 3])
%axis([-1.25 1.25 -1.25 1.25])
set(gcf,'Color','white')

v = -r.^2.*y(:,2);
figure(5)
plot(r,v)


%keyboard


%Printfile2('vdp.out',y(501:800,1)',y(501:800,2)')
%Printfile3('vdpt.out',t(501:1000)',y(501:1000,1)',y(501:1000,2)')

% d = y(:,1);
% e = y(:,2);
% Printfile3('lout',t',d',e')




    function yd = f5(t,y)
        
        if nonRel == 1
            gamma = 1;
        else
            beta = Rs*y(1);
            if beta >= 1;
                gamma = 1e6;
            else
                gamma = 1/sqrt(1-beta^2);
            end
        end
        
        yp(1) = y(2);
        yp(2) = -y(1) + gamma + ep*y(1).^2;
        yd = [yp(1);yp(2)];
        
    end     % end f5


end % end vandpol

