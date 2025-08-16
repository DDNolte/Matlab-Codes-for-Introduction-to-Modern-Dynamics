
%GRpoten.m

clear
format compact
close all


r = 0.01:0.01:3;
V0 = -1./r + 0.5./r.^2;



V1 = -1./r + 0.5./r.^2 - 0.07./r.^3;

figure(1)
plot(r,V1,r,V0)
axis([0 3 -5 10])
hold on

V2 = -1./r + 0.5./r.^2 - 0.05./r.^3;
plot(r,V2,r,V0)

V3 = -1./r + 0.5./r.^2 - 0.03./r.^3;
plot(r,V3,r,V0)

Printfile5('GRpoten',r,V0,V1,V2,V3)
