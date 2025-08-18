% function y = heaviside0(x)
% y = 0 at x = 0

function y = heaviside0(x)
[sy, sx] = size(x);

y = 0;
if (sx==0)&&(sy==0)
    y = 0;
end

for yloop = 1:sy
    for xloop = 1:sx
        if x(yloop,xloop)<0
            y(yloop,xloop) = 0;
        elseif x(yloop,xloop) == 0
            y(yloop,xloop) = 0;
        elseif x(yloop,xloop) > 0
            y(yloop,xloop) = 1;
        end
    end
end
