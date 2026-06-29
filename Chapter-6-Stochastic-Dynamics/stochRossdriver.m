% stochendriver.m
% for ensembles
% Calls Rossstoch.m 


clear
close all

global escape_count
escape_count = 0;

numbins = 200;
A = zeros(numbins+40,numbins+40);


for enloop = 1:50
    displine('enloop = ',enloop)
    
    [X,Y,Z,T] = Rossstoch;
    
    [dum,sz] = size(T);
    for tloop = 1:sz
        indx = round(110 + (numbins/2)*X(tloop)/15);
        indy = round(140 + (numbins/2)*Y(tloop)/15);
        if (indx>0)&&(indx<(numbins+40))
            if (indy>0)&&(indy<(numbins+40))
                A(indy,indx) = A(indy,indx) + 1;
            end
        end
    end
    
    figure(20)
    pcolor(sqrt(A))
    shading interp
    %pcolor(A)
    %shading interp
    h = newcolormap('graycolor');
    colormap(h)
    colorbar
    
    
end

displine('escape_count = ',escape_count)


    figure(21)
   imagesc(sqrt(A))
%     pcolor(sqrt(A))
%     shading interp
    h = newcolormap('graycolor');
    colormap(h)
    colorbar
