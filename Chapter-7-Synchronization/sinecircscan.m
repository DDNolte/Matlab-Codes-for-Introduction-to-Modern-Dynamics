% sinecircscan.m
% orig. March 26, 2009
% Generates Arnold tongues

clear
close all
format compact

N = 100;
upfac = 1;

for gloop = 1:200
    
    g = gloop/200  % coupling
    
    for facloop = 1:280*upfac
        %facloop
        fac = 0.3 + facloop*0.005/upfac; %Frequency ratio
        
        [thetx,thet] = sinecircle(g,fac,N);
        
        dif = diff(thetx);
        
        Ttemp = abs(fft(thetx));        % Power spectrum of theta values
        T = Ttemp;
        T(1) = 0;
        P = log(abs(T)+1e-12);
        
        Dtemp = abs(fft(dif));          % Power spectrium of theta difference values
        D = Dtemp;
        D(1) = 0;
        E = log(abs(D)+1e-12);
        
        % P and E both needed to get small integer ratio resonances
        
        minP(facloop) = min(P);
        mnP(facloop) = mean(P);
        mnd(facloop) = mean(E);
        minmn(facloop) = min(mean(E),mean(P));      % Low noise floor means locking!
        facval(facloop) = fac;
        
        
    end
    
    figure(1)
    plot(facval,minmn)
    pause(0.1)
    
    A(gloop,:) = minmn;
    
end

figure(2)
imagesc(A)
caxis([-23 3])
colormap(gray)
colorbar



