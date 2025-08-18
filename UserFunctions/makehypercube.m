% function node = makehypercube(B)
% B = bits  (2^B)


function node = makehypercube(B)

N = 2^B;

node(1).element = 1;
node(1).numlink = 0;
node(1).link = [];
node(1).val = dec2bin(0,B);

for yloop = 2:N
    node = addnode(yloop,node);
    node(yloop).val = dec2bin(yloop-1,B);
end

A = zeros(N,N);
for yloop = 1:N
    for xloop = yloop+1:N
        
        num1 = xloop - 1;
        num2 = yloop - 1;
                
        dis = hamming(num1,num2);
        if dis == 1
            A(yloop,xloop) = 1;
            node = addlink(node(yloop).element,node(xloop).element,node);
        end
    end
end

%node = adj2node(A);
