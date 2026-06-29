
clear
format compact
close all


n = 10;
x1 = 1:n;
for kloop = 1:n
    y1(kloop) = binomialdist(kloop,n,0.5);
end

H1 = -sum(y1.*log2(y1))

n = 20;
x2 = 1:n;
for kloop = 1:n
    y2(kloop) = binomialdist(kloop,n,0.5);
end

H2 = -sum(y2.*log2(y2))

n = 50;
x3 = 1:n;
for kloop = 1:n
    y3(kloop) = binomialdist(kloop,n,0.5);
end

H3 = -sum(y3.*log2(y3))

n = 100;
x4 = 1:n;
for kloop = 1:n
    y4(kloop) = binomialdist(kloop,n,0.5);
end

H4 = -sum(y4.*log2(y4))

figure(1)
plot(x3,y3,'o-','MarkerFaceColor','r')
hold on
plot(x2,y2,'o-','MarkerFaceColor','b')
plot(x1,y1,'o-','MarkerFaceColor','k')
plot(x4,y4,'o-','MarkerFaceColor','m')
hold off
set(gcf,'Color','white')
legend('10','20','50','100')
xlabel('n','FontSize',18)
ylabel('Probability','FontSize',18)

%%

clear x1 y1 x2 y2 x3 y3 x4 y4

m = 10;
for kloop = 1:m+1
    x1(kloop) = -m + 2*(kloop-1);
    arg = (m+x1(kloop))/2;
    y1(kloop) = binomialdist(arg,m,0.5);
end

H1 = -sum(y1.*log2(y1))

m = 20;
for kloop = 1:m+1
    x2(kloop) = -m + 2*(kloop-1);
    arg = (m+x2(kloop))/2;
    y2(kloop) = binomialdist(arg,m,0.5);
end

m = 50;
for kloop = 1:m+1
    x3(kloop) = -m + 2*(kloop-1);
    arg = (m+x3(kloop))/2;
    y3(kloop) = binomialdist(arg,m,0.5);
end

m = 100;
for kloop = 1:m+1
    x4(kloop) = -m + 2*(kloop-1);
    arg = (m+x4(kloop))/2;
    y4(kloop) = binomialdist(arg,m,0.5);
end

H4 = -sum(y4.*log2(y4))


figure(2)
plot(x1,y1,'o-','MarkerFaceColor','r')
hold on
plot(x2,y2,'o-','MarkerFaceColor','b')
plot(x3,y3,'o-','MarkerFaceColor','k')
plot(x4,y4,'o-','MarkerFaceColor','m')
hold off
axis([-40 40 0 0.25])
set(gcf,'Color','white')
legend('10','20','50','100')
xlabel('m','FontSize',18)
ylabel('Probability','FontSize',18)

%%

clear x1 y1 x2 y2 x3 y3 x4 y4
nav = 5;
x1 = 0:(3*nav-1);
for kloop = 1:3*nav
    y1(kloop) = poisson(nav,kloop-1);
end

H1 = -sum(y1.*log2(y1));

nav = 10;
x2 = 0:(3*nav-1);
for kloop = 1:3*nav
    y2(kloop) = poisson(nav,kloop-1);
end

H2 = -sum(y2.*log2(y2));

nav = 20;
x3 = 0:(3*nav-1);
for kloop = 1:3*nav
    y3(kloop) = poisson(nav,kloop-1);
end

H3 = -sum(y3.*log2(y3));

nav = 50;
x4 = 0:(3*nav-1);
for kloop = 1:3*nav
    y4(kloop) = poisson(nav,kloop-1);
end

H4 = -sum(y4.*log2(y4));

figure(3)
plot(x1,y1,'o-','MarkerFaceColor','r')
hold on
plot(x2,y2,'o-','MarkerFaceColor','b')
plot(x3,y3,'o-','MarkerFaceColor','k')
plot(x4,y4,'o-','MarkerFaceColor','m')
hold off
axis([0 80 0 0.2])
set(gcf,'Color','white')
legend('5','10','20','50')
xlabel('n','FontSize',18)
ylabel('Probability','FontSize',18)

