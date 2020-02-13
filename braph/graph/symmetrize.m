function B = symmetrize(A, varargin)
% SYMMETRIZE symmetrizes a matrix
%
% B = SYMETRIZE(A) symmetrizes the matrix A with default RULE 'max'.
%
% B = SYMMETRIZE(A, 'SymmetryzeRule', RULE) symmetrizes the matrix A by the
% Symmetrize RULE specified by the PropertyName.
% Admissible RULE options are:
% RULE = 'max' (default) - maximum between inconnection and outconnection.
%        'sum' | 'add' - sum of inconnection and outconnection.
%        'av' | 'average' - average of inconnection and outconnection.
%        'min' | 'minimum' |'or' | 'weak' - minimum between inconnection and outconnection.
% 
% See also BINARIZE, DEDIAGONALIZE, SEMIPOSITIVIZE, STANDARDIZE.

% Author: Emiliano Gomez & Giovanni Volpe
% Date: 2020/02/07

symmetrize_rule = 'max';
for n = 1:1:length(varargin)-1
    if strcmpi(varargin{n}, 'SymmetrizeRule')
        symmetrize_rule = varargin{n+1};
    end
end

switch lower(symmetrize_rule)
    case {'sum', 'add'}  % sum rule
        B = A + transpose(A);
    case {'av', 'average'}  % average rule
        B = (A + transpose(A)) / 2;
    case {'min', 'minimum', 'or', 'weak'}  % minimum rule
        B = min(A, transpose(A));
    otherwise  % {'max', 'maximum', 'and', 'strong'}  % maximum rule
        B = max(A, transpose(A));
end

end