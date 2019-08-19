function [localCalculatedAmp,localAmp,localPhase] = drawAmpAmpPhase(calculatedAmp,amp,phase,wsX,PtP,typefilter,string)
set(0,'DefaultAxesFontSize',14,'DefaultAxesFontName','Calibri');
global points;
w  = linspace(0, 1 - (1/points), points);% 
if string == "bandpass" || string == "stop"
    centre = GetCentrePoint(aml,string);
    centre = w(centre);
end

for i=1:length(w)
    if typefilter == 1
       amlP(i) = 1/sqrt(2);
       amlS(i) = 1/sqrt(2);
    else
       amlP(i) =  1/(sqrt(10^(0.1*PtP(2))));% 1 / sqrt(exp(0.230259*RP))
       amlS(i) = 1/(sqrt(10^(0.1*PtP(2))));
    end
end

for i=1:length(w)
    if string == "low"
        ButterPha(i) = 0;
    elseif string == "high"
        ButterPha(i) =  0;  
    elseif string == "bandpass"
        ButterPha(i) = 0;
    elseif string == "stop"
        ButterPha(i) = 0;
    end
end

figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]);
subplot(3,1,1);
P1 = plot(w,calculatedAmp,w,amlP,w,amlS);%
title('Calculated Amplifier abs(h)');
line([wsX(1) wsX(1)],[0 1],'Color','red');

if string == "bandpass" || string == "stop"
    line([centre centre], [0 1]);
    line([wsX(2) wsX(2)],[0 1],'Color','red');
end
grid;

subplot(3,1,2);
P2 = plot(w,amp,w,amlP,w,amlS);%
title('Amplifier from equation');
line([wsX(1) wsX(1)],[0 1],'Color','red');
if string == "bandpass" || string == "stop"
    line([centre centre], [0 1]);
    line([wsX(2) wsX(2)],[0 1],'Color','red');
end

grid ;

subplot(3,1,3);
P3 = plot(w,phase,w,ButterPha);
title('Phase from equation');
line([wsX(1) wsX(1)],[max(phase),min(phase)],'Color','red');
if string == "bandpass" || string == "stop"
    %(wsX(1) + wsX(2))/2;
    line([centre centre], [min(phase) max(phase)]);
    line([wsX(2) wsX(2)],[min(phase) max(phase)],'Color','red');
end
grid ;
V32 = {'-','-.'}';NameArray = {'LineStyle'};
V1 = {'-','-.','-.'}';
set(P3,NameArray,V32);
set(P2,NameArray,V1);
set(P1,NameArray,V1);
%ColorName = {'Color'}; ColorAtr = {'blue','yellow'}';
%set(P1,ColorName,ColorAtr);




localCalculatedAmp = calculatedAmp;
localAmp = amp;
localPhase = phase;
end

