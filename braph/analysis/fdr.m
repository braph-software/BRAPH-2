function r = fdr(pvalues, q)
% FDR False discovery rate
%
% R = FDR(PVALUES, Q) calculates the false discovery rate (FDR) for PVALUES.
%   Q is parameter whose default value is set to 0.05.
%
% See also pvalue1, pvalue2, bonferroni, quantiles.

% q value [default = 0.05]
if nargin<2
    q = 0.05;
else
    assert(q > 0 && q <= 1, ...
        ['BRAPH:fdr:Q'], ...
        ['Q must be a real number in (0,1]']) %#ok<*NBRAK>
end

x = [1:1:length(pvalues)] / length(pvalues);
pvalues = sort(pvalues);

index = sum(pvalues <= q * x);
if index
    r = pvalues(index);
else
    r = 0;
end