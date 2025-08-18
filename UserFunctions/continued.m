% a = continued(r,N)
% continued fraction of rational number r with N terms up to N = 38
% see also convergent.m

function a = continued(r,N)

rtmp = r;

for loop = 1:N
    
    tmp = fix(rtmp);
    if abs(rtmp - tmp) > 0
        rtmp = 1./(rtmp - tmp);
    else
        rtmp = 0;
    end
    
    a(loop) = tmp;
    
end