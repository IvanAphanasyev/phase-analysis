clear all;
rs = [5,7, 10,15,20,30,40,50,60];
points = 1000;
ws = linspace(0.05,0.95,91); % step 0.01
flag = 'low'
figure; hold on; 

    five = -phases(rs(1), ws, flag, points);
    seven = -phases(rs(2), ws, flag, points);
    ten = -phases(rs(3), ws, flag, points);
    fifteen = -phases(rs(4), ws, flag, points);
    twenty =  -phases(rs(5), ws, flag, points);
    thirdy =  -phases(rs(6), ws, flag, points);
    forty = -phases(rs(7), ws, flag, points);
    fifty = -phases(rs(8), ws, flag, points);
    sixty = -phases(rs(9), ws, flag, points);
   

function [ph] = phases(rs,ws, flag, points)
    for rp = 1:(rs - 1)
       for j = 1: length(ws)
            fc = ws(j);
           phaseValue(j) = phaseValueOnFc(fc, rp, rs, flag, points);
       end
        means(rp) =   mean(phaseValue);
    end
    plot(means);
    ph = means;
end

function [ ph] = ellipPh(fc, rp,rs, flag, points)

[alb,blb] = ellip(2,rp,rs,fc,flag);

[hl,w] = freqz(alb,blb,points);
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
ph = F2;
end
function [phaseFc] = phaseValueOnFc(fc, rp, rs, flag, points)
    [phase] = ellipPh(fc, rp, rs, flag, points);
     w  = linspace(0, 1 - (1/points), points);
     index = indexOf(w, fc);
     
     phaseFc = phase(index);
           
end
function [index] = indexOf(x, value)
acc = -10;
roundX = roundn(x, acc);
roundValue = roundn(value,acc);
index = find(roundX == roundValue);
end
