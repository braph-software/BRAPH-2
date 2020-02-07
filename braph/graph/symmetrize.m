function B = symmetrize(A, varargin)
    %  Symmetryze function (A, varargin)
    %  Returns a symmetryzed adjacency  matrix in different ways dependeing
    %  on the rule the user chooses. The rule string will be converted to
    %  lowercase. The function also checks for a correct input of rule
    %  argument, otherwise will convert into Max rule.
    %
    %  The available rules are the following:
    %
    %   Sum/Add             - Returns the adjancency matrix plus its 
    %                         transpose matrix.
    %
    %   Av/Average          - Return the result of the addition of the 
    %                        adjanceny matrix plus its tranpose matrix 
    %                        divided by two.
    %
    %   Min/Minimum/Or/Weak - Return the minimum elements of the adjancency
    %                         matrix or its transpose matrix.
    %
    %   Max/Default         - Return the maximum elements of the adjancency
    %                         matrix or its tranpose matrix.
    %   
    % 
    
    % Author: Mite Mijalkov, Giovanni Volpe & Emiliano Gomez
    % Date: 06/02/2020

    % 'SymmetrizeRule' (input from varargin)
    symmetrize_rule = 'max';
    for n = 1:1:length(varargin)-1
        if strcmpi(varargin{n}, 'rule')
            symmetrize_rule = varargin{n+1};
        end
    end

    switch lower(symmetrize_rule)
        case {'sum', 'add'}  %  sum rule
            B = A + transpose(A);
        case {'av', 'average'}  %  average rule
            B = (A + transpose(A)) / 2;
        case {'min', 'minimum', 'or', 'weak'}  %  minimum rule
            B = min(A, transpose(A));
        otherwise  %  {'max', 'maximum', 'and', 'strong'} % maximum rule
            B = max(A, transpose(A));
    end
end