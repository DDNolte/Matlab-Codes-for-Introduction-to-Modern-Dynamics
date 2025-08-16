
%proper.m

clear
format compact

r = 0.001:0.001:3;

tau = 1 + 0.667*(12^1.5 - r.^1.5) - 22;
t = 29.1 - (r + log((r-1).*positive(r-1))) - 22;

figure(1)
plot(r,tau,r,t)
axis([0 3 0 12])

Printfile3('proper.txt',r,tau,t)
