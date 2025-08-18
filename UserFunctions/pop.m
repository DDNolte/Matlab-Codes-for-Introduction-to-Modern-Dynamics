function [newstack,element] = pop(oldstack)

newstack = oldstack;
oldn = oldstack.top;
element = oldstack.data(oldn);
newn = oldn-1;
newstack.top = newn;
newstack.data(oldn) = [];

end


