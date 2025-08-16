function S156ext

sNorm = 0;

[X,Y] = meshgrid(-10:0.1:10, -10:0.1:10);

[x,y] = f5(X,Y);

xmin = 0.05;
ymin = 0.05;
xlim = 3;
ylim = 3;

clf
figure(1)
for xloop = 2:2
    xs = (xloop-1)*xlim;
    for yloop = 1:(8*ylim+1)
        ys = 0.125*(yloop-1);
        
        streamline(X,Y,x,y,xs,ys)
        
    end
end
for yloop = 2:2
    ys = (yloop-1)*ylim;
    for xloop = 1:(8*xlim+1)
        xs = 0.125*(xloop-1);
        
        streamline(X,Y,x,y,xs,ys)
        
    end
end

for loop = 1:50
    ys = 0.25 - 0.25*(loop+0.4)/50;
    xs = 0.25*(loop+0.4)/50;

        streamline(X,Y,x,y,xs,ys)

end


hold on
[XQ,YQ] = meshgrid(0:0.25:3,0:0.25:3);
[xq,yq] = f5(XQ,YQ);
quiver(XQ,YQ,xq,yq,1,'r')
hold off

hold on
xx = 0:0.1:3;
yy = (3-xx)/2;
yy2 = 2-xx;
line(xx,yy,'color','g')
line(xx,yy2,'color','m')
hold off


axis([0 3 0 3])

set(gcf,'color','white')

print -dtiff -r600 S156ext


    function [x,y] = f5(X,Y)
        f = X.*(3-X-2*Y);
        g = Y.*(2-X-Y);
    
    
        s = sqrt(f.^2 + g.^2);

        if sNorm == 1
            x = f./s;
            y = g./s;
        else
            x = f;
            y = g;
        end
    
    
    end     % end f5


end % end S156

