function vandpolStream

beta = 1.0;     % 1.0 nonlinear term
mu = 0.5;       % 1.0 gain
w02 = 1.0;      % 1.0 natural frequency

[X,Y] = meshgrid(-10:0.1:10, -10:0.1:10);

[x,y] = f5(X,Y);

% clf
% figure(1)
% for xloop = 1:12
%     xs = -5 + 1*(xloop-1);
%     for yloop = 1:12
%         ys = -5 + 1*(yloop-1);
%         
%         streamline(X,Y,x,y,xs,ys)
%         
%     end
% end

clf
figure(1)
for yloop = 1:2
    ys = -10 + 20*(yloop-1);
    for xloop = 1:25
        xs = -6 + 0.5*(xloop-1);
        
        streamline(X,Y,x,y,xs,ys)
    end
end

xs = -1.5;ys = 6;streamline(X,Y,x,y,xs,ys)
xs = 1.5;ys = -6;streamline(X,Y,x,y,xs,ys)

xs = -2.75;ys = 6;streamline(X,Y,x,y,xs,ys)
xs = 2.75;ys = -6;streamline(X,Y,x,y,xs,ys)

xs = -0.125;ys = 0;streamline(X,Y,x,y,xs,ys)
xs = 0;ys = 0.125;streamline(X,Y,x,y,xs,ys)
xs = 0.125;ys = 0;streamline(X,Y,x,y,xs,ys)
xs = 0;ys = -0.125;streamline(X,Y,x,y,xs,ys)

% hold on
% [XQ,YQ] = meshgrid(-6:1:6,-6:1:6);
% [xq,yq] = f5(XQ,YQ);
% quiver(XQ,YQ,xq,yq,1,'r')
% hold off

axis([-6 6 -6 6])

set(gcf,'color','white')

print -dtiff -r600 vdpstream


    function [x,y] = f5(X,Y)
        x = Y;
        y = 2*mu*Y.*(1-beta*X.^2)-w02.*X;
    end     % end f5


end % end vandpolStream

