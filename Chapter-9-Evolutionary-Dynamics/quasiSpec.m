% Quasispecies simulation.  Includes mutation with Hamming distance.

function quasiSpec

close all
clear all
global W
h = colormap(lines);

randpop = 0;    % 0) = spike population; 1) = random population
mutype = 0;     % 0) = Hamming; 1) = rand
fitype = 0;     % 0) = Hamming; 1) = 2-peak; 2) = rand+gauss;  3) freq-dep

B = 7;    % 7
N = 2^B;         % size of mutation space (64)
lam = 1;        % Hamming fitness only
gamma = 1;    % freq-dep fitness (payoff matrix only)
relran = 0.025;      % relative random contrib to fitness
time_expand = 50;

ep = 0.1;      % average mutation rate: 0.1 to 0.01 typical  (0.4835) (0.0290)


%%%%% Set original population
if randpop == 1
    rng(0);
    x0temp = rand(1,N);    % Initial population
    sx = sum(x0temp);
    x0 = x0temp/sx;
else 
    x0 = zeros(1,N);
    x0(1) = 0.667; x0(2) = 0.333;
end

Pop0 = sum(x0);


%%%%%% Set Hamming distance
for yloop = 1:N
    for xloop = 1:N
        H(yloop,xloop) = hamming(yloop-1,xloop-1);
    end
end



%%%%%%% Set Mutation matrix
if mutype == 0
    Qtemp = 1./(1+H/ep);    %Mutation matrix on Hamming
    %Qtemp = exp(-H/(ep*50));
    Qsum = sum(Qtemp,2);
    
    % Normalize mutation among species
    for yloop = 1:N
        for xloop = 1:N
            Q(yloop,xloop) = Qtemp(yloop,xloop)/Qsum(xloop);
        end
    end
    
end
if mutype == 1  
    rng(0);
    S = stochasticmatrix(N);
    Stemp = S - diag(diag(S));
    Qtemp = ep*Stemp;
    sm = sum(Qtemp,2)';
    Q = Qtemp + diag(ones(1,N) - sm);
end


%keyboard


%%%%%%% Set fitness landscape

if fitype == 0      % Hamming
    x = 1:N;
    alpha = 84;
    ftemp = exp(-lam*H(alpha,:));   % Fitness landscape
    sf = sum(ftemp);
    f = ftemp/sf;
end
if fitype == 1      % double peak and rand
    rng(1);
    f = rand(1,N);
    x = 1:N;
    delg = 20;
    sig1 = 1;
    sig2 = 4;
    g1 = gaussprob(x,(N/2 - delg),sig1);
    g2 = 3*gaussprob(x,(N/2 + delg),sig2);
    ftemp = relran*f + g1 + g2;
    f = ftemp/sum(ftemp);
end
if fitype == 2      % rand + Gauss
    rng(0);
    f = rand(1,N);
    x = 1:N;
    ftemp = relran*f + gauss((x-N/2)/2);   % Fitness landscape
    f = ftemp/sum(ftemp);
end
if fitype == 3      % frequency-dependent Hamming
    avgdis = mean(mean(H));
    %payoff = exp(-gamma*(H - avgdis));    % payoff matrix
    %payoff = H.^2;
    %payoff = ones(size(H));
    %payoff = exp(-gamma*H);
    payoff = payoffmat(3,N);
end

%keyboard

% Run time evolution
tspan = [0 1000];     % 3000
[t,x] = ode45(@quasispec,tspan,x0);

Pop0
[sz,dum] = size(t);
Popend = sum(x(sz,:))

phistar = sum(f.*x(sz,:))       % final average fitness


figure(1)
%plot(f,'-')
semilogy(f,'-')
hold on
figure(1)
%plot(x(sz,:),'r')
semilogy(x(sz,:),'r')
hold off
legend('fitness','population')


figure(2)
for loop = 1:N
    semilogx(t,x(:,loop),'Color',h(round(loop*64/N),:),'LineWidth',1.25)
    hold on
end
hold off
set(gcf,'Color','white')
xlabel('Time','FontSize',14)
ylabel('Population','FontSize',14)
hh = gca;
set(hh,'FontSize',14)


figure(3)
for loop = 1:N
    plot(t,x(:,loop),'Color',h(round(loop*64/N),:))
    hold on
end
hold off

figure(4)
for loop = 1:N
    loglog(t,x(:,loop),'Color',h(round(loop*64/N),:))
    hold on
end
hold off

figure(5)
for loop = 1:N
    semilogy(t,x(:,loop),'Color',h(round(loop*64/N),:))
    hold on
end
hold off



% Eigenvalues

[V,D] = eig(W);

max(D(:,1))

figure(6)
%semilogy(abs(V(:,1)))
plot((abs(V(:,1))))
title('Eigenvector')

disp(' ')


if fitype == 1
    xlo = N/2 - delg - 2*sig1;
    xhi = N/2 - delg + 2*sig1;
    fit44 = sum(f(xlo:xhi))
    pop44 = sum(x(sz,xlo:xhi))/Popend
    xlo = N/2 + delg - 2*sig2;
    xhi = N/2 + delg + 2*sig2;
    fit84 = sum(f(xlo:xhi))
    pop84 = sum(x(sz,xlo:xhi))/Popend
    
end



    function yd = quasispec(t,y)
        
        if fitype == 3      % frequency-dependent Hamming
            for loop = 1:N
                ftemp(loop) = sum(payoff(:,loop).*y);
            end
            f = time_expand*ftemp/sum(ftemp);
        end
        
        
        % Transition matrix
        for yloop = 1:N
            for xloop = 1:N
                W(yloop,xloop) = f(yloop)*Q(yloop,xloop);
            end
        end
        
        phi = sum(f'.*y);   % Average fitness of population
        
        yd = W*y - phi*y;
        
        
    end     % end quasispec




end     % end quasiSpec

