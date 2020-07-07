function [permutation_1, permutation_2] = permutation(values_1, values_2, is_longitudinal)
% It permutes the objects in values_1 and values_2 regardless of what they
% are.

if nargin < 3
    is_longitudinal = false;
end

if is_longitudinal
    assert(isequal(size(values_1), size(values_2)), ...
        [BRAPH2.STR ':Permutation:' BRAPH2.WRONG_INPUT], ...
        'Value_1 must be the same size as Value_2')
    
    max = min(numel(values_1), numel(values_2));
    permutation = sign(randn(1, max));
    permutation_1 = values_1;
    permutation_2 = values_2;
    permutation_1(permutation==1) = values_2(permutation==1);
    permutation_2(permutation==1) = values_1(permutation==1);
else
    n_total = size(values_1, 2) + size(values_2, 2);
    n_subjects_1 = size(values_1, 2);
    values = [values_1 values_2];
    index_permutation_1 = sort(randperm(n_total, n_subjects_1));
    index_permutation_2 = [1:1:n_total];
    index_permutation_2(index_permutation_1) = 0;
    index_permutation_2 = index_permutation_2(index_permutation_2 > 0);
    permutation_1 = values(:, index_permutation_1);
    permutation_2 = values(:, index_permutation_2);
end
end