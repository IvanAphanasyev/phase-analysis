function [returned] = GetCentrePoint(Ampl, string)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
mid = 0;
switch string
    case "bandpass"
        max_ = max(Ampl);
        for i = 1:length(Ampl)
            if Ampl(i) == max_
               mid = i; 
            end
        end
    case "stop"
        min_ = min(Ampl);
        for i = 1:length(Ampl)
           if  Ampl(i) == min_
              mid = i; 
           end
        end
    otherwise
        error("Otherwise in switch case in GetCentrePoint");
end
returned = mid;
end

