%% ¡header!
MultilayerBU < Graph (g, multilayer binary undirected graph) is a multilayer binary undirected graph.

%%% ¡description!
In a multilayer binary undirected (BU) graph, layers could have different number
 of nodes with within-layer undirected edges either 0 (absence of connection) 
 or 1 (existence of connection).
The connectivity matrices are symmetric (within layer).
All node connections are allowed between layers.

%% ¡props_update!

%%% ¡prop!

NAME (constant, string) is the name of the multilayer binary undirected graph.
%%%% ¡default!
'MultilayerBU'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the multilayer binary undirected graph.
%%%% ¡default!
'In a multilayer binary undirected (BU) graph, layers could have different number of nodes with within-layer undirected edges either 0 (absence of connection) or 1 (existence of connection). The connectivity matrices are symmetric (within layer). All node connections are allowed between layers.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the multilayer binary undirected graph.

%%% ¡prop!
ID (data, string) is a few-letter code for the multilayer binary undirected graph.
%%%% ¡default!
'MultilayerBU ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the multilayer binary undirected graph.
%%%% ¡default!
'MultilayerBU label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the multilayer binary undirected graph.
%%%% ¡default!
'MultilayerBU notes'

%%% ¡prop!
GRAPH_TYPE (constant, scalar) returns the graph type __Graph.MULTILAYER__.
%%%% ¡default!
Graph.MULTILAYER

%%% ¡prop!
CONNECTIVITY_TYPE (query, smatrix) returns the connectivity type __Graph.BINARY__ * ones(layernumber).
%%%% ¡calculate!
if isempty(varargin)
    layernumber = 1;
else
    layernumber = varargin{1};
end
value = Graph.BINARY * ones(layernumber);

%%% ¡prop!
DIRECTIONALITY_TYPE (query, smatrix) returns the directionality type __Graph.UNDIRECTED__ * ones(layernumber).
%%%% ¡calculate!
if isempty(varargin)
    layernumber = 1;
else
    layernumber = varargin{1};
end
value = Graph.UNDIRECTED * ones(layernumber);

%%% ¡prop!
SELFCONNECTIVITY_TYPE (query, smatrix) returns the self-connectivity type __Graph.NONSELFCONNECTED__ on the diagonal and __Graph.SELFCONNECTED__ off diagonal.
%%%% ¡calculate!
if isempty(varargin)
    layernumber = 1;
else
    layernumber = varargin{1};
end
value = Graph.SELFCONNECTED * ones(layernumber);
value(1:layernumber+1:end) = Graph.NONSELFCONNECTED;                

%%% ¡prop!
NEGATIVITY_TYPE (query, smatrix) returns the negativity type __Graph.NONNEGATIVE__ * ones(layernumber).
%%%% ¡calculate!
if isempty(varargin)
    layernumber = 1;
else
    layernumber = varargin{1};
end
value = Graph.NONNEGATIVE * ones(layernumber);

