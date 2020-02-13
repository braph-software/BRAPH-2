function B = standardize(A, varargin)
% STANDARDIZE normalizes a matrix
%
% B = STANDARDIZE(A) normalizes the matrix A in order to have values scaled
% between 0 and 1 by using default RULE 'range' or 'compress'
% using default RULE 'zero'.
%
% B = STANDARDIZE(A, 'StandardizeRule', RULE) 
% normalizes the matrix A using the specified RULE.
% Admissible RULE options are:
%       RULE    -   'range' (default) | 'compress' |'one' | '1' | 1 | 'threshold'
%                   'range' - normalizes the matrix A in order to have
%                   values scaled between 0 and 1 by using a linear function
%                   'compress' - normalizes the matrix A in order to have
%                   values scaled between 0 and 1 by using a linear function
%                   'one' -  normalizes the matrix A following one-rule: 
%                   by converting negative values to zero and values larger 
%                   than 1 are converted to 1
%                   '1' - normalizes the matrix A following one-rule
%                   1 - normalizes the matrix A following one-rule
%                   'threshold' - normalizes the matrix A following one-rule
%

% Author: Anna Canal Garcia
% Date: 2020/02/12

standardize_rule = get_from_varargin('range', 'StandardizeRule', varargin{:});

switch lower(standardize_rule)
    case {'one',1,'1','threshold'}  % one-rule
        B = A;
        B(B <0) = 0;
        B(B>1) = 1 ;
    otherwise  % 'range' | 'compress' - scaled interval
        B = A - min(A)/(max(A)-min(A));
end
end