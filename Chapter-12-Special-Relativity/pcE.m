% pcE.m

clear
format compact
constants

meeV = me*c^2/e;
mpeV = mp*c^2/e;

for Eloop = 1:200
   
    E(Eloop) = 200*10^(Eloop/20);
    
    pe(Eloop) = sqrt(E(Eloop)^2 + 2*E(Eloop)*meeV);
    pp(Eloop) = sqrt(E(Eloop)^2 + 2*E(Eloop)*mpeV);
    p(Eloop) = E(Eloop);
    
end

figure(1)
loglog(E,real(pe),'b',E,real(pp),'k',E,p,'r')
axis([1e2 1e11 1e2 1e11])
xlabel('Kinetic Energy (eV)')
ylabel('Momentum')

Printfile4('pcE.txt',E,pe,pp,p)

