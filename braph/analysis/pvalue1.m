function p_single = pvalue1(res, values)
% PVALUE1 Calculates the one-tailed p-value
%
% P = PVALUE1(RES, VALUES) calculates the one-tailed P-value of RES 
%   with respect to the distribution given by VALUES.
%   RES must be a row vector where the columns are the results.
%   VALUES must be a matrix where the columns correspond to RES and 
%   the rows are samples.
%   P is a row vector with the one-sided p-values.
%
% See also pvalue2, quantiles, fdr.

N = size(values, 2);  % number of variables
M = size(values, 1);  % number of samples (per variable)

p_single = ones(1, N);
for n = 1:1:N
    res_tmp = res(n);
    values_tmp = values(:, n);

    res_tmp = res_tmp-mean(values_tmp);
    values_tmp = values_tmp-mean(values_tmp);

    if res_tmp>0
        p_single(n) = sum(values_tmp>res_tmp)/length(values_tmp);
    else
        p_single(n) = sum(values_tmp<res_tmp)/length(values_tmp);
    end
end

p_single(p_single==0) = 1/M;
p_single(isnan(res)) = NaN;
%disp('checkp1')
end