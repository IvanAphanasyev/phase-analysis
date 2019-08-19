function [reverse] = reversePoints(arr)
global points;
metric = linspace(0, 1 - (1/points), points);
reverse = zeros(size(arr,1),size(arr,2));
for i = 1: size(arr,1)
   for j = 1: size(arr,2)
       reverse(i,j) = metric(arr(i,j));
   end
end

end

