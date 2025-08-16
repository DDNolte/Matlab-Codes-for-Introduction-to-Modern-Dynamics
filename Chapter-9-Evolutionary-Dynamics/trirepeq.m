% replicator equation
% for N = 3 simplex
% See also simprepeq.m

function trirepeq

N = 3;
asymm = 3;      % 1 = zero diag (replicator eqn)   2 = zero trace (autocatylitic model)  3 = random (but zero trace)
phi0 = 0.0001;            % (0.001) average fitness (positive number) damps oscillations

displine('N = ',N)
displine('asymm = ',asymm)
displine('phi0 = ',phi0)

%h = newcolormap('fluorodark');
h = colormap(jet);


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
        for xloop = yloop +1:N
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
    
else
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
    
end % end if asymm

figure(1)
imagesc(A),colormap(jet),title('Payoff Matrix')
caxis([-1 1])
colorbar
set(gcf,'Color','white')

M = 15; del = 1/M; eps = 1e-2;      % 20
for xloop = 1:M+1
    tempx(1) = del*(xloop-1) + sign(M-xloop)*eps;
    for yloop = 1:M+1-xloop
        tempx(2) = del*(yloop-1) + sign(M-xloop)*eps;
        tempx(3) = 1 - tempx(1) - tempx(2);
        
        x0 = tempx/sum(tempx);% initial populations
        
        tspan = 0:.1:70;
        [t,x] = ode45(@f5,tspan,x0);
        
        [sy,sx] = size(x);
        
        pop = sum(x,2);
        av = mean(mean(x));
        %         displine('population = ',mean(pop))
        %         displine('av pop =', mean(mean(x)));
        
        %         % How many non-zero?
        %         cnt = 0;
        %         for loop = 1:N
        %             if mean(x(sy-100:sy,loop),1) > av/20
        %                 cnt = cnt + 1;
        %             end
        %         end
        %         displine('cnt = ',cnt)
        
        
        %         figure(2)
        %         for loop = 1:N
        %             plot(t,real(log(x(:,loop))),'Color',h(round(loop*64/N),:),'LineWidth',1.25)
        %             axis([0 1600 -10 0])
        %             %plot(t,x(:,loop),'k','LineWidth',1.25)
        %             hold on
        %         end
        %         hold off
        
        figure(2)
        tripartite(x(:,1),x(:,2),x(:,3))
        axis([0 1 0 0.867])
        set(gcf,'Color','white')
        axis off
        hold on
        
    end
end

text(-0.12,0.9,num2str(A(1,1)));text(0,0.9,num2str(A(1,2)));text(.12,0.9,num2str(A(1,3)));
text(-0.12,0.8,num2str(A(2,1)));text(0,0.8,num2str(A(2,2)));text(.12,0.8,num2str(A(2,3)));
text(-0.12,0.7,num2str(A(3,1)));text(0,0.7,num2str(A(3,2)));text(.12,0.7,num2str(A(3,3)));

hold off

tspan = 0:.1:200;
[t,x] = ode45(@f5,tspan,[0.25 0.35 0.4]);

figure(3)
plot(t,x)

%print -dtiff -r600 triexample


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


