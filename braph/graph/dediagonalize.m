function B = dediagonalize(A, varargin)
% DEDIAGONALIZE removes the diagonal values of a matrix
%
% B = DEDIAGONALIZE(A) removes the diagonal values of the matrix A 
% and sets them to 0.
%
% B = DEDIAGONALIZE(A, 'DediagonalizeRule', VALUE) removes the diagonal
% values of a matrix A and sets them to VALUE.
%
% See also SYMMETRIZE, SEMIPOSITIVIZE, BINARIZE.

% Author: Emiliano Gomez & Giovanni Volpe
% Date: 2020/02/07

value = get_from_varargin(0, 'DediagonalizeRule', varargin{:});

B = A;
B(1:length(A)+1:numel(A)) = value;

end
