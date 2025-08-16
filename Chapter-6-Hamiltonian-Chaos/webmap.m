
% webmap.m

clear
format compact
close all

phi = (1+sqrt(5))/2;

K = phi-1;      % (0.618, 4) (0.618,5) (0.618,7) (1.2, 4)
q = 11;          % 4
alpha = 2*pi/q;
h1 = figure(1);
h1.Position = [177 1 962 804];
dum = set(h1);
axis square

for oloop = 1:400      % 4000
    
    ulast = 50*rand;   % 50*rand
    vlast = 50*rand;

%       ulast = pi*randint(1,10) + 0.1*randn;
%       vlast = pi*randint(1,10) + 0.1*randn;
    
    for loop = 1:600     % 300
                
        u(loop) = (ulast + K*sin(vlast))*cos(alpha) + vlast*sin(alpha);
        v(loop) = -(ulast + K*sin(vlast))*sin(alpha) + vlast*cos(alpha);
        
        ulast = u(loop);
        vlast = v(loop);
    end
    
    
    figure(1)
    plot(u,v,'o','MarkerSize',2)
    hold on
    
    
end

set(gcf,'Color','white')
%axis([-20 20 -20 20])
axis off

