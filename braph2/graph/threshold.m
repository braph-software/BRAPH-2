function [B, threshold] = threshold(A, threshold,  varargin)
% THRESHOLD enforces a threshold in the values of a matrix
%
% [B, THRESHOLD] = BINARIZE(A) enforces a threshold in a matrix A by fixing 
% either the threshold (default, threshold = 0) or the density (percent of
% connections). It returns the binarized matrix B and the threshold THRESHOLD.
%
% [B, THRESHOLD] = BINARIZE(A, PROPERTY, VALUE, ...) enforces a threshold in
% matrix A by using the PROPERTY specified by the VALUE.
% Admissible properties are:
%       threshold   -   0 (default)
%       bins        -   -1:.001:1 (default)
%       density     -   percentage of connections
%       diagonal    -   'exclude' (default) | 'include'
%
% See also Graph, histogram.

% Threshold and density
% threshold = get_from_varargin(0, 'threshold', varargin{:});

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