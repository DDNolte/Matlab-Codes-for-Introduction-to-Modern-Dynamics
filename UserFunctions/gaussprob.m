% function y = gaussprob(x,m,s);
% m = mean;  s = std;
% gaussian probability function (normalized)
% Equivalent to 
% y = (1/sqrt(2*pi))*exp(-x^2/2);
% where x = (x' - x0)/s

function y = gaussprob(x,m,s);

y = (1/s/sqrt(2*pi))*gauss((x-m)/s/sqrt(2));