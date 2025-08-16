function MercuryState

% Last stable circular orbit:  y0 = [2 0.0];  ep = 0.2500;  Ro = 0.5  Rs =  1/6
% Rorbit = 3*Rschwarzshild
close all
ep = 0.220361;              % 0.02     0.23205     0.23206
Rs = 2*ep/3
RL = 3*Rs
tspan = [0 50];            % [0 100]

nonRel = 0;

figure(1)
axis([0 2 -0.8 0.8])
hold on
for loop = 4:40
    rad = 20/loop;
    
    y0 = [rad 0.0];           % [1 0.75]    [1 0.0]
    
    
    options = odeset('Reltol',1e-6);
    %options = odeset('OutputFcn',@odeplot);
    
    [t,y] = ode45(@f5,tspan,y0,options);
    
    r = 1./y(:,1);
    v = -r.^2.*y(:,2);
    
    plot(r,v,'k')
    
end
for loop = 4:40
    rad = 20/loop;
    
    %y0 = [rad -0.1*rad^2];           % [1 0.75]    [1 0.0]
    y0 = [rad 0.0];
    
    options = odeset('Reltol',1e-6);
    %options = odeset('OutputFcn',@odeplot);
    
    [t,y] = ode45(@f6,tspan,y0,options);
    
    r = 1./y(:,1);
    v = -r.^2.*y(:,2);
    
    plot(r,v,'k')
    
end

hold off




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
        %yp(2) = -y(1) + 1 + ep*y(1).^2;
        yp(2) = -y(1) + gamma + ep*y(1).^2;
        yd = [yp(1);yp(2)];
        
    end     % end f5


    function yd = f6(t,y)
        
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
        
        yp(1) = -y(2);
        yp(2) = y(1) - gamma - ep*y(1).^2;
        yd = [yp(1);yp(2)];
        
    end     % end f5

end % end vandpol

