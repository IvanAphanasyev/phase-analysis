function [returned] = AnalysEllipQ(StartRP, RangeRP, RangeRS,FLAG)

N = 91;
ws = linspace(0.05,0.95,N);
 

for x = StartRP:StartRP + RangeRP - 1

    for y = x + 1:StartRP+RangeRS
        [Ampl, Pha, F2] = GetMatrix(N,4,[x y],FLAG);
           for i = 1:N
             ValuePha(i) = Pha(i+5, i);
             ValueF2(i) = F2(i+5, i);
            end
             FullValuesPha(y,:) = ValuePha;
             FullValuesF2(y,:) = ValueF2;
    end
    mPha = mean(FullValuesPha');
    mF2 = mean(FullValuesF2');
    RPRSPha(x,:) = mPha;
    RPRSF2(x,:) = mF2;
    FullValuesPha(:,:) = 0;
    FullValuesF2(:,:) = 0;
end
returned = RPRSPha;
end

