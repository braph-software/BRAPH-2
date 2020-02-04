function B = symmetrize(A, varargin)

    % 'Rule' (input from varargin)
    rule = 'max';
    for n = 1:1:length(varargin)-1
        if strcmpi(varargin{n}, 'rule')
            rule = varargin{n+1};
        end
    end

    switch lower(rule)
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