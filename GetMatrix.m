function [Out_Ampl, Out_Pha, Out_F2] = GetMatrix(typeFilter, PeakData, FLAG )
%UNTITLED Summary of this function goes here
global N;
global ws;
%   Detailed explanation goes here
    %Boxed to global ws
    %if FLAG == "bandpass" || FLAG == "stop"
    %       ws = nchoosek((0.2:0.05:0.8),2);
       % N = size(ws,1);
    %end

    %if FLAG == "low" || FLAG == "high"
     %     ws = linspace(0.05,0.95,N)';
    %end

TYPE = typeFilter; %type of called function
for i = 1:N
    switch TYPE
        case 1
            [a, b, c] = GetButter(ws(i,:), FLAG);
        case 2
            [a, b, c] = GetCh1(ws(i,:),PeakData(1), FLAG);
        case 3
            [a, b, c] = GetCh2(ws(i,:),PeakData(2), FLAG);
        case 4
            [a, b, c] = GetEllip(ws(i,:),PeakData, FLAG);
        otherwise
            error("otherwise Switch/case in GetMatrix.m");
    end
    Ampl(:,i) = a;
    Pha(:,i) =  b;
    F2(:,i) =   c;
end


Out_Ampl = Ampl;
Out_Pha = Pha;
Out_F2 = F2;

end

