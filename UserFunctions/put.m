% function newstack = put(element,oldstack)
% called by subcluster.m

function newstack = put(element,oldstack)

[dum,sz] = size(element);

newstack = oldstack;
oldn = oldstack.top;
newn = oldn+1;
newstack.data(newn:newn+sz-1) = element(1:sz);
newstack.top = oldn + sz;

end



