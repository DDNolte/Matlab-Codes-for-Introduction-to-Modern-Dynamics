% function y = heaviside1(x)
% y = 1 at x = 0

function y = heaviside1(x)
[sy, sx] = size(x);
y = 0;
for yloop = 1:sy
    for xloop = 1:sx
        
        if x(yloop,xloop)<0
            y(yloop,xloop) = 0;
        elseif x(yloop,xloop) == 0
            y(yloop,xloop) = 1;
        elseif x(yloop,xloop) > 0
            y(yloop,xloop) = 1;
        end
    end
end
