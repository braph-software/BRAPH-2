function [ci_lower, ci_upper] = confidence_interval(percentiles, p, size_diff)
% Confidence interval calculated for a comparison
%
% It returns the confidence interval CI of the comparison C given the
% P-quantiles of the percentiles of C.

p = round(p);

if size(percentiles) == [1 1] %#ok<BDSCA>
    if p==50
        ci_lower = percentiles(1, 49);
        ci_upper = percentiles(51, :);
    elseif p>=0 && p<50
        percentil = percentiles{1,1};
        ci_lower = [percentil(1, p+1)];  %#ok<NBRAK>
        ci_upper = [percentil(1, 101-p)]; %#ok<NBRAK>
    else
        ci_lower = NaN;
        ci_upper = NaN;
        
    end
elseif size(percentiles) == [size_diff(1) 1] %#ok<BDSCA>
    for i = 1:1:length(percentiles)
        percentil = percentiles{i};
        if p==50
            ci_lower{i, 1} = percentil(1, 49);  %#ok<AGROW> % wont work
            ci_upper{i, 1} = percentil(51, :); %#ok<AGROW>
        elseif p>=0 && p<50            
            ci_lower{i, 1} = [percentil(1, p+1)];  %#ok<AGROW,NBRAK>
            ci_upper{i, 1} = [percentil(1, 101-p)]; %#ok<,NBRAK>
        else
            ci_lower{i, 1} = NaN; %#ok<AGROW>
            ci_upper{i, 1} = NaN; %#ok<AGROW>
        end
    end
else
    for i = 1:1:size(percentiles, 1)
        for j = 1:1:size(percentiles, 2)
            percentil = percentiles{i, j};
            
        if p==50
            ci_lower{i, j} = percentil(1, 49);  %#ok<AGROW> % wont work
            ci_upper{i, j} = percentil(51, :); %#ok<AGROW>
        elseif p>=0 && p<50            
            ci_lower{i, j} = [percentil(1, p+1)]; %#ok<AGROW,NBRAK>
            ci_upper{i, j} = [percentil(1, 101-p)]; %#ok<NBRAK,AGROW>
        else
            ci_lower{i, j} = NaN; %#ok<AGROW>
            ci_upper{i, j} = NaN; %#ok<AGROW>
        end
        end
    end
end
end



