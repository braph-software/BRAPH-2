function P1 = pvalue1(observed_difference, random_differences)
% PVALUE1 Calculates the one-tailed p-value
%
% P1 = PVALUE1(OBSERVED_DIFFERENCE, RANDOM_DIFFERENCES) calculates the
% one-tailed P-value of OBSERVED_DIFFERENCE with respect to the
% distribution given by RANDOM_DIFFERENCES. 
% OBSERVED_DIFFERENCE a scalar, vector or matrix with the difference.
% RANDOM_DIFFERENCES must be a cell array of samples, where each cell contains a
% scalar, vector or matrix with random variables.
% P2 is a scalar, vector or matrix with the one-sided p-values.
%
% See also pvalue2, quantiles, fdr, bonferroni.

M = numel(random_differences);  % number of samples (per variable)

row_number = size(random_differences{1}, 1);
column_number = size(random_differences{1}, 2);

Q = cell(row_number, column_number);
for i = 1:1:row_number
    for j = 1:1:column_number
        current_observed_difference = observed_difference(i, j);
        current_random_differences = cellfun(@(x) x(i, j), random_differences);
        
        if current_observed_difference > 0
            P1(i, j) =  ...
                (length(find(current_random_differences > current_observed_difference)) + 1) ...
                / ...
                (length(current_random_differences) + 1);
        else  % current_observed_difference <= 0
            P1(i, j) =  ...
                (length(find(current_random_differences < current_observed_difference)) + 1) ...
                / ...
                (length(current_random_differences) + 1);            
        end
    end
end