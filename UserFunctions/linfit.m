% function [m,b] = linfit(x,y)
% see also planefit.m and multifit.m

function [m,b] = linfit(xx,yy,prnt,varargin)

x = rowvec(xx);
y = rowvec(yy);


meanx = mean(x);
meany = mean(y);
meanxy = mean(x.*y);
meanx2 = mean(x.^2);

m = (meanxy - meanx*meany)/(meanx2 - meanx^2);
b = meany - m*meanx;

f = m*x + b;

if nargin == 3
    if prnt == 1
        figure(103)
        plot(x,y,'*',x,f,'r')
        pause(0.1)
    end
end
