% Schwarz.m

clear
format compact
close all

r = 0.01:0.01:1;

figure(1)
axis([0 3 -3 3])
hold on
for loop = 0:5
    
    const = loop;
    
    ct = r +log(abs(r-1)) + const;
    plot(r,ct)
    ct = -(r +log(abs(r-1)) + const);
    plot(r,ct)
    
    
    
end

%keyboard

clear r
r = 1:0.01:3;

for loop = -5:5
    
    const = loop;
    
    ct = r +log(abs(r-1)) + const;
    plot(r,ct)
    ct = -(r +log(abs(r-1)) + const);
    plot(r,ct)
    
    
    
end

hold off

set(gcf,'Color','white')

print -dtiff -r600 Schwarz