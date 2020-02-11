function B = semipositivize(A, varargin)
% SEMIPOSITIVIZE removes the negative values of a matrix
%
% B = SEMIPOSITIVIZE(A) removes the negative weights of a
% matrix A using default RULE 'zero'.
%
% B = SEMIPOSITIVIZE(A, 'SemipositivizeRule', RULE) 
% removes the negative weights of a matrix A using the RULE specified.
% Admissible RULE options are:
%       RULE    -   'zero' (default) | 'abs' | 'absolute' | 'modulus' 
%                   'zero' - convert negative values to zeros.
%                   'abs' - convert negative values to its absolute
%                           value.
%                   'absolute' - convert negative values to its absolute
%                           value.
%                   'modulus' - convert negative values to its absolute
%                           value.
%
% See also SYMMETRIZE, DEDIAGONALIZE, BINARIZE.

% Author: Emiliano Gomez & Giovanni Volpe
% Date: 2020/02/07

semipositivize_rule = 'zero';
for n = 1:1:length(varargin)-1
    if strcmpi(varargin{n}, 'SemipositivizeRule')
        semipositivize_rule = varargin{n+1};
    end
end

switch lower(semipositivize_rule)
    case {'abs', 'absolute', 'modulus'}  % take-absolute-value rule
        B = abs(A);
    otherwise  % {'zero', '0', 'null'}  % set-to-zero rule
        B = max(A, 0);
end

end