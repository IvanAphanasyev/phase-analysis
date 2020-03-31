%MATLAB SCRIPT FOR GETTING DATA PHASE ARGUMETS, NUMERATOR, DENOMINATOR
%%constants
global N; N = 91; %Counts of Fc for low or high filts
global points; points = 10000; %Counts calulated points for filters any type
global ws; ws = linspace(0.05,0.95,N)';

w  = linspace(0, 1 - (1/points), points);% 
%% options
string = "low"; % low, high
typeFilter = 2;
% 1 - butter
% 2 - cheby1
% 3 - cheby2
% 4 - ellip%
draw = "all"; %all or target
peak_to_peak = [3 8];
[phase, prePhase, num, denum] = getMatrix(typeFilter, peak_to_peak, string);
  
if draw == "target"
targetF = 0.5;
target = getStrip(targetF);% What a graph will shown; 

 
%%find max point
 if max(prePhase(:,target)) > abs(min(prePhase(:,target)))
     maxValue = max(prePhase(:,target));
 else
     maxValue = abs(min(prePhase(:,target)));
 end
%% plot target
set(0,'DefaultAxesFontSize',14,'DefaultAxesFontName','Calibri');
 
%plot atan2
figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]);
subplot(2,1,1);
plot(w,(phase(:,target)));
phaseValue = getPhase(typeFilter,string,peak_to_peak);
if phaseValue ~= 0
    line([0 1],[phaseValue,phaseValue],'Color','green','LineStyle','--');
end
line([targetF targetF],[max(phase(:,target)),min(phase(:,target))],'Color','red');
title(strcat('phase with cut phase = ', num2str(targetF)));
grid;
%plot argument
subplot(2,1,2);
plot(w,(prePhase(:,target)));
title(strcat('argument for atan2, w = ', num2str(targetF)));
grid;


figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]);
%plot num
subplot(2,1,1);
plot(w,(num(:,target)));
line([targetF targetF],[max(num(:,target)),min(num(:,target))],'Color','red');
title(strcat('numenator for typefiter: ', num2str(typeFilter), 'with fc=',num2str(targetF)));
grid;

subplot(2,1,2);
%plot denum
plot(w,(denum(:,target)));
line([targetF targetF],[max(denum(:,target)),min(denum(:,target))],'Color','red');
title(strcat('denumenator for typefiter: ', num2str(typeFilter), 'with fc=',num2str(targetF)));
grid;

figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]);
%plot argument
subplot(3,1,1);
plot(w,(prePhase(:,target)));
title(strcat('argument for atan2, w = ', num2str(targetF)));
grid;

%plot atan2
subplot(3,1,2);
plot(w,(phase(:,target)));
if phaseValue ~= 0
    line([0 1],[phaseValue,phaseValue],'Color','green','LineStyle','--');
end
line([targetF targetF],[max(phase(:,target)),min(phase(:,target))],'Color','red');
title(strcat('phase with cut phase = ', num2str(targetF)));
grid;

atanPhase = atan(prePhase(:,target));
subplot(3,1,3);
%plot atan of argument
plot(w,atanPhase);
if phaseValue ~= 0
    line([0 1],[phaseValue,phaseValue],'Color','green','LineStyle','--');
end
line([targetF targetF],[max(atanPhase),min(atanPhase)],'Color','red');
title(strcat('atan1 for argument, w = ', num2str(targetF)));
grid;

end
if draw == "all"
  set(0,'DefaultAxesFontSize',14,'DefaultAxesFontName','Calibri');
  %plot phases
 figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]);
plot(w,(phase));
phaseValue = getPhase(typeFilter,string,peak_to_peak);
if phaseValue ~= 0
    line([0 1],[phaseValue,phaseValue],'Color','green','LineStyle','--');
end
title(strcat('phases for typefilter - ', num2str(typeFilter)));%
grid;

 %plot arguments
 figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]);
plot(w,(prePhase));
title(strcat('arguments for typefilter - ', num2str(typeFilter)));%
grid;

 %plot num
 figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]);
plot(w,(num));
title(strcat('numerators for typefilter - ', num2str(typeFilter)));%
grid;

 %plot denum
 figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]);
plot(w,(denum));
title(strcat('denumerators for typefilter - ', num2str(typeFilter)));%
grid;
end
