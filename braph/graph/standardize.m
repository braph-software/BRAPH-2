function B = standardize(A, varargin)
% STANDARDIZE normalizes a matrix A in order to have values between 0
% and 1
% Author: Anna
% Date: 2020/02/12

B = A/max(max(A));
end