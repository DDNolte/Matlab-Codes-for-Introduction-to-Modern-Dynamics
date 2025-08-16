function S147


[X,Y] = meshgrid(-10:0.1:10, -10:0.1:10);

[x,y] = f5(X,Y);

clf
figure(1)

% for xloop = 1:13
%     xs = -4 + 0.5*(xloop-1);
%     for yloop = 1:11
%         ys = -2.5 + 0.5*(yloop-1);
%         
%         streamline(X,Y,x,y,xs,ys)
%         
%     end
% end

[XQ,YQ] = meshgrid(-4:0.25:2,-2:0.25:2);
[xq,yq] = f5(XQ,YQ);
quiver(XQ,YQ,xq,yq,5,'r')
hold on
for xloop = -4:0.125:2
    xs = xloop;
    for yloop = 1:2
        ys = -2 + 4*(yloop-1);
        streamline(X,Y,x,y,xs,ys)
    end
end

hold off
h = gca;
set(h,'FontSize',14)

axis([-4 2 -2 2])
set(gcf,'Color','White')


    function [x,y] = f5(X,Y)
        x = X + exp(-Y);
        y = -Y;
    end     % end f5


end % end S147

