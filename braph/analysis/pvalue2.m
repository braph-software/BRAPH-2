function p_double = pvalue2(res, values)
% PVALUE2 Calculates the two-tailed p-value
%
% P = PVALUE2(RES,VALUES) calculates the two-tailed P-value of RES 
%   with respect to the distribution given by VALUES.
%   RES must be a row vector where the columns are the results.
%   VALUES must be a matrix where the columns correspond to RES and 
%   the rows are samples.
%   P is a row vector with the two-sided p-values.
%
% See also pvalue1, fdr.

% Author: Giovanni Volpe
% Date: 2016/01/01

N = size(values, 2);  % number of variables
M = size(values, 1);  % number of samples (per variable)

p_double = ones(1, N);
for n = 1:1:N
    res_tmp = res(n);
    values_tmp = values(:, n);

    res_tmp = res_tmp-mean(values_tmp);
    values_tmp = values_tmp-mean(values_tmp);

    p_double(n) = sum(abs(values_tmp)>abs(res_tmp))/length(values_tmp);
end

p_double(p_double==0) = 1/M;
p_double(isnan(res)) = NaN;
%disp('checkp2')
end