function B = remove_diagonal(A, value)
    % REMOVE_DIAGONAL removes the diagonal values of a matrix
    %
    % B = REMOVE_DIAGONAL(A,'PropertyValue') removes the diagonal
    % values of a matrix A.

    %

    % 'RemoveDiagonal' (input from varargin)

    if nargin < 2
        value = 0;
    end

    B = A;
    B(1:length(A)+1:numel(A)) = value;
end