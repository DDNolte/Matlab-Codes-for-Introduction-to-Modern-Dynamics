%function repmut
% 12/08/14

function repmut

clear
format compact

N = 63;     % 64
p = 0.5;

mutype = 1;     % 0 = Hamming   1 = rand
pay = 1;        % 0 = Hamming   1 = 1/sqrt(N) 
ep = 0.5;      % average mutation rate: 0.1 to 0.01 typical  (0.4835)

%%%%% Set original population
x0temp = rand(1,N);    % Initial population
sx = sum(x0temp);
y0 = x0temp/sx;
Pop0 = sum(y0);


%%%%% Set Adjacency

%node = makeglobal(N);
%node = makeER(N,0.25);       % 0.5     0.25 
%node = makeSF(N,6);       % 12         6
node = makeSW(N,7,0.125);   % 15,0.5    7,0.5
[Adj,degree,Lap] = adjacency(node);
[N0,e,avgdegree,maxdegree,mindegree,~,~,~,~,~,meandistance,diam] = clusterstats(node)


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
    mnQsum = mean(Qsum);
    
    % Normalize mutation among species
    for yloop = 1:N
        for xloop = 1:N
            Q(yloop,xloop) = Qtemp(yloop,xloop)/Qsum(xloop);
            %Q(yloop,xloop) = Qtemp(yloop,xloop)/mnQsum;
        end
    end
    
elseif mutype == 1  
    S = stochasticmatrix(N);
    Stemp = S - diag(diag(S));
    Qtemp = ep*Stemp;
    sm = sum(Qtemp,2)';
    Q = Qtemp + diag(ones(1,N) - sm);
end


figure(1)
imagesc(Q)
title('Mutation Matrix')
colormap(jet)

%%%%%%% Set payoff matrix
if pay == 1
    payoff = zeros(N,N);
    for yloop = 1:N
        payoff(yloop,yloop) = 1;
        for xloop = yloop + 1:N
            payoff(yloop,xloop) = p;
            payoff(xloop,yloop) = p;
            %payoff(yloop,xloop) = p*2*(0.5 - randbin(1,0.5));
            %payoff(xloop,yloop) = payoff(yloop,xloop);
            %payoff(xloop,yloop) = -payoff(yloop,xloop);
            payoff(1,N) = 1;
            payoff(N,1) = 1;
% %             payoff(1,N-1) = 1;
% %             payoff(N-1,1) = 1;
%             payoff(2,N-1) = 1;
%             payoff(N-1,2) = 1;
        end
    end
elseif pay == 0
    payoff = zerodiag(exp(-1*H));
end


figure(2)
imagesc(payoff)
title('Payoff Matrix')
colormap(jet)


% Run time evolution
tspan = [0 4000];
[t,x] = ode45(@quasispec,tspan,y0);

Pop0
[sz,dum] = size(t);
Popend = sum(x(sz,:))

for loop = 1:N
    fit(loop) = sum(payoff(:,loop)'.*x(sz,:));
end

phistar = sum(fit.*x(sz,:))       % final average fitness

xend = x(sz,:)
sortxend = sort(xend,'descend');
coher = sum(sortxend(1:2))

figure(3)
clf
h = colormap(lines);
for loop = 1:N
    plot(t,x(:,loop),'Color',h(round(loop*64/N),:),'LineWidth',1.25)
    hold on
end
hold off

figure(4)
clf
for loop = 1:N
    semilogx(t,x(:,loop),'Color',h(round(loop*64/N),:),'LineWidth',1.25)
    hold on
end
hold off

figure(5)
clf
for loop = 1:N
    semilogy(t,x(:,loop),'Color',h(round(loop*64/N),:),'LineWidth',1.25)
    hold on
end
hold off

figure(6)
clf
for loop = 1:N
    loglog(t,x(:,loop),'Color',h(round(loop*64/N),:),'LineWidth',1.25)
    hold on
end
hold off

%keyboard

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    function yd = quasispec(~,y)
        
        for floop = 1:N
            f(floop) = sum(payoff(:,floop).*y);
        end
        
        Connect = Adj + eye(N);
        
        % Transition matrix
        for yyloop = 1:N
            for xxloop = 1:N
                W(yyloop,xxloop) = f(yyloop)*(Connect(yyloop,xxloop)*Q(yyloop,xxloop));
            end
        end
        
        phi = sum(f'.*y);   % Average fitness of population
        
        yd = W*y - phi*y;
        
        %keyboard
        
        
    end     % end quasispec



end
