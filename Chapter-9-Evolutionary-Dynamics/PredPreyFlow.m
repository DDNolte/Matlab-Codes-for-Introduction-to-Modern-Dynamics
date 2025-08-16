function PredPreyFlow

xrange = [0 5];
yrange = [0 5];
rngx = xrange(2) - xrange(1);
rngy = yrange(2) - yrange(1);

[X,Y] = meshgrid(xrange(1):0.25:xrange(2), yrange(1):0.25:yrange(2));

[x,y] = fa5(X,Y);

options = odeset('RelTol',1e-5,'AbsTol',1e-6);


clf
figure(1)
for xloop = 1:4
    xs = 0.85 + (xloop-1)*rngx/5;
    for yloop = 1:4
        ys = 1.55 + (yloop-1)*rngy/5;
        
        streamline(X,Y,x,y,xs,ys)
        
    end
end
hold on
[XQ,YQ] = meshgrid(-0:0.2:3,-0:0.2:4);
[xq,yq] = fa5(XQ,YQ);
quiver(XQ,YQ,xq,yq,3,'r')


hold off

axis([0 3 0 4])


    function [x,y] = fa5(X,Y)
        
        alpha = 3;
        beta = 2;
        gamma = 2;
        delta = 2.5;
        
        
        x = X.*(alpha - beta*Y);
        y = -Y .*(gamma - delta*X);
        
        
    end     % end f5


end % end flowsimple

