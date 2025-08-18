% function y = rowvec(a)
% guarantees/converts a vector as a row vector

function y = rowvec(a)

[sy, sx] = size(a);

if sy == 1
    y = a;
elseif sx == 1
    y = a';
else
    y = a;
    %disp('a is not a vector (from rowvec.m)')
end
