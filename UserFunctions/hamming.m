%function y = hamming(x,y)
%Hamming binary distance between non-negative decimal integers x and y

function hsum = hamming(x,y)

sx = ceil(log2(x+1));
sy = ceil(log2(y+1));
sz = max(sx,sy);

xb = dec2bin(x);
yb = dec2bin(y);

z = bitxor(x,y);

sum = 0;
for loop = 1:sz
    sum = sum + bitget(z,loop);
end

hsum = sum;