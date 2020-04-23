% test Correlation
data = rand(4);
correlation_rule = 'spearman';
negative_weight_rule = 'zero';

%% Test 1 Static getAdjacencyMatrix method
[A, ~] = Correlation.getAdjacencyMatrix(data, correlation_rule, negative_weight_rule);

assert(~isempty(A), ...
        ['BRAPH:Correlation:getAdjacencyMatrix()'], ...
        ['getAdjacencyMatrix should return.']) %#ok<*NBRAK>