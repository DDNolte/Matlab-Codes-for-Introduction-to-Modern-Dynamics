
clear
close all
format compact

p = 0.5;

Nset = [12 25 50 100];
PP = zeros(111,4);
CC = zeros(111,4);
for nloop = 1:4
    N = Nset(nloop);


    sm = 0;
    cnt = 0;
    for loop = 1:N+10
        ind = loop - 1;
        cnt = cnt+1;

        %P(cnt) = binomialdist(ind,N,p);
        P(cnt) = poisson(N/2-1,ind);
        sm = sm + P(cnt);
        C(cnt) = sm;

        x(cnt) = loop;
        m(cnt) = 2*loop - N;

        cnt = cnt+1;
        P(cnt) = P(cnt-1);
        C(cnt) = C(cnt-1);
        x(cnt) = x(cnt-1)+1;
        m(cnt) = m(cnt-1)+1;
    end

    PP(1:2*(N+10),nloop) = P';
    CC(1:2*(N+10),nloop) = C';

    figure(1)
    hold on
    plot(x,P,'-r')
    hold off
    figure(2)
    hold on
    plot(x,C,'-b')
    hold off

    figure(3)
    hold on
    plot(m,P,'-or','MarkerFacecolor','b')
    hold off
    figure(4)
    hold on
    plot(m,C,'-ob','MarkerFacecolor','r')
    hold off

end

Printfile6('binomP.txt',x,m,PP(:,1)',PP(:,2)',PP(:,3)',PP(:,4)')
Printfile6('binomC.txt',x,m,CC(:,1)',CC(:,2)',CC(:,3)',CC(:,4)')