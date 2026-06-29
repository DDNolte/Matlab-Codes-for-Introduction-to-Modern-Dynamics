%function AHBif
% a<0 and c>0 stable orbit (supercritical)
% a>0 and c<0 unstable orbit (subcritical)
% Try: a = 1 and c = -0.5 (stable fixed point and unstable limit cycle)
% Try: a = -1 and c = +0.5 (unstable fixed point and stable limit cycle)


function AHBif

a = 1;
c = -0.5;

xrange = [-3 3];
yrange = [-3 3];
rngx = xrange(2) - xrange(1);
rngy = yrange(2) - yrange(1);

[X,Y] = meshgrid(xrange(1):0.125:xrange(2), yrange(1):0.125:yrange(2));

[x,y] = f5(X,Y);

clf
figure(1)
for xloop = 1:20
    xs = xrange(1) + xloop*rngx/20;
    for yloop = 1:20
        ys = yrange(1) + yloop*rngy/20;
        
        streamline(X,Y,x,y,xs,ys)
        
    end
end
hold on
[XQ,YQ] = meshgrid(-3:0.5:3,-3:0.5:3);
[xq,yq] = f5(XQ,YQ);
quiver(XQ,YQ,xq,yq,5,'r')
hold off

axis([-2 2 -2 2])
set(gcf,'Color','White')


    function [x,y] = f5(X,Y)
        
        r2 = X.^2 + Y.^2;
        x = Y + X.*(c+a*r2);
        y = - X +Y.*(c+a*r2);
        
        
    end     % end f5


end % end flowsimple

