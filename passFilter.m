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

ws = sortByDiff(nchoosek((0.2:0.05:0.8),2));%from 0.2 to 0.8 with step 0.05 Count = 78;
N = size(ws,1);
target = GetStrip([0.2, 0.3],'bs'); amplifier(points,N) = 0; phase(points,N) = 0;
for i = 1: N
    [amplifier(:,i), b, phase(:,i)] = GetButter(ws(i,:), 'bandpass');
end
figure; hold on;
subplot(2,1,1);
plot(linspace(0, 1 - (1/points), points), amplifier);
subplot(2,1,2);
plot(linspace(0, 1 - (1/points), points), phase);

%% get 3 target points, indexes: 1 - left point, 2 - centre point, 3 - right
for i = 1: N
   targetPoints(i,2) = GetCentrePoint(amplifier(:,i), "bandpass"); 
   targetPoints(i,1) = GetPoints(linspace(0, 1 - (1/points), points), ws (i,1));
   targetPoints(i,3) = GetPoints(linspace(0, 1 - (1/points), points), ws(i,2));
end
%% get values
%amplifier
for i = 1: N
    for j = 1: size(targetPoints,2)
       ampValues(i,j) = amplifier(targetPoints(i,j),i);
       phaseValues(i,j) = phase(targetPoints(i,j),i);
    end
end
figure;
plot(phaseValues(:,1))
figure;
plot(phaseValues(:,3))
figure;
plot(phaseValues(:,2));