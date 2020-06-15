function [r, c] = fdr(pvalues, q)
% FDR False discovery rate
%
% R, C = FDR(PVALUES) calculates the false discovery rate for PVALUES with
% defult q parameter set to 0.05. C returns a logical array, each positive
% means that the pvalue passes the test, and each negative the contrary. 
%
% R = FDR(PVALUES, Q) calculates the false discovery rate (FDR) for PVALUES.
% Q is a threshold parameter. FDR returns all PValues that are less than
% the maximum PValue that satifies: P <= (i/m)Q, where i is the rank of the
% test, m is the number of tests and Q is the threshold parameter. C returns 
% a logical array, each positive means that the pvalue passes the test, 
% and each negative the contrary.
%
% See also bonferroni, pvalue1, pvalue2, quantiles.

% q value [default = 0.05]
if nargin < 2
    q = 0.05;
else
    assert(q > 0 && q <= 1, ...
        [BRAPH2.STR ':fdr:Q'], ...
        ['Q must be a real number in (0, 1]']) %#ok<*NBRAK>
end
x = [1:1:length(pvalues)] / length(pvalues);
pvalues = sort(pvalues);
index = max(find(pvalues <= x * q)); %#ok<MXFND>
c  = pvalues <= x * q;

if index
    r = pvalues(index);
else
    r = 0;
end