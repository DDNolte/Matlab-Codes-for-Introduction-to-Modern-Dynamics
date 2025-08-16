% Lozi.m

clear

B = -1.00;
C = 0.5625;   % 0.618034

%h = colormap(hsv);
h = colormap(jet);

f1 = figure(1);
f1.Position = [382 147 976 808];
dum = set(f1);

tic
for itloop = 1:200    %200
    itloop
    rn = ceil(255*rand);
    
    xlast = randn;
    ylast = randn;
    
%     for transloop = 1:100   % Transient loop not needed for Hamiltonian case
%         xnew = 1 + ylast - C*abs(xlast);
%         ynew = B*xlast;
%         xlast = xnew;
%         ylast = ynew;
%     end
    
    figure(1)
    %axis([-160.5 160.5 -160.5 160.5])
    axis([-2 2 -2 2])
    %clf
    hold on
    for loop = 1:500  % 500
        xnew = 1 + ylast - C*abs(xlast);
        ynew = B*xlast;
        xlast = xnew;
        ylast = ynew;
        plot(real(xnew),real(ynew),'o','MarkerSize',3,'LineWidth',0.5,'Color',h(rn,:))
    end
    %plot(real(xnew),real(ynew),'o','MarkerSize',2,'Color','r')
    pause(0.001)
    
    %hold off
    
end
toc