%% Noisy correlated time traces 

N = 10000;

eps = 1e-10;
x = 1:N;
fp = speckle(N,10);
gp = speckle(N,10);

mixfrac = 0.5;
mf = mixfrac/2;

Nbin = 100;

f = (1-mf)*fp + mf*gp;
g = (1-mf)*gp + mf*fp;

figure(4)
subplot(1,2,1),plot(x,real(f),x,real(g))
subplot(1,2,2),plot(real(f),real(g))

[fy,fx] = histfix(real(f),Nbin,-2,2);
[gy,gx] = histfix(real(g),Nbin,-2,2);

fy = fy + eps;
gy = gy + eps;

Hf = sum(-fy.*log2(fy));
Hg = sum(-gy.*log2(gy));

P = histfix2D(real(f), real(g), Nbin, -2, 2);

figure(5)
pcolor(P)
shading interp
colormap(jet)

P = P + eps;
Jsum = 0; KLsum = 0;
for yloop = 1:Nbin
    for xloop = 1:Nbin
        Jsum = Jsum - P(yloop,xloop).*log2(P(yloop,xloop));
        KLsum = KLsum - P(yloop,xloop).*log2(P(yloop,xloop)./fy(yloop)./gy(xloop));
    end
end

M = Hf + Hg - Jsum
KL = KLsum

rf = real(f); rg = real(g);

dM = mahal(rf',rg');

X(:,1) = real(rf)/std(rf);
X(:,2) = real(rg)/std(rg);
Mean = mean(X);
Sig = std(X);
S = cov(real(f'),real(g'));
Sinv = S^-1;

del = 0.04;
for yloop = 1:100
    for xloop = 1:100
        
        yind = del*(yloop-50);
        xind = del*(xloop-50);
        
        vec = [yind,xind];
        mu = [Mean(2),Mean(1)];
        
        arg = (vec-mu)*Sinv*(vec-mu)';
        
        gm(yloop,xloop) = exp(-arg/2)/(2*pi*sqrt(det(S)));
        gy(yloop) = exp(-(yind - Mean(1)).^2/2/S(1,1))/sqrt(2*pi)/sqrt(S(1,1));
        gx(xloop) = exp(-(xind - Mean(2)).^2/2/S(2,2))/sqrt(2*pi)/sqrt(S(2,2));
        
    end
end

gm = (gm + eps)/sum(sum(gm+eps));
gy = (gy + eps)/sum(gy+eps);
gx = (gx + eps)/sum(gx+eps);
Gsum = 0; Asum = 0;
for yloop = 1:100
    for xloop = 1:100
        mai(yloop,xloop) = -gm(yloop,xloop).*log2(gm(yloop,xloop));
        map(yloop,xloop) = -gm(yloop,xloop).*log2(gm(yloop,xloop)/gy(yloop)/gx(xloop));

        Asum = Asum + mai(yloop,xloop);
        Gsum = Gsum + map(yloop,xloop);

    end
end

Hgm = Asum
HKL = Gsum

figure(6)
pcolor(gm)
shading interp
colormap(jet)



%% Prob comparison

clear y1 y2 y3
n = 40;
x = 0:n;
for kloop = 1:n+1
    y1(kloop) = binomialdist(kloop-1,n,0.5);
    y2(kloop) = poisson(20,kloop-1);
end
y3tmp = gauss((x-20)/sqrt(n/2));
y3 = y3tmp/trapz(y3tmp);

figure(7)
semilogy(x,y1,'o','MarkerFaceColor','b')
set(gca,'fontsize', 14)
hold on
semilogy(x,y2,'o','MarkerFaceColor','r')
semilogy(x,y3,'-k','LineWidth',1.5)
hold off
legend('Binomial','Poisson','Gauss')
axis([0 40 1e-9 1])
xlabel('n','FontSize',18)
ylabel('Probability','FontSize',18)
set(gcf,'Color','white')








