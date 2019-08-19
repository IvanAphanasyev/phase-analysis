%tryFunc FNCHBT
function [AMPL,PH,PH2] = GetButter(Fc, FLAG)
global points;
if FLAG == "bandpass" || FLAG == "stop"
    [alb,blb] = butter(2,[Fc(1) Fc(2)],FLAG);
elseif FLAG == "low" || FLAG == "high"
    [alb,blb] = butter(2,Fc(1),FLAG);
else
    error("Invalid string input flag getButter(low, high, bandpass, stop)");
end

[hl,w] = freqz(alb,blb,points);
aml = abs(hl);
phal = angle(hl);

%Calculating F2
for i=1:length(w)
    CF1(i)=(blb(2)*(alb(1)-alb(3))-alb(2)*(1-blb(3)))*sin(w(i));
    CF2(i)=(alb(1)*blb(3)-alb(3))*sin(2*w(i));
    IF(i)=CF1(i)+CF2(i);
    ZF1(i)=alb(1)+alb(2)*blb(2)+alb(3)*blb(3);
    ZF2(i)=(blb(2)*(alb(1)+alb(3))+alb(2)*(1+blb(3)))*cos(w(i));
    ZF3(i)=(alb(1)*blb(3)+alb(3))*cos(2*w(i));
    RF(i)=ZF1(i)+ZF2(i)+ZF3(i);
    F2(i)=atan2(IF(i),RF(i));    
end

AMPL = aml;
PH = phal;
PH2 = F2';
end
    