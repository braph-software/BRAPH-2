function [B, threshold] = binarize(A, varargin)
% BINARIZE binarizes a matrix
%
% B = BINARIZE(A) binarizes the matrix A with 1 for values different than
% 0, and 0 for 0 values.
%
% [B, THRESHOLD] = BINARIZE(A, PROPERTY, VALUE, ...) enforces a threshold in
% matrix A by using the PROPERTY specified by the VALUE.
% Admissible properties are:
%       threshold   -   0 (default)
%       bins        -   -1:.001:1 (default)
%       density     -   percentage of connections
%       diagonal    -   'exclude' (default) | 'include'
%
% See also Graph, histogram, DEDIAGONALIZE, DIAGONALIZE, SEMIPOSITIVIZE, STANDARDIZE, SYMETRIZE.

threshold = get_from_varargin(0, 'threshold', varargin{:});

if threshold == 0 && nargin < 2
    B = double(A~=0);
    return
end

density = get_from_varargin([], 'density', varargin{:});
if density
    [~, bins, dens] = histogram(A, varargin{:});
    threshold = bins(dens < density);
    if isempty(threshold)
        threshold = 1;
    else
        threshold = threshold(1);
    end
end

% Calculates binary graph
B = zeros(size(A));
B(A > threshold) = 1;
end