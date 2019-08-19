function [aph, dph] = PassStopPhs(rpMassive, type, str)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

global N;
global ws;
lN = N;

Mid = 0;
switch type
    case 1
        SPoint = 1/sqrt(2);
        for i = 1:lN
           [a,b,c] = GetButter(ws(i,:), str);
           FcPoint(i,:) = GetPoints(a,SPoint);
           Mid(i) = GetCentrePoint(a,str);
           for j = 1:size(FcPoint,2)
              Aph(i,j) = b(FcPoint(i,j));
              Dph(i,j) = c(FcPoint(i,j));
           end
           mA(i) = b(Mid(i));
           mD(i) = c(Mid(i));
        end
        Aph(:,size(Aph,2) + 1) = mA;
        Dph(:,size(Dph,2) + 1) = mD;
        
        out1 = Aph;
        out2 = Dph;
    case 2
        for z = 1:length(rpMassive)
            SPoint = 1/(sqrt(10^(0.1*rpMassive(z))));
            for i = 1:lN
                 [a,b,c] = GetCh1(ws(i,:), rpMassive(z), str);
                 FcPoint(i,:) = GetPoints(a,SPoint);
                 Mid(i) = GetCentrePoint(a,str);
                 for j = 1:size(FcPoint,2)
                      Aph(i,j) = b(FcPoint(i,j));
                      Dph(i,j) = c(FcPoint(i,j));
                 end
                 mA(i) = b(Mid(i));
                 mD(i) = c(Mid(i));
            end
            Aph(:,size(Aph,2) + 1,z) = mA;
            Dph(:,size(Dph,2) + 1,z) = mD;
        end
        out1 = Aph;
        out2 = Dph;
    case 3
        
    case 4
        
    otherwise
        error("otherwise on switchcase in PassStopPhs");

end

aph = out1;
dph = out2;
end

