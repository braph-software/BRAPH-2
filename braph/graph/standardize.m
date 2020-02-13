function B = standardize(A, varargin)
% STANDARDIZE normalizes a matrix
%
% B = STANDARDIZE(A) normalizes the matrix A in order to have values scaled
% between 0 and 1 by using the default RULE 'range'.
%
% B = STANDARDIZE(A, 'StandardizeRule', RULE) 
% normalizes the matrix A using the specified RULE.
% Admissible RULE options are:
% RULE = 'range' (default) - normalizes the matrix A in order to have
%                   values scaled between 0 and 1 by using a linear
%                   function.
%        'compress' - normalizes the matrix A in order to have values
%                   scaled between 0 and 1 by using a linear function.
%        'one' | '1' | 1 | 'threshold' - normalizes the matrix A following
%                   one-rule: by converting negative values to zero and
%                   values larger than 1 to 1.
%
% See also BINARIZE, DEDIAGONALIZE, SEMIPOSITIVIZE, SYMMETRIZE.

% Author: Anna Canal Garcia
% Date: 2020/02/12

standardize_rule = get_from_varargin('range', 'StandardizeRule', varargin{:});

switch lower(standardize_rule)
    case {'one',1,'1','threshold'}  % one-rule
        B = A;
        B(B<0) = 0;
        B(B>1) = 1 ;
    otherwise  % 'range' | 'compress' - scaled interval
        if numel(A) > 1
            B = A - min(A(:)) / (max(A(:)) - min(A(:)));
        else
            B = 0;
        end
end

end
