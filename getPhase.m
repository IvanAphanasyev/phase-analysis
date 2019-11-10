function [value] = getPhase(type, filt, pulsation)

switch type
    case 1
        switch filt
            case "low"
                x = -pi/2;
            case "high"
                x = pi/2;
        end
    case 2
        rp = pulsation(1);
        switch filt
            case "low"
                x = -tanh(0.0792*rp+0.4521)*pi;
                x
            case "high"
                x = tanh(0.0792*rp+0.4521)*pi;
        end
    case 3
        rs = pulsation(2);
        switch filt
            case "low"
                x = -tanh(0.2*rs.^(0.57))*pi;
                
            case "high"
                x = tanh(0.2*rs.^(0.57))*pi;
        end
    otherwise
        x = 0;
end
value = x;
end

