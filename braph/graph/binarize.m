function B = binarize(A, varargin)
% BINARIZE binarizes a matrix
%
% B = BINARIZE(A) binarizes the matrix A with 1 for values different than 0, and 0 for the 0 values.
% 
% See also SYMETRIZE, DEDIAGONALIZE, SEMIPOSITIVIZE, STANDARDIZE.

    B = double(A~=0);
end