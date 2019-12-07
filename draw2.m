function [] = draw2(x, first,second, titleStr,xLabel, yLabel)


set(0,'DefaultAxesFontSize',14,'DefaultAxesFontName','Calibri');
 
figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]);
hold on;
plot(x,[first; second],'LineWidth',2);
title(titleStr);
legend({'matlab','equation'},'FontSize',12)
xlabel(xLabel,'FontSize',12);
ylabel(yLabel,'FontSize',12);
grid on;

end

