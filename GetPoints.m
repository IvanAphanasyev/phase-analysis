function [point] = GetPoints(aml,sp)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
C = 1; %Count
acc = -10;
for j = 1: length(aml)
    if roundn(aml(j),acc) ==  roundn(sp,acc)
        localP(C) = j;
        C = C + 1;
    end
end

point = localP(1);
end

