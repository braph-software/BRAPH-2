function B = diagonalize(A, varargin)
% DIAGONALIZE removes the off-diagonal values of a matrix
%
% B = DIAGONALIZE(A) removes the off-diagonal values of the matrix A 
% and sets them to 0.
%
% See also BINARIZE, DEDIAGONALIZE, SEMIPOSITIVIZE, STANDARDIZE, SYMMETRIZE.

B = diag(A(1:length(A)+1:end));

end