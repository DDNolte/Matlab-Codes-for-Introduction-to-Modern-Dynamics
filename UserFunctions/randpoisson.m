% function y = randpoisson(av,M,N)
% Creates M by N array with Poisson distribution of std = av

function y = randpoisson(av,M,N)

x = rand(M,N);

y = -av*log(x);

