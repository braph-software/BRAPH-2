function r = bonferroni(pvalues, p)
% BONFERRONI Bonferroni correction
%
% R = BONFERRONI(PVALUES, p) calculates the Bonferroni correction for PVALUES.
% P is the starting p-value.
%
% See also fdr, pvalue1, pvalue2, quantiles.

r = p / length(pvalues);