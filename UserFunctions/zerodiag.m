% [B, D] = zerodiag(A,altmin,varargin)
% Sets diagonal terms to zero
% D is the diagonal values

function [B, D] = zerodiag(A,altmin,varargin)

[sy,sx] = size(A);
B = A;
if sy~=sx
    disp('in zerodiag not square');
    B = A;
else
    if nargin == 1
        for loop = 1:sx
            B(loop,loop) = 0;
            D(loop) = A(loop,loop);
        end
    else
        for loop = 1:sx
            B(loop,loop) = altmin;
            D(loop) = A(loop,loop);
        end
    end
end