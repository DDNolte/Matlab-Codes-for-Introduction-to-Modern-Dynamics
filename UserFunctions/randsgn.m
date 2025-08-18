% function y = randsgn(N)


function y = randsgn(N)

%x = randbin(N,0.5);

ytmp = 2*(0.5-rand(1,N));
y = sign(ytmp);

