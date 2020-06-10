function r = fdr(pvalues, q)
% FDR False discovery rate
%
% R = FDR(PVALUES) calculates the false discovery rate for PVALUES with
% defult q parameter set to 0.05.
%
% R = FDR(PVALUES, Q) calculates the false discovery rate (FDR) for PVALUES.
% Q is a threshold parameter.
%
% See also bonferroni, pvalue1, pvalue2, quantiles.

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