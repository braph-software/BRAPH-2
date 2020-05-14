function B = binarize(A, varargin)
% BINARIZE binarizes a matrix
%
% B = BINARIZE(A) binarizes the matrix A with 1 for values different than
% 0, and 0 for 0 values.
%
% See also DEDIAGONALIZE, DIAGONALIZE, SEMIPOSITIVIZE, STANDARDIZE, SYMETRIZE.

B = double(A~=0);

end