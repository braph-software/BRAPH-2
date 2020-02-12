function B = standardize(A, varargin)
% STANDARDIZE normalizes a matrix
%
% B = STANDARDIZE(A) 
% STANDARDIZE METHODS:
% Admissible RULE options are:
%       RULE    -   'range' (default) | 'one' 
%                   'range' - normalizes the matrix A in order to have values between 0 and 1
%                   'one' -  (A<0 = 0 and A>1 = 1)
%

% Author: Anna
% Date: 2020/02/12

standardize_rule = get_from_varargin('range', 'StandardizeRule', varargin{:});

switch lower(standardize_rule)
    case {'one'} % one-rule
        B = A;
        B(B <0) = 0;
        B(B>1) = 1 ;
    otherwise  % 'range'
        B = A/max(max(A));
end
end