% test Permutation

%% Test 1 Static Method 

size_group = 3;
size_both_groups = 6;

[index_group_1, index_group_2] = Permutation.getPermutation(0, 0, 0, size_both_groups, size_group);

assert(~isempty(index_group_1), ...
    ['BRAPH:AnalysisDTI:Permutation'], ...
    ['Permutation.getPermutation() not working']) %#ok<*NBRAK>

assert(~isempty(index_group_2), ...
    ['BRAPH:AnalysisDTI:getMeasurementID'], ...
    ['Permutation.getPermutation() not working']) 

assert(~isequal(index_group_1, index_group_2), ...
    ['BRAPH:AnalysisDTI:getMeasurementID'], ...
    ['Permutation.getPermutation() not working'])
