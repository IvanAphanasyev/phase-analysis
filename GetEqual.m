function [OutPut] = GetEqual(first,second)


rows = size(first,1);
colums = size(first,2);
OutPut = zeros(rows,colums);

for i = 1:rows 
    for j = 1:colums
        if first(i,j) == second(i,j)
            OutPut(i,j) = 1;
        else 
            OutPut(i,j) = 0;
        end        
    end
end

end

