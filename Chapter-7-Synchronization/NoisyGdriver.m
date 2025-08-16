
clear
format compact
%close all

delomega = 0.2;
g = delomega/2 - 0.02;
sig = 0.1;

omega1 = 1;
omega2 = omega1 - delomega;
g1 = g;
g2 = g;
mft = 0.1;

params(1) = omega1;
params(2) = omega2;
params(3) = g1;
params(4) = g1;
params(5) = sig;
params(6) = mft;

tmax = 200;
y0 = (rand-0.5)*pi;

param0 = params;
param0(5) = 0;
[X0, T0] = NoisySynch(param0, y0, tmax); 
[X, T] = NoisySynch(params, y0, tmax);     % <<<<<<<<<<<<<<<<<< NoisySynch.m

modX = mod(X+pi,2*pi);

figure(1)
plot(T,modX)

sinphistar = (omega1 - omega2)/(g1 + g2);
phistar = asin(sinphistar);

line([0 tmax], [phistar+pi phistar+pi],'Color','m')

figure(2)
plot(T,X,T0,X0)

sinphistar = (omega1 - omega2)/(g1 + g2)
phistar = asin(sinphistar);

line([0 tmax], [phistar phistar],'Color','m')
line([0 tmax], [phistar+2*pi phistar+2*pi],'Color','m')
line([0 tmax], [phistar+4*pi phistar+4*pi],'Color','m')
line([0 tmax], [phistar+6*pi phistar+6*pi],'Color','m')

st = std(modX)

Nens = 60;
Nsig = 30;
for sloop = 1:Nsig
    sloop
    
    stens = 0; slope = 0;
    for eloop = 1:Nens
        
        g = 0.4*(sloop-1)/Nsig;
        params(3) = g;
        params(4) = g;
        
        y0 = (rand-0.5)*pi;
        [X, T] = NoisySynch(params, y0, tmax);
        
        figure(3)
        plot(T(10:end),X(10:end))
        
        [m,b] = linfit(T(10:end),X(10:end));
        slope = slope + m/Nens;
        
        modX = mod(X+pi,2*pi);
        
        stens = stens + std(modX(5000:end))/Nens;
        
    end
    
    SG(sloop) = g;
    ST(sloop) = stens;
    SL(sloop) = slope;
    
end

figure(4)
plot(SG,ST)

figure(5)
plot(SG,SL)


    
    
    
    
    
    



