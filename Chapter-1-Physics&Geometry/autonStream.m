function atanStream

w = 1;       % 1.0 gain


xlim = 3;
ylim = 3;

sNorm = 1;

[X,Y] = meshgrid(-xlim:0.1:xlim, -ylim:0.1:ylim);

%keyboard;

[x,y] = f5(X,Y);

clf
figure(1)
for xloop = 1:2
    xs = -xlim + 2*(xloop-1)*xlim;
    for yloop = 1:2*(2*ylim+1)
        ys = -ylim + 0.5*(yloop-1);
        
        streamline(X,Y,x,y,xs,ys)
        
    end
end
for yloop = 1:2
    ys = -ylim + 2*(yloop-1)*ylim;
    for xloop = 1:2*(2*xlim+1)
        xs = -xlim + 0.5*(xloop-1);
        
        streamline(X,Y,x,y,xs,ys)
        
    end
end

for thetloop = 1:10
    theta = 2*pi*(thetloop)/10;
    ys = 0.125*sin(theta);
    xs = 0.125*cos(theta);
    streamline(X,Y,x,y,xs,ys)
end

hold on
[XQ,YQ] = meshgrid(-xlim:0.25:xlim,-ylim:0.25:ylim);
[xq,yq] = f5(XQ,YQ);
quiver(XQ,YQ,xq,yq,0.5,'r')

hold off

axis([-xlim xlim -ylim ylim])
set(gcf,'color','white')
axis off

print -dtiff -r600 autonStream


    function [x,y] = f5(X,Y)
        f = w*Y + w*X.*(1 - X.^2 - Y.^2);
        g = -w*X + w*Y.*(1 - X.^2 - Y.^2);
        s = sqrt(f.^2 + g.^2);

        if sNorm == 1
            x = f./s;
            y = g./s;
        else
            x = f;
            y = g;
        end

    end     % end f5


end % end vandpolStream

