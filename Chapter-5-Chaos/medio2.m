function medio2
% streamlines from the edge

sNorm = 1;

a = 0.9;
b = 0.7;
c = 0.5;
alpha = 0.6;

xrange = [-2 3];
yrange = [-3 4];
rngx = xrange(2) - xrange(1);
rngy = yrange(2) - yrange(1);

[X,Y] = meshgrid(xrange(1):0.25:xrange(2), yrange(1):0.25:yrange(2));

[x,y] = f5(X,Y);

clf
figure(1)
for xloop = 1:2
    xs = xrange(1) +(xloop-1)*rngx;

    for yloop = 1:12
        ys = 0.0 + yrange(1) + (yloop-1)*rngy/12;
        
        streamline(X,Y,x,y,xs,ys)
        
    end
end
for xloop = 1:6
    ys = -0.250;
    xs = 0.6 + (xloop - 3)*2.75/5;
    streamline(X,Y,x,y,xs,ys)
end

hold on
[XQ,YQ] = meshgrid(-3:0.25:3,-3:0.25:4);
[xq,yq] = f5(XQ,YQ);
quiver(XQ,YQ,xq,yq,0.5,'r')
hold off
set(gcf,'Color','White')

axis([-2 3 -3 4])
axis off
print -dpdf -r600 medio2


    function [x,y] = f5(X,Y)
        
        f = a*Y + b*X.*(c-Y.^2);
        g = -X + alpha;
        
        s = sqrt(f.^2 + g.^2);

        if sNorm == 1
            x = f./s;
            y = g./s;
        else
            x = f;
            y = g;
        end
        
    end     % end f5


end % end flowsimple

