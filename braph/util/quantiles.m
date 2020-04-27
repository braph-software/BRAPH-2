function q = quantiles(values, P)
% QUANTILES Calcualtes quantiles of a distribution
%
% Q = QUANTILES(VALUES,P) calculates the P-quantiles of VALUES.
%   VALUES must be a matrix where the columns are random variables and 
%   the rows are samples.
%   Q is a matrix where the columns are random variables and 
%   the rows are the quantiles from 0 to Q.
%
% Q = QUANTILES(VALUES) calculates the percentiles of VALUES. It is
%   equivalent to QUANTILES(VALUES,100).

% Author: Giovanni Volpe
% Date: 2016/01/01

% number of bins [default = 100]
if nargin < 2
    P = 100;
else
    Check.isinteger('P must be a positive integer', P, '>0')
end

N = size(values, 2);  % number of variables
M = size(values, 1);  %#ok<*NASGU> % number of samples (per variable)

q = zeros(P+1, N);
for n = 1:1:N

    % percentiles
    C = 10*P;
    [counts,binscenters] = histogram(values(:, n), C);
    scounts = cumsum(counts)/sum(counts)*P;

    dbinscenters = (binscenters(2)-binscenters(1))/2;
    binscenters = [binscenters(1)-dbinscenters binscenters+dbinscenters];
    scounts = [0 scounts]; %#ok<*AGROW>

    for i = 0:1:P
        indices_low = find(scounts <= i);
        indices_high = find(scounts >= i);
        if ~isempty(indices_low) && ~isempty(indices_high)
            q(i+1, n) = (binscenters(indices_low(end))+binscenters(indices_high(1)))/2;
        else
            q(i+1, n) = NaN;
        end
    end
end