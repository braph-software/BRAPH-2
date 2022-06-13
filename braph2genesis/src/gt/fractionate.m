function [B, threshold] = fractionate(A, varargin)
%FRACTIONATE fractionates a matrix
%
% B = FRACTIONATE(A) fractionates the matrix A by keeping a certan
% percentage of connections that are greater than a threshold.
%
% [B, THRESHOLD] = FRACTIONATE(A, PROPERTY, VALUE, ...) enforces a threshold in
%  matrix A by using the PROPERTY specified by the VALUE.
%  Admissible properties are:
%       threshold   -   0 (default)
%       bins        -   -1:.001:1 (default)
%       density     -   percentage of connections
%       diagonal    -   'exclude' (default) | 'include'
%
% See also Graph, histogram, BINARIZE, DEDIAGONALIZE, DIAGONALIZE, SEMIPOSITIVIZE,
%  STANDARDIZE, SYMETRIZE. 

threshold = get_from_varargin(0, 'threshold', varargin{:});

if threshold == 0 && nargin < 2
    B = double(A~=0);
    return
end

density = get_from_varargin([], 'density', varargin{:});
if ~isempty(density)
    diagonal = get_from_varargin('exclude', 'diagonal', varargin{:});
    if strcmpi(diagonal, 'include')
        sorted_vector = sort(A(:));
    else
        sorted_vector = sort(A(~eye(size(A))));
    end
    index = round(length(sorted_vector) * (100 - density) / 100);
    if index == 0
        threshold = sorted_vector(1) - eps;
    elseif index >= length(sorted_vector)
        threshold = sorted_vector(end) + eps;
    else
        threshold = sorted_vector(index);
    end
end

% Calculates binary graph
B = zeros(size(A));
B(A >= threshold) = A(A >= threshold);
end