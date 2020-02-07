function B = symmetrize(A, varargin)
    % SYMMETRIZE symmetrizes a matrix
    %
    % B = SYMMETRIZE(A,'PropertyName') symmetrizes the matrix A by the
    %   Symmetriz rule specified by the PropertyName.
    %   Admissible rules are:
    %       rule    -   'max' (default) | 'sum' | 'add' | 'av' | 'average' |
    %                   'min' | 'minimum' | 'or' | 'weak'
    %                   'max' - maximum between inconnection and outconnection (default)
    %                   'sum' - sum of inconnection and outconnection
    %                   'add' - sum of inconnection and outconnection
    %                   'av'  - average of inconnection and outconnection
    %                   'average' - average of inconnection and
    %                               outconnnection
    %                   'min' - minimum between inconnection and outconnection
    %                   'minimum' - minimum between inconnection and outconnection
    %                   'or' - minimum between inconnection and outconnection
    %                   'weak' - minimum between inconnection and outconnection
    %
    
    % 'SymmetrizeRule' (input from varargin)
    symmetrize_rule = 'max';
    for n = 1:1:length(varargin)-1
        if strcmpi(varargin{n}, 'rule')
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
        otherwise  % {'max', 'maximum', 'and', 'strong'} % maximum rule
            B = max(A, transpose(A));
    end
end