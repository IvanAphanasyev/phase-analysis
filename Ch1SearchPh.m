function [Aphal,Dphal] = Ch1SearchPh(RpMassive,type,str)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
global N;
global ws;
global points;

FullValuesPha = zeros(length(RpMassive),N);
FullValuesF2= zeros(length(RpMassive),N);

switch type
    case 1
        for i = 1:N
           [a,b,c] = GetButter(ws(i,:),str);
           ValuePha(i) = b(5 * (points / 100) + (points/100 * (i - 1) + 1));
           ValueF2(i) = c(5 * (points / 100) + (points/100 * (i - 1) + 1));
        end
            FullValuesPha = ValuePha;
            FullValuesF2 = ValueF2;
    case 2
        for z = 1:length(RpMassive)
            for i = 1:N
                [a, b, c] = GetCh1(ws(i,:),RpMassive(z),str);
                 ValuePha(i) = b(5 * (points / 100) + (points/100 * (i - 1) + 1), 1);
                 ValueF2(i) = c(5 * (points / 100) + (points/100 * (i - 1) + 1), 1);
            end
            FullValuesPha(z,:) = ValuePha;
            FullValuesF2(z,:) = ValueF2;
        end
        
    case 3
        for z = 1:length(RpMassive)
            for i = 1:N
                [a, b, c] = GetCh2(ws(i,:),RpMassive(z),str);
                 ValuePha(i) = b(5 * (points / 100) + (points/100 * (i - 1) + 1), 1);
                 ValueF2(i) = c(5 * (points / 100) + (points/100 * (i - 1) + 1), 1);
            end
            FullValuesPha(z,:) = ValuePha;
            FullValuesF2(z,:) = ValueF2;
        end
        
    case 4
    
        
end


Aphal =  FullValuesPha;
Dphal = FullValuesF2;
end

