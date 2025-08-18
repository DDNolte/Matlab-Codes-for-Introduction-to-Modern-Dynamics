% function y = randbin2(M,N,thresh)
% random binary matrix of length M by N
% thresh between 0 and 1
% p(1) = 1-thresh
% p(0) = thresh

function y = randbin(M,N,thresh)

temp = rand(M,N);
y = zeros(M,N);
for mloop = 1:M
    for nloop = 1:N
        if temp(mloop,nloop) > thresh
            y(mloop,nloop) = 1;
        end
    end
end

