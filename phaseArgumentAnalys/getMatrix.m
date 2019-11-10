function [phaseMatrix, prePhaseMatrix, numenatorMatrix, denumenatorMatrix] = GetMatrix(typeFilter, PeakData, FLAG )

global N;
global ws;
TYPE = typeFilter; 
for i = 1:N
    switch TYPE
        case 1
            [phase, prePhase, num, denum] = butterArguments(ws(i,:), FLAG);
        case 2
            [phase, prePhase, num, denum] = ch1Arguments(ws(i,:),PeakData(1), FLAG);
        case 3
            [phase, prePhase, num, denum] = ch2Arguments(ws(i,:),PeakData(2), FLAG);
        case 4
            [phase, prePhase, num, denum] = ellipArguments(ws(i,:),PeakData, FLAG);
        otherwise
            error("otherwise Switch/case in GetMatrix.m");
    end
    phaseColumns(:,i) = phase;
    preColumns(:,i) =  prePhase;
    numColumns(:,i) =   num;
    denumColumns(:,i) = denum;
    
end

phaseMatrix = phaseColumns;
prePhaseMatrix= preColumns;
numenatorMatrix= numColumns; 
denumenatorMatrix = denumColumns;

end

