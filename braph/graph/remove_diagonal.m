function B = remove_diagonal(A, varargin)
% REMOVE_DIAGONAL removes the diagonal values of a matrix
%
% B = REMOVE_DIAGONAL(A) removes the diagonal
% values of a matrix A and sets them to 0.
%
% B = REMOVE_DIAGONAL(A, 'RemoveDiagonalValue', VALUE) removes the diagonal
% values of a matrix A and sets them to VALUE.
%
% See also SYMMETRIZE, REMOVE_NEGATIVE_WEIGHTS, BINARIZE.

% Author: Emiliano Gomez & Giovanni Volpe
% Date: 2020/02/07

remove_diagonal_value = get_from_varargin(0, 'RemoveDiagonalValue', varargin);

B = A;
B(1:length(A)+1:numel(A)) = remove_diagonal_value;

end