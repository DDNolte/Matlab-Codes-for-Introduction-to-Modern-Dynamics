% sinecircplot.m

clear

j = 1:1000;
x = j/1000;

g = 0.22;
%omega = exp(1)/2;           % exp(1)/2
omega = 3/2;

fac = omega/g;
disp(strcat('ratio = ',num2str(fac)))

f = mod(x + omega + g*sin(2*pi*x),1);
h = x;

figure(1)
plot(x,f,'.r',x,h)
axis([0 1 0 1])

x1 = rand;
for loop = 1:1000
    
    x2 = mod(x1 + omega + g*sin(2*pi*x1),1);
    temp = x1;
    x1 = x2;
    
end

x1p(1) = temp;
x2p(1) = x2;
ind = 1;
for loop = 2:1000
    x1p(loop) = x2p(loop-1);
    x2p(loop) = mod(x1p(loop) + omega + g*sin(2*pi*x1p(loop)),1);
    
    ind = ind+1;
    t1(ind) =x1p(loop);
    t2(ind) = x2p(loop);
    ind = ind+1;
    t1(ind) = t2(ind-1);
    t2(ind) = t2(ind-1);

end

figure(2)
plot(x,f,'.r',x,h)
axis([0 1 0 1])
hold on
plot(x1p,x2p,'ok','MarkerFaceColor','k')
axis([0 1 0 1])
hold off

figure(3)
plot(x,f,'.r',x,h)
axis([0 1 0 1])
hold on
plot(t1(900:1000),t2(900:1000),'-k','Linewidth',1.0)
plot(x1p,x2p,'ok','MarkerFaceColor','k')
hold off
set(gcf,'Color','White')



