function flowsimple

hi = 2;
lo = 0;
delRng = (hi-lo)/12;

norm = 1;

xrange = [lo hi];
yrange = [lo hi];
rngx = xrange(2) - xrange(1);
rngy = yrange(2) - yrange(1);

[X,Y] = meshgrid(xrange(1):0.1:xrange(2), yrange(1):0.1:yrange(2));

[x,y] = f5(X,Y);

clf
figure(1)
for xloop = 1:20
    xs = xrange(1) +xloop*rngx/20;
    for yloop = 1:20
        ys = yrange(1) +yloop*rngy/20;
        
        streamline(X,Y,x,y,xs,ys)
        
    end
end
hold on
[XQ,YQ] = meshgrid(lo:delRng:hi,lo:delRng:hi);
[xq,yq] = f5(XQ,YQ);
quiver(XQ,YQ,xq,yq,0.5,'r')
hold off

axis([lo hi lo hi])


    function [x,y] = f5(X,Y)
        
        %         x=Y;
        %         y=X.^3-X-Y;
        
        %         x = X.^2 - Y;
        %         y = X - Y;
        
        %           x = Y;
        %           y = -0.5*Y + X - X.^3;
        
%         xtmp = X.*(1-2*X+Y);
%         ytmp = Y.*(1+X-Y);

    xtmp = -0.8*(X-1) + (Y-1);
    ytmp = (X-1) - (Y-1);
        
        if norm == 1
            x = xtmp./sqrt(xtmp.^2 + ytmp.^2);
            y = ytmp./sqrt(xtmp.^2 + ytmp.^2);
        else
            x = xtmp;
            y = ytmp;
        end
        
        
        %x = X.*(3-X-2*Y);
        %y = Y.*(2-X-Y);
        
    end     % end f5


end % end flowsimple

