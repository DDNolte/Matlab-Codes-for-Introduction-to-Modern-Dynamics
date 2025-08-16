% replicator equation
% 3-10-12

function repeq

N = 8;
asymm = 1;      % 1 = zero diag (replicator eqn)   2 = zero trace (autocatylitic model)   3 = random (but zero trace)   4 = winner take all   5 = hypercycle
phi0 = 0.00001;            % average fitness (positive number) damps oscillations
fac = 1;

displine('N = ',N)
displine('asymm = ',asymm)
displine('phi0 = ',phi0)

%h = newcolormap('fluorodark');
h = colormap(jet);
hg = [1 1 1] - colormap(gray);

tempx = rand(1,N);
%x0 = tempx/sum(tempx);  % initial populations
x0 = 1*(1/N)*ones(1,N) + 0.2;

node = makeER(N,1);
%node = makeSW(N,N/32,0.25);
%node = makeSF(N,N/32);
Adj = adjacency(node);
numclus = clusternum(node);
[N,e,n] = clusterstats(node);
displine('number of clusters = ',numclus)
displine('average degree = ',n)

if asymm == 1
    % Asymmetric payoff matrix with zero diagonals (replicator model)
    A = zeros(N,N);
    for yloop = 1:N
        for xloop = yloop + 1:N
            A(yloop,xloop) = 2*(0.5 - rand);
            A(xloop,yloop) = -A(yloop,xloop);
        end
    end
    
elseif asymm == 2
    % Asymmetric payoff matrix with zero trace (autocatylitic model)
    Atemp = zeros(N,N);
    for yloop = 1:N
        for xloop = yloop+1:N
            Atemp(yloop,xloop) = 2*(0.5 - rand);
            Atemp(xloop,yloop) = -Atemp(yloop,xloop);
        end
        Atemp(yloop,yloop) = 2*(0.5 - rand);
    end
    tr = trace(Atemp);
    A = Atemp;
    
    for yloop = 1:N
        A(yloop,yloop) = Atemp(yloop,yloop) - tr/N;
    end
    
elseif asymm == 3
    % No symmetry with zero trace
    Atemp = zeros(N,N);
    for yloop = 1:N
        for xloop = 1:N
            Atemp(yloop,xloop) = 2*(0.5 - rand);
        end
    end
    tr = trace(Atemp);
    A = Atemp;
    for yloop = 1:N
        A(yloop,yloop) = Atemp(yloop,yloop) - tr/N;
    end
    
    
elseif asymm == 4
    % Alternating positive/negative payoff matrix with zero diagonals (winner take all model)
    A = zeros(N,N);
    for yloop = 1:N-1
        xloop = yloop + 1;
        A(yloop,xloop) = odd(xloop)*abs(randn)-even(xloop)*abs(randn);
        A(xloop,yloop) = -A(yloop,xloop);
    end
    
elseif asymm == 5
    % hypercycle
    A = zeros(N,N);
    for yloop = 2:N
        A(yloop,yloop-1) = 1 + 0.0*rand;
    end
    A(1,N) = 1 + 0.01*rand;
    
    
end % end if asymm

%keyboard

E = eye(N,N);
A = fac*(A.*Adj + E.*A);

%keyboard

figure(1)
imagesc(A);
colormap(h)
colorbar
title('Payoff Matrix')

tspan = [1 1000];
[t,x] = ode45(@f5,tspan,x0);

[sy,sx] = size(x);

% fitness
xend = x(sy,:)';
fit = A*xend;

avgfit = fit'*xend;

pop = sum(x,2);
av = mean(mean(x));
displine('population = ',mean(pop))
displine('av pop =', mean(mean(x)));

% How many non-zero?
cnt = 0;
for loop = 1:N
    if mean(x(sy-50:sy,loop),1) > av/20
        cnt = cnt + 1;
    end
end
displine('cnt = ',cnt)
displine('avg fitness = ',avgfit)
% xend
% fit
% A

% Average max slope?
% for loop = 1:N
%     mx = max(x(200:sy,loop));
%     deriv(:,loop) = diff(x(200:sy,loop));
%     freq(loop) = mean(abs(deriv(:,loop)))/mx;
% end
% mnfreq = mean(freq);
% displine('mean frequency = ',mnfreq)

figure(2)
for loop = 1:N
    %plot(t,real(log(x(:,loop))),'Color',h(round(loop*64/N),:),'LineWidth',1.25)
    %axis([0 1600 -10 0])
    plot(t,x(:,loop),'Color',h(round(loop*256/N),:),'LineWidth',1.25)
    hold on
end
hold off
title('Concentrations')

figure(3)
for loop = 1:N
    plot(t,real(log(x(:,loop))),'Color',h(round(loop*256/N),:),'LineWidth',1.25)
    axis([0 1000 -10 0])
    %plot(t,x(:,loop),'Color',h(round(loop*64/N),:),'LineWidth',1.25)
    hold on
end
hold off
title('Log Concentrations')

% figure(3)
% plot(x(:,1),x(:,N))
%
% figure(4)
% plot(t,x(:,1),t,(x(:,round(N/2))),t,x(:,N))

%keyboard


    function yd = f5(t,y)
        
        for iloop = 1:N
            ftemp = 0;
            for jloop = 1:N
                ftemp = ftemp + A(iloop,jloop)*y(jloop);
            end     % end jloop
            f(iloop) = ftemp;
        end     % end iloop
        
        phitemp = phi0;          % Can adjust this from 0 to 1 to stabilize (but Nth population is no longer independent)
        for loop = 1:N
            phitemp = phitemp + f(loop)*y(loop);
        end
        phi = phitemp;
        
        for loop = 1:N-1
            yd(loop) = y(loop)*(f(loop) - phi);
        end
        
        if abs(phi0) < 0.01             % average fitness maintained at zero
            yd(N) = y(N)*(f(N)-phi);
        else                                      % non-zero average fitness
            ydtemp = 0;
            for loop = 1:N-1
                ydtemp = ydtemp - yd(loop);
            end
            yd(N) = ydtemp;
        end
        
        yd = yd';
        
        
    end     % end f5


end     % end repeq


