% maskbilevel.m
% function [y mask] = maskbilevel(A,lowcut,hicut,vallo,valhi)
% Assigns values vallo and valhi to outside of cuts
% mask is binary 1's where inside cutvalues

function [y mask] = maskbilevel(A,lowcut,hicut,vallo,valhi)

% slope = 0.00001*(hicut-lowcut);
%mtemp = clip(A,lowcut,hicut,slope);
mtemp = heaviside0(A-lowcut).*heaviside1(hicut-A);
y = A.*mtemp + valhi*heaviside1(A-hicut).*(1-mtemp) +  vallo*heaviside0(lowcut-A).*(1-mtemp);
mask = mtemp;

