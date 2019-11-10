clear all; 
set(0,'DefaultAxesFontSize',14,'DefaultAxesFontName','Calibri');

global N;
global points; points = 500;
global ws; 
%            left                   centre                 right
%               _____________________________________________ 
%              |                                             |
%              |                                             |
%              |                                             |
%______________|_____________________________________________|_____________
%             0.2                  diapason                 0.8
leftRange = 0.2;
rightRange = 0.8;
step = 0.01;

ws = sortByDiff(nchoosek((leftRange:step:rightRange),2));%from 0.2 to 0.8 with step 0.05 Count = 78;
str = ws;
N = size(ws,1);
ws = filtRange(ws,0.1);
target = GetStrip([0.2, 0.3],'bs'); amplifier(points,size(ws,1)) = 0; phase(points,size(ws,1)) = 0;
for i = 1: size(ws,1)
    
    [a, b, c] = GetCh2(ws(i,:),7, 'bandpass');
    amplifier(:,i) = a;
    phase(:,i) = c;
end

figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]); hold on;
subplot(2,1,1);
plot(linspace(0, 1 - (1/points), points), amplifier);
title(strcat('filter amplifiers in range 0.2 - 0.8 with step -', num2str(step)));
grid;
subplot(2,1,2);
plot(linspace(0, 1 - (1/points), points), phase);
title(strcat('filter phases in range 0.2 - 0.8', num2str(step)));
grid;

%% get 3 target points, indexes: 1 - left point, 2 - centre point, 3 - right
for i = 1: size(ws,1)
   targetPoints(i,2) = GetCentrePoint(amplifier(:,i), "bandpass"); 
   targetPoints(i,1) = GetPoints(linspace(0, 1 - (1/points), points), ws (i,1));
   targetPoints(i,3) = GetPoints(linspace(0, 1 - (1/points), points), ws(i,2));
   local = phase(:,i);
   targetPoints(i,4) = GetPoints(local(11:points), max(local(11:points)))+10;
   targetPoints(i,5) = GetPoints(local(11:points), min(local(11:points)))+10;
end
%% get values
%amplifier
for i = 1: size(ws,1)
    for j = 1: size(targetPoints,2)
       ampValues(i,j) = amplifier(targetPoints(i,j),i);
       phaseValues(i,j) = phase(targetPoints(i,j),i);
    end
end
figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]);
plot(phaseValues(:,1))
title(strcat('left freq for all range'));
grid;

figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]);
plot(phaseValues(:,3))
title(strcat('right freq for all range'));
grid;
%%plot max/min
%figure;
%plot(phaseValues(:,4))
%figure;
%plot(phaseValues(:,5))
%%
left = phaseValues(:,1);
right = phaseValues(:,3);
C = 1; F = 1;
for i =1: size(phaseValues,1)
    
   if left(i) < 0
       targetLeft(C) = left(i);
       targetLeftIndexes(C) = i;
       C = C + 1;
   end
   if right(i) > 0
       targetRight(F) = right(i);
       targetRightIndexes(F) = i;
       F = F + 1;
   end
end
figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]);
subplot(2,1,1);
plot(linspace(0, 1 - (1/points), points),amplifier(:,targetLeftIndexes));
title(strcat('amplifier for left freq'));
grid;
subplot(2,1,2);
plot(linspace(0, 1 - (1/points), points),phase(:,targetLeftIndexes));
title(strcat('phase for right freq'));
grid;
figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]);
subplot(2,1,1);
plot(linspace(0, 1 - (1/points), points),amplifier(:,targetRightIndexes));
title(strcat('amplifier for right freq'));
grid;
subplot(2,1,2);
plot(linspace(0, 1 - (1/points), points),phase(:,targetRightIndexes));
title(strcat('aphase for right freq'));
grid;

transferedFunctionsLeft = ws(targetLeftIndexes,:);
transferedFunctionsRight = ws(targetRightIndexes,:);

widthLeft = (transferedFunctionsLeft(:,2) - transferedFunctionsLeft(:,1));
widthRight = transferedFunctionsRight(:,2) - transferedFunctionsRight(:,1);

figure
subplot(2,1,1);
plot(widthLeft);
subplot(2,1,2);
plot(widthRight);
targetWidth = unique(roundn([widthLeft, widthRight],-10));
targetWidth = [targetWidth', max(targetWidth) + min(targetWidth)];

 
for i = 1: length(targetWidth)
    targetWidth(i)
    localws = filtRange(str,targetWidth(i));
    clear localAmpl; clear localPhase;
    localAmpl(points,size(localws,1)) = 0; localPhase(points,size(localws,1)) = 0;
    
    for j = 1: size(localws,1)
    
        [a, b, c] = GetCh2(localws(j,:),7, 'bandpass');
        localAmpl(:,j) = a;
         localPhase(:,j) = c;
    end
    %figure; plot(linspace(0, 1 - (1/points), points), localAmpl);
clear ampValues; clear phaseValues; clear targetPoints;
    for j = 1: size(localws,1)
   targetPoints(j,1) = GetPoints(linspace(0, 1 - (1/points), points), localws (j,1));
   targetPoints(j,2) = GetPoints(linspace(0, 1 - (1/points), points), localws(j,2));
    end
    for z = 1: size(localws,1)
     for j = 1: size(targetPoints,2)
         ampValues(z,j) = localAmpl(targetPoints(z,j),z);
         phaseValues(z,j) = localPhase(targetPoints(z,j),z);
     end
    end
    figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]);
    subplot(2,1,1);
    plot(phaseValues(:,1));
    title(strcat('left values for all filters in range 0.2 - 0.8 with width=', num2str(targetWidth(i))));
    grid;
    subplot(2,1,2);
    plot(phaseValues(:,2));
    title(strcat('right values for all filters in range 0.2 - 0.8 with width=', num2str(targetWidth(i))));
    grid;
end
