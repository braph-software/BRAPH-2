function B = remove_negative_weights(A, varargin)
    %  Remove negative weigths function (A, varargin)
    %  Returns a matrix in different ways dependeing
    %  on the rule the user chooses. The rule string will be converted to
    %  lowercase. The function also checks for a correct input of rule
    %  argument, otherwise will convert into Zero rule.
    %
    %  The available rules are the following:
    %
    %   Abs/Absolute/Modulus  - Returns the adjancency matrix with no 
    %                           negative values. The negative values are
    %                           converted to its absolute value.
    %
    %   Zero/Default          - Return the adjancency matrix with no
    %                           negative values. The negative values are 
    %                           converted to zeros. 
    %
   
    % Author: Mite Mijalkov, Giovanni Volpe & Emiliano Gomez
    % Date: 06/02/2020


    %  'RemoveNegativeWeightsRule' (input from varargin)
    remove_negative_weights_rule = 'zero';
    for n = 1:1:length(varargin)-1
        if strcmpi(varargin{n}, 'rule')
            remove_negative_weights_rule = varargin{n+1};
        end
    end

    switch lower(remove_negative_weights_rule)
        case {'abs', 'absolute', 'modulus'}  %  take-absolute-value rule
            B = abs(A);        
        otherwise %  {'zero', '0', 'null'}  % set-to-zero rule
            B = max(A, 0); 
    end

end