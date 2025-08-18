% function y = randint(N,M)
% returns N random integers between 1 and M

function y = randint(N,M)


y = ceil(M*rand(1,N));

