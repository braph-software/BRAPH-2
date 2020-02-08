function B = remove_negative_weights(A, varargin)

    % 'RemoveNegativeWeightsRule' (input from varargin)
    remove_negative_weights_rule = 'zero';
    for n = 1:1:length(varargin)-1
        if strcmpi(varargin{n}, 'RemoveNegativeWeightsRule')
            remove_negative_weights_rule = varargin{n+1};
        end
    end

    switch lower(remove_negative_weights_rule)
        case {'abs', 'absolute', 'modulus'}  % take-absolute-value rule
            B = abs(A);
        otherwise % {'zero', '0', 'null'}  % set-to-zero rule
            B = max(A, 0); 
    end

end