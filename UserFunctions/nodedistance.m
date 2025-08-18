% function y = nodedistance(node,a,b)
% created 6/10/24
% See also: nodedistance.m tree2distance.m FindLeaf.m FindRoot.m


function y = nodedistance(node,a,b)

Path1 = FindRoot(node,a);
Path2 = FindRoot(node,b);

common = min(intersect(Path1,Path2));

w1 = where(Path1,common);
w2 = where(Path2,common);

y = (w1-1) + (w2-1);




end