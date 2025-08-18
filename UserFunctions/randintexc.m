% function y = randintexc(N,M,exclus,varargin)
% returns N random integers between 1 and M exclussively
% also excludes values in array exclus

function y = randintexc(N,M,exclus,varargin)

if N > M
    disp('Error(randintexc): Too many numbers')
    y = -1;
    return
end
if nargin == 3
    if N > M - length(exclus)
        if M > 1
            disp('Error(randintexc): Too many numbers')
        end
        y = -1;
        return
    end
end
if N == 0
    y = [];
    return
end

% r(1) = ceil(M*rand);

for nloop = 1:N
    
    testflag = 0;
    while testflag == 0
        
        temp = ceil(M*rand);
        flag = 0;
        for cntloop = 1:nloop-1
            if temp == r(cntloop)
                flag = 1;
            end
        end
        if nargin == 3
            for loop = 1:length(exclus)
                if temp == exclus(loop)
                    flag = 1;
                end
            end
        end
        
        if flag == 0
            r(nloop) = temp;
            testflag = 1;
        end
        
    end % end while
    
    
end

y = r;

