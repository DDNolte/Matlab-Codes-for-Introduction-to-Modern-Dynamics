% function tripartite(x,y,z)
% called by trirepeq.m

function tripartite(x,y,z)

sm = x + y + z;
xp = x./sm;
yp = y./sm;
zp = z./sm;

L = 1;
f = sqrt(3)/2;

y0 = f*xp;
x0 = -0.5*xp - yp + 1;

plot(x0,y0,'LineWidth',1.5)
line([0 1],[0 0],'LineWidth',2,'Color','k')
line([0 0.5],[0 f],'LineWidth',2,'Color','k')
line([1 0.5],[0 f],'LineWidth',2,'Color','k')



