function B = remove_diagonal(A, value)
    % REMOVE_DIAGONAL removes the diagonal values of a matrix
    %
    % B = REMOVE_DIAGONAL(A,VALUE) removes the diagonal
    % values of a matrix A and sets them to VALUE.
    %
    % B = REMOVE_DIAGONAL(A) removes the diagonal
    % values of a matrix A and sets them to 0.
    %
    % See also SYMMETRIZE, REMOVE_NEGATIVE_WEIGHTS.

    % Author: Emiliano Gomez & Giovanni Volpe
    % Date: 2020/02/07

    if nargin < 2
        value = 0;
    end

    B = A;
    B(1:length(A)+1:numel(A)) = value;
end