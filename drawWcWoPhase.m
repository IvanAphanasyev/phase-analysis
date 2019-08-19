function [dw] = drawWcWoPhase(x,wc,wo,phaseWc,phaseWo, str,flag)
set(0,'DefaultAxesFontSize',14,'DefaultAxesFontName','Calibri');
figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]);
subplot(2,1,1);
dw = wo-wc';
plot(x,wc,x,wo,x,dw);
title(strcat('wc(wc), wo(wc), (wo-wc)(wc)',' ;', str));
grid;

subplot(2,1,2);
dw = wo-wc';
if flag == 'wc'
plot(wc,phaseWc,wc,phaseWo);
end
if flag == 'rs'
    plot(x,phaseWc,x,phaseWo);
end
title(strcat('phaseFc, phaceFo','; ', str));
grid;

end

