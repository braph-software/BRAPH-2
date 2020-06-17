function Q = quantiles(values, P)
% QUANTILES Calculates the quantiles of a distribution
%
% Q = QUANTILES(VALUES, P) calculates the P-quantiles of VALUES.
% VALUES must be a cell array of samples, where each cell contains a 
% scalar, a vector or a matrix with random variables. Q is a cell array with
% the quantiles from 0 to Q.
%
% Q = QUANTILES(VALUES) calculates the percentiles of VALUES. It is
% equivalent to QUANTILES(VALUES, 100).
%
% See also pvalue1, pvalue2, fdr, bonferroni.

% number of bins [default = 100]
if nargin < 2
    P = 100;
else
    P = ceil(abs(P));  % enforces that P is a positive integer
end

M = numel(values);  % number of samples (per variable)

row_number = size(values{1}, 1);
column_number = size(values{1}, 2);

Q = cell(row_number, column_number);
for i = 1:1:row_number
    for j = 1:1:column_number
        current_values = cellfun(@(x) x(i, j), values);
        Q{i, j} = [min(current_values), quantile(current_values, P - 1), max(current_values)];
    end
end