function [f] = GetStrip(args, flag)

    if flag == "bs"
        local = nchoosek((0.2:0.05:0.8),2);
        q = 0;
        for i = 1:size(local,1)
            if args(1) == roundn(local(i,1),-4) && args(2) == roundn(local(i,2),-4)
                 q = i; 
            end
        end
    elseif flag == "lh"
        N = 91;
        local = linspace(0.05,0.95,N); 
        q = 0;
        for i = 1:N
            if args(1) == roundn(local(i), -4)
                q = i;
            end
        end
    else
       error("Invalid input flag in function GetStrip"); 
    end
    f = q;
end

