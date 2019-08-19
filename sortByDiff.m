function [sorted] = sortByDiff(ws)

diff = ws(:,2) - ws(:,1);
sdiff(2,2) = 0;
for i = 1: length(diff)
   min_ = min(diff);
   point(i) = GetPoints(diff,min_);
   sdiff(i,:) = ws(point(i),:);
   diff(point) = max(diff) + 1;
end
sorted = sdiff;
end

