function [ret] = filtRange(ws,target)
c = 1;
 ret = [];
    for i =1:size(ws,1)
        local = ws(i,2) - ws(i,1);
        %roundn(local,-3)
        if roundn(local,-3) == roundn(target,-3)
            x = [ws(i,1), ws(i,2)];
                ret(c,:) = x;
                c=c+1;
        end
    end

end

