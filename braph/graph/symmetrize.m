function B = symmetrize(A, varargin)

    % 'SymmetrizeRule' (input from varargin)
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
        otherwise  % {'max', 'maximum', 'and', 'strong'} % maximum rule
            B = max(A, transpose(A));
    end
end