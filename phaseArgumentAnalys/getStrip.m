function [f] = getStrip(args, flag)

   
        N = 91;
        local = linspace(0.05,0.95,N); 
        q = 0;
        for i = 1:N
            if args(1) == roundn(local(i), -4)
                q = i;
            end
        end
    
    f = q;
end

