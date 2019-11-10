%tryFunc FNCHBT
function [endPhase, preEndPhase, numenator, denumenator] = GetButter(Fc, FLAG)
global points;

    [alb,blb] = butter(2,Fc(1),FLAG);

[hl,w] = freqz(alb,blb,points);
%Calculating F2
for i=1:length(w)
    CF1(i)=(blb(2)*(alb(1)-alb(3))-alb(2)*(1-blb(3)))*sin(w(i));
    CF2(i)=(alb(1)*blb(3)-alb(3))*sin(2*w(i));
    IF(i)=CF1(i)+CF2(i);
    ZF1(i)=alb(1)+alb(2)*blb(2)+alb(3)*blb(3);
    ZF2(i)=(blb(2)*(alb(1)+alb(3))+alb(2)*(1+blb(3)))*cos(w(i));
    ZF3(i)=(alb(1)*blb(3)+alb(3))*cos(2*w(i));
    RF(i)=ZF1(i)+ZF2(i)+ZF3(i);
    preF2(i) = IF(i)/RF(i);
    F2(i)=atan2(IF(i),RF(i));  
end

endPhase = F2;
preEndPhase = preF2;
numenator = IF;
denumenator = RF;

end
    