%%% ¡prop!
A (result, cell) is the cell containing the binary supra-adjacency matrix of the multilayer binary undirected graph.
%%%% ¡calculate!
B = g.get('B'); %#ok<PROPLC>
L = length(B); %#ok<PROPLC> % number of layers
for i = 1:1:L
    M = symmetrize(B{i, i}, 'SymmetrizeRule', g.get('SYMMETRIZE_RULE')); %#ok<PROPLC> % enforces symmetry of adjacency matrix
    M = dediagonalize(M); % removes self-connections by removing diagonal from adjacency matrix, equivalent to dediagonalize(M, 'DediagonalizeRule', 0)
    M = semipositivize(M, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
    M = binarize(M); % enforces binary adjacency matrix, equivalent to binarize(M, 'threshold', 0, 'bins', [-1:.001:1])
    B(i, i) = {M};
end
A = B;
value = A;

%%%% ¡gui!
pr = PanelPropCell('EL', g, 'PROP', MultilayerBU.A, ...
    'TABLE_HEIGHT', s(40), ...
    'XYSLIDERLOCK', true, ... 
    'XSLIDERSHOW', false, ...
    'YSLIDERSHOW', true, ...
    'YSLIDERLABELS', g.getCallback('ALAYERLABELS'), ...
    'YSLIDERWIDTH', s(5), ...
    'ROWNAME', g.getCallback('ANODELABELS'), ...
    'COLUMNNAME', g.getCallback('ANODELABELS'), ...
    varargin{:});

%%% ¡prop!
PARTITIONS (result, rvector) returns the number of layers in the partitions of the graph.
%%%% ¡calculate!
value = ones(1, g.get('LAYERNUMBER'));

%%% ¡prop!
ALAYERLABELS (query, stringlist) returns the layer labels to be used by the slider.
%%%% ¡calculate!
alayerlabels = g.get('LAYERLABELS');
if isempty(alayerlabels) && ~isa(g.getr('A'), 'NoValue') % ensures that it's not unecessarily calculated
    alayerlabels = cellfun(@num2str, num2cell([1:1:g.get('LAYERNUMBER')]), 'uniformoutput', false);
end
value = alayerlabels;

%%% ¡prop!
COMPATIBLE_MEASURES (constant, stringlist) is the list of compatible measures.
%%%% ¡default!
getCompatibleMeasures('MultilayerBU')

%% ¡props!

%%% ¡prop!
B (data, cell) is the input cell containing the multilayer adjacency matrices on the diagonal.
%%%% ¡default!
{[] []; [] []}
%%%% ¡gui!
pr = PanelPropCell('EL', g, 'PROP', MultilayerBU.B, ...
    'TABLE_HEIGHT', s(40), ...
    'XSLIDERSHOW', true, ...
    'XSLIDERLABELS', g.get('LAYERLABELS'), ...
    'XSLIDERHEIGHT', s(3.5), ...
    'YSLIDERSHOW', false, ...
    'ROWNAME', g.getCallback('ANODELABELS'), ...
    'COLUMNNAME', g.getCallback('ANODELABELS'), ...
    varargin{:});

%%% ¡prop!
SYMMETRIZE_RULE (parameter, option) determines how to symmetrize the matrix.
%%%% ¡settings!
{'max', 'sum', 'average', 'min'}

%%% ¡prop!
SEMIPOSITIVIZE_RULE (parameter, option) determines how to remove the negative edges.
%%%% ¡settings!
{'zero', 'absolute'}

%% ¡tests!

%%% ¡excluded_props!
[MultilayerBU.PFGA MultilayerBU.PFGH]

%%% ¡test!
%%%% ¡name!
Constructor - Full
%%%% ¡probability!
.01
%%%% ¡code!
B1 = rand(randi(10));
B2 = rand(randi(10));
B3 = rand(randi(10));
B12 = rand(size(B1, 1),size(B2, 2));
B13 = rand(size(B1, 1),size(B3, 2));
B23 = rand(size(B2, 1),size(B3, 2));
B = {
    B1                           B12                            B13
    B12'                         B2                             B23
    B13'                         B23'                           B3
    };
g = MultilayerBU('B', B);
g.get('A_CHECK')
A1 = symmetrize(binarize(semipositivize(dediagonalize(B1))));
A2 = symmetrize(binarize(semipositivize(dediagonalize(B2))));
A3 = symmetrize(binarize(semipositivize(dediagonalize(B3))));
B{1, 1} = A1;
B{2, 2} = A2;
B{3, 3} = A3;
A = B;
assert(isequal(g.get('A'), A), ...
    [BRAPH2.STR ':MultilayerBU:' BRAPH2.FAIL_TEST], ...
    'MultilayerBU is not constructing well.')

%%% ¡test!
%%%% ¡name!
Symmetrize and Semipositivize Rules
%%%% ¡probability!
.01
%%%% ¡code!
B1 = 10 * rand(randi(10) + 5) - 5; % random number in U(-5, 5)
B2 = 10 * rand(randi(10) + 5) - 5; % random number in U(-5, 5)
B3 = 10 * rand(randi(10) + 5) - 5; % random number in U(-5, 5)
B = {
    B1                           rand(size(B1,1),size(B2,2))  rand(size(B1,1),size(B3,2))
    rand(size(B1,1),size(B2,2))' B2                           rand(size(B2,1),size(B3,2))
    rand(size(B1,1),size(B3,2))' rand(size(B2,1),size(B3,2))' B3
    };

g0 = MultilayerBU('B', B); % 'SEMIPOSITIVIZE_RULE', 'zero', 'STANDARDIZE_RULE', 'max'

A1 = dediagonalize(max(B1, B1') > 0);
A2 = dediagonalize(max(B2, B2') > 0);
A3 = dediagonalize(max(B3, B3') > 0);
A0{1, 1} = A1;
A0{2, 2} = A2;
A0{3, 3} = A3;

assert(isequal(g0.get('A'), A0), ...
    [BRAPH2.STR ':MultilayerBU:' BRAPH2.FAIL_TEST], ...
    'MultilayerBU is not constructing well.')

g_max = MultilayerBU('B', B, 'SEMIPOSITIVIZE_RULE', 'max'); % 'STANDARDIZE_RULE', 'zero'
A1 = dediagonalize(max(B1, B1') > 0);
A2 = dediagonalize(max(B2, B2') > 0);
A3 = dediagonalize(max(B3, B3') > 0);
A_max{1, 1} = A1;
A_max{2, 2} = A2;
A_max{3, 3} = A3;
assert(isequal(g_max.get('A'), A_max), ...
    [BRAPH2.STR ':MultilayerBU:' BRAPH2.FAIL_TEST], ...
    'MultilayerBU is not constructing well.')

g_sum = MultilayerBU('B', B, 'SYMMETRIZE_RULE', 'sum'); % 'SEMIPOSITIVIZE_RULE', 'zero'
A1 = dediagonalize(B1+ B1' > 0);
A2 = dediagonalize(B2 + B2' > 0);
A3 = dediagonalize(B3 + B3' > 0);
A_sum{1, 1} = A1;
A_sum{2, 2} = A2;
A_sum{3, 3} = A3;
assert(isequal(g_sum.get('A'), A_sum), ...
    [BRAPH2.STR ':MultilayerBU:' BRAPH2.FAIL_TEST], ...
    'MultilayerBU is not constructing well.')

g_average = MultilayerBU('B', B, 'SYMMETRIZE_RULE', 'average'); % 'SEMIPOSITIVIZE_RULE', 'zero'
A1 = dediagonalize((B1+ B1' ) / 2 > 0);
A2 = dediagonalize((B2 + B2') / 2 > 0);
A3 = dediagonalize((B3 + B3') / 2 > 0);
A_sum{1, 1} = A1;
A_sum{2, 2} = A2;
A_sum{3, 3} = A3;
assert(isequal(g_average.get('A'), A_average), ...
    [BRAPH2.STR ':MultilayerBU:' BRAPH2.FAIL_TEST], ...
    'MultilayerBU is not constructing well.')

g_min = MultilayerBU('B', B, 'SYMMETRIZE_RULE', 'min'); % 'SEMIPOSITIVIZE_RULE', 'zero'
A1 = dediagonalize(min(B1, B1') > 0);
A2 = dediagonalize(min(B2, B2') > 0);
A3 = dediagonalize(min(B3, B3') > 0);
A_min{1, 1} = A1;
A_min{2, 2} = A2;
A_min{3, 3} = A3;
assert(isequal(g_min.get('A'), A_min), ...
    [BRAPH2.STR ':MultilayerBU:' BRAPH2.FAIL_TEST], ...
    'MultilayerBU is not constructing well.')

g_zero = MultilayerBU('B', B, 'SEMIPOSITIVIZE_RULE', 'zero'); % 'SYMMETRIZE_RULE', 'max'
A1 = dediagonalize(max(B1, B1') > 0);
A2 = dediagonalize(max(B2, B2') > 0);
A3 = dediagonalize(max(B3, B3') > 0);
A_zero{1, 1} = A1;
A_zero{2, 2} = A2;
A_zero{3, 3} = A3;
assert(isequal(g_zero.get('A'), A_zero), ...
    [BRAPH2.STR ':MultilayerBU:' BRAPH2.FAIL_TEST], ...
    'MultilayerBU is not constructing well.')

g_zero_max = MultilayerBU('B', B, 'SEMIPOSITIVIZE_RULE', 'zero', 'SYMMETRIZE_RULE', 'max');
A1 = dediagonalize(max(B1, B1') > 0);
A2 = dediagonalize(max(B2, B2') > 0);
A3 = dediagonalize(max(B3, B3') > 0);
A_zero_max{1, 1} = A1;
A_zero_max{2, 2} = A2;
A_zero_max{3, 3} = A3;
assert(isequal(g_zero_max.get('A'), A_zero_max), ...
    [BRAPH2.STR ':MultilayerBU:' BRAPH2.FAIL_TEST], ...
    'MultilayerBU is not constructing well.')

g_zero_sum = MultilayerBU('B', B, 'SEMIPOSITIVIZE_RULE', 'zero', 'SYMMETRIZE_RULE', 'sum');
A1 = dediagonalize(B1 + B1' > 0);
A2 = dediagonalize(B2 + B2' > 0);
A3 = dediagonalize(B3 + B3' > 0);
A_zero_sum{1, 1} = A1;
A_zero_sum{2, 2} = A2;
A_zero_sum{3, 3} = A3;
assert(isequal(g_zero_sum.get('A'), A_zero_sum), ...
    [BRAPH2.STR ':MultilayerBU:' BRAPH2.FAIL_TEST], ...
    'MultilayerBU is not constructing well.')

g_zero_average = MultilayerBU('B', B, 'SEMIPOSITIVIZE_RULE', 'zero', 'SYMMETRIZE_RULE', 'average');
A1 = dediagonalize((B1 + B1') / 2 > 0);
A2 = dediagonalize((B2 + B2') / 2 > 0);
A3 = dediagonalize((B3 + B3') / 2 > 0);
A_zero_average{1, 1} = A1;
A_zero_average{2, 2} = A2;
A_zero_average{3, 3} = A3;
assert(isequal(g_zero_average.get('A'), A_zero_average), ...
    [BRAPH2.STR ':MultilayerBU:' BRAPH2.FAIL_TEST], ...
    'MultilayerBU is not constructing well.')

g_zero_min = MultilayerBU('B', B, 'SEMIPOSITIVIZE_RULE', 'zero', 'SYMMETRIZE_RULE', 'min');
A1 = dediagonalize(min(B1, B1') > 0);
A2 = dediagonalize(min(B2, B2') > 0);
A3 = dediagonalize(min(B3, B3') > 0);
A_zero_min{1, 1} = A1;
A_zero_min{2, 2} = A2;
A_zero_min{3, 3} = A3;
assert(isequal(g_zero_min.get('A'), A_zero_min), ...
    [BRAPH2.STR ':MultilayerBU:' BRAPH2.FAIL_TEST], ...
    'MultilayerBU is not constructing well.')

g_absolute = MultilayerBU('B', B, 'SEMIPOSITIVIZE_RULE', 'absolute'); % 'SYMMETRIZE_RULE', 'max'
A1 = dediagonalize(max(B1, B1') ~= 0);
A2 = dediagonalize(max(B2, B2') ~= 0);
A3 = dediagonalize(max(B3, B3') ~= 0);
A_absolute{1, 1} = A1;
A_absolute{2, 2} = A2;
A_absolute{3, 3} = A3;
assert(isequal(g_absolute.get('A'), A_absolute), ...
    [BRAPH2.STR ':MultilayerBU:' BRAPH2.FAIL_TEST], ...
    'MultilayerBU is not constructing well.')

g_absolute_max = MultilayerBU('B', B, 'SEMIPOSITIVIZE_RULE', 'absolute', 'SYMMETRIZE_RULE', 'max');
A1 = dediagonalize(max(B1, B1') ~= 0);
A2 = dediagonalize(max(B2, B2') ~= 0);
A3 = dediagonalize(max(B3, B3') ~= 0);
A_absolute_max{1, 1} = A1;
A_absolute_max{2, 2} = A2;
A_absolute_max{3, 3} = A3;
assert(isequal(g_absolute_max.get('A'), A_absolute_max), ...
    [BRAPH2.STR ':MultilayerBU:' BRAPH2.FAIL_TEST], ...
    'MultilayerBU is not constructing well.')

g_absolute_sum = MultilayerBU('B', B, 'SEMIPOSITIVIZE_RULE', 'absolute', 'SYMMETRIZE_RULE', 'sum');
A1 = dediagonalize(B1 + B1' ~= 0);
A2 = dediagonalize(B2 + B2' ~= 0);
A3 = dediagonalize(B3 + B3' ~= 0);
A_absolute_max{1, 1} = A1;
A_absolute_max{2, 2} = A2;
A_absolute_max{3, 3} = A3;
assert(isequal(g_absolute_sum.get('A'), A_absolute_max), ...
    [BRAPH2.STR ':MultilayerBU:' BRAPH2.FAIL_TEST], ...
    'MultilayerBU is not constructing well.')

g_absolute_average = MultilayerBU('B', B, 'SEMIPOSITIVIZE_RULE', 'absolute', 'SYMMETRIZE_RULE', 'average');
A1 = dediagonalize((B1 + B1') / 2~= 0);
A2 = dediagonalize((B2 + B2') / 2~= 0);
A3 = dediagonalize((B3 + B3') / 2~= 0);
A_absolute_average{1, 1} = A1;
A_absolute_average{2, 2} = A2;
A_absolute_average{3, 3} = A3;
assert(isequal(g_absolute_average.get('A'), A_absolute_average), ...
    [BRAPH2.STR ':MultilayerBU:' BRAPH2.FAIL_TEST], ...
    'MultilayerBU is not constructing well.')

g_absolute_min = MultilayerBU('B', B, 'SEMIPOSITIVIZE_RULE', 'absolute', 'SYMMETRIZE_RULE', 'min');
A1 = dediagonalize(min(B1, B1') ~= 0);
A2 = dediagonalize(min(B2, B2') ~= 0);
A3 = dediagonalize(min(B3, B3') ~= 0);
A_absolute_min{1, 1} = A1;
A_absolute_min{2, 2} = A2;
A_absolute_min{3, 3} = A3;
assert(isequal(g_absolute_min.get('A'), A_absolute_min), ...
    [BRAPH2.STR ':MultilayerBU:' BRAPH2.FAIL_TEST], ...
    'MultilayerBU is not constructing well.')

%% ¡_props!

%%% ¡_prop!
ATTEMPTSPEREDGE (parameter, scalar) is the attempts to rewire each edge.
%%%% ¡_default!
5

%%% ¡_prop!
NUMBEROFWEIGHTS (parameter, scalar) specifies the number of weights sorted at the same time.
%%%% ¡_default!
10

%% ¡_methods!
function random_g = randomize(g)
    % RANDOMIZE returns a randomized graph
    %
    % RANDOMIZED_G = RANDOMIZE(G) returns the randomized
    % graph RANDOM_G obtained with a randomized correlation
    % matrix via the static function randomize_A while preserving
    % degree distributions. The randomization it is done layer by
    % layer and then integrated in the 2-D supra-adjacency matrix
    % cell array.
    %
    % RANDOMIZED_G = RANDOMIZE(G, 'AttemptsPerEdge', VALUE)
    % returns the randomized graph RANDOM_G obtained with a
    % randomized correlation matrix via the static function
    % randomize_A while preserving  degree distributions.
    % The multilayer is randomized layer by layer where randomized
    % adjacency matrix of each layer are then integrated in the
    % 2-D supra-adjacency matrix cell array.
    %
    % See also GraphBD

    % get rules
    attempts_per_edge = g.get('ATTEMPTSPEREDGE');

    if nargin<2
        attempts_per_edge = 5;
    end

    % get A
    A = g.get('A');
    L = g.layernumber();
    random_multi_A = cell(1, L);

    for li = 1:1:L
        Aii = A{li, li};
        random_A = GraphBU.randomize_A(Aii, attempts_per_edge);
        random_multi_A(li) = {random_A};
    end
    random_g = MultilayerBU('B', random_multi_A);
end