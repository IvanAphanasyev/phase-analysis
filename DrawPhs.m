function [means] = DrawPhs(Pha,flag,val)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
ws = linspace(0.05,0.95,91);
if(flag == 'wc')
set(0,'DefaultAxesFontSize',14,'DefaultAxesFontName','Calibri');
figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]);
plot(ws, Pha);
line([0 0], [0 -pi],'Color','Black');
title(strcat('const rs, variable wc => phi(wc, rs) = const, rs:', sprintf('%.0f',val)));
grid;
end

if(flag == 'rs')
    for i = 1:length(Pha)
        X(i) = i; 
    end
    set(0,'DefaultAxesFontSize',14,'DefaultAxesFontName','Calibri');
    figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]);
    stem(X,Pha);
    


for i = 1:length(Pha) - 1
   line([i (i+1)],[Pha(i) Pha(i+1)]); 
end
title(strcat('const wc, variable rs => phi(wc, rs) = variable, wc:', sprintf('%.2f',val)));
end
end

