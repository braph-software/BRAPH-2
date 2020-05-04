function ci = confidence_interval(percentiles, p)
% Confidence interval calculated for a comparison
%
% It returns the confidence interval CI of the comparison C given the
% P-quantiles of the percentiles of C.

p = round(p);
if p==50
    ci = percentiles(51, :);
elseif p>=0 && p<50
    if size(percentiles) == [1 1]
        percentil = percentiles{1,1};
        ci = [percentil(1, p+1); percentil(1, 101-p)];
    else
    end
else
    ci = NaN;
end
end



