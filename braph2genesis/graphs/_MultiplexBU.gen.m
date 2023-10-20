%% ¡header!
MultiplexBU < Graph (g, multiplex binary undirected graph) is a multiplex binary undirected graph.

%%% ¡description!
In a multiplex binary undirected (BU) graph, all layers have the same number 
 of nodes with within-layer undirected edges either 0 (absence of connection) 
 or 1 (existence of connection).
The connectivity matrices are symmetric.
There are connections between layers connecting the corresponding nodes.

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
MultiplexBU.ID
%%%% ¡title!
Graph ID

%%% ¡prop!
%%%% ¡id!
MultiplexBU.LABEL
%%%% ¡title!
Graph NAME

%%% ¡prop!
%%%% ¡id!
MultiplexBU.LAYERTICKS
%%%% ¡title!
LAYERS ticks

%%% ¡prop!
%%%% ¡id!
MultiplexBU.LAYERLABELS
%%%% ¡title!
LAYERS labels

%%% ¡prop!
%%%% ¡id!
MultiplexBU.NODELABELS
%%%% ¡title!
NODES labels

%%% ¡prop!
%%%% ¡id!
MultiplexBU.B
%%%% ¡title!
Input ADJACENCY MATRIX

%%% ¡prop!
%%%% ¡id!
MultiplexBU.SYMMETRIZE_RULE
%%%% ¡title!
SYMMETRIZATION RULE

%%% ¡prop!
%%%% ¡id!
MultiplexBU.SEMIPOSITIVIZE_RULE
%%%% ¡title!
NEGATIVE EDGE RULE

%%% ¡prop!
%%%% ¡id!
MultiplexBU.RANDOMIZE
%%%% ¡title!
RANDOMIZATION ON/OFF

%%% ¡prop!
%%%% ¡id!
MultiplexBU.RANDOM_SEED
%%%% ¡title!
RANDOMIZATION SEED

%%% ¡prop!
%%%% ¡id!
MultiplexBU.ATTEMPTSPEREDGE
%%%% ¡title!
RANDOMIZATION ATTEMPTS PER EDGE

%%% ¡prop!
%%%% ¡id!
MultiplexBU.A
%%%% ¡title!
Binary Undirected ADJACENCY MATRICES

%%% ¡prop!
%%%% ¡id!
MultiplexBU.PFGA
%%%% ¡title!
Adjacency Matrix Plot

%%% ¡prop!
%%%% ¡id!
MultiplexBU.PFGH
%%%% ¡title!
Graph Histogram

%%% ¡prop!
%%%% ¡id!
MultiplexBU.M_DICT
%%%% ¡title!
Graph MEASURES

%%% ¡prop!
%%%% ¡id!
MultiplexBU.NOTES
%%%% ¡title!
Graph NOTES

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the multiplex binary undirected graph.
%%%% ¡default!
'MultiplexBU'

%%% ¡prop!
NAME (constant, string) is the name of the multiplex binary undirected graph.
%%%% ¡default!
'MultiplexBU'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the multiplex binary undirected graph.
%%%% ¡default!
'In a multiplex binary undirected (BU) graph, all layers have the same number of nodes with within-layer undirected edges either 0 (absence of connection) or 1 (existence of connection). The connectivity matrices are symmetric. There are connections between layers connecting the corresponding nodes.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the multiplex binary undirected graph.
%%%% ¡settings!
'MultiplexBU'

%%% ¡prop!
ID (data, string) is a few-letter code for the multiplex binary undirected graph.
%%%% ¡default!
'MultiplexBU ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the multiplex binary undirected graph.
%%%% ¡default!
'MultiplexBU label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the multiplex binary undirected graph.
%%%% ¡default!
'MultiplexBU notes'

%%% ¡prop!
GRAPH_TYPE (constant, scalar) returns the graph type __Graph.MULTIPLEX__.
%%%% ¡default!
Graph.MULTIPLEX

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
A (result, cell) is the cell containing the multiplex binary adjacency matrices of the multiplex binary undirected graph.
%%%% ¡calculate!
B = g.get('B'); %#ok<PROPLC>
L = length(B); %#ok<PROPLC> % number of layers
A = cell(L, L);

for i = 1:1:L
    M = symmetrize(B{i}, 'SymmetrizeRule', g.get('SYMMETRIZE_RULE')); %#ok<PROPLC> % enforces symmetry of adjacency matrix
    M = dediagonalize(M); % removes self-connections by removing diagonal from adjacency matrix, equivalent to dediagonalize(M, 'DediagonalizeRule', 0)
    M = semipositivize(M, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
    M = binarize(M); % enforces binary adjacency matrix, equivalent to binarize(M, 'threshold', 0, 'bins', [-1:.001:1])
    A(i, i) = {M};
    if ~isempty(A{1, 1})
        for j = i+1:1:L
            A(i, j) = {eye(length(A{1, 1}))};
            A(j, i) = {eye(length(A{1, 1}))};
        end
    end
end
if g.get('RANDOMIZE')
    A = g.get('RANDOMIZATION', A);
end
value = A;
%%%% ¡gui!
pr = PanelPropCell('EL', g, 'PROP', MultiplexBU.A, ...
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
ALAYERLABELS (query, stringlist) returns the layer labels to be used by the slider.
%%%% ¡calculate!
alayerlabels = g.get('LAYERLABELS');
if isempty(alayerlabels) && ~isa(g.getr('A'), 'NoValue') % ensures that it's not unecessarily calculated
    alayerlabels = cellfun(@num2str, num2cell([1:1:g.get('LAYERNUMBER')]), 'uniformoutput', false);
end
value = alayerlabels;

%%% ¡prop!
COMPATIBLE_MEASURES (constant, classlist) is the list of compatible measures.
%%%% ¡default!
getCompatibleMeasures('MultiplexBU')

%% ¡props!

%%% ¡prop!
B (data, cell) is the input cell containing the multiplex adjacency matrices on the diagonal.
%%%% ¡default!
{[] []}
%%%% ¡gui!
pr = PanelPropCell('EL', g, 'PROP', MultiplexBU.B, ...
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

%%% ¡prop!
ATTEMPTSPEREDGE (parameter, scalar) is the attempts to rewire each edge.
%%%% ¡default!
5

%%% ¡prop!
RANDOMIZATION (query, cell) performs the randomization of a connectivity matrix.
%%%% ¡calculate!
rng(g.get('RANDOM_SEED'), 'twister')

if isempty(varargin)
    value = {};
    return
end

A = varargin{1};
attempts_per_edge = g.get('ATTEMPTSPEREDGE');

for i = 1:length(A)
    tmp_a = A{i,i};

    tmp_g = GraphBU();
    tmp_g.set('ATTEMPTSPEREDGE', g.get('ATTEMPTSPEREDGE'));
    random_A = tmp_g.get('RANDOMIZATION', {tmp_a});
    A{i, i} = random_A;
end
value = A;

%% ¡tests!

%%% ¡excluded_props!
[MultiplexBU.PFGA MultiplexBU.PFGH]

%%% ¡test!
%%%% ¡name!
Constructor - Full
%%%% ¡probability!
.01
%%%% ¡code!
B1 = rand(randi(10));
B = {B1, B1, B1};
g = MultiplexBU('B', B);

g.get('A_CHECK')

A1 = symmetrize(binarize(semipositivize(dediagonalize(B1))));
A = {
    A1              eye(length(A1)) eye(length(A1))
    eye(length(A1)) A1              eye(length(A1))
    eye(length(A1)) eye(length(A1)) A1
    };
assert(isequal(g.get('A'), A), ...
    [BRAPH2.STR ':MultiplexBU:' BRAPH2.FAIL_TEST], ...
    'MultiplexBU is not constructing well.')

%%% ¡test!
%%%% ¡name!
Symmetrize and Semipositivize Rules
%%%% ¡probability!
.01
%%%% ¡code!
B = randn(randi(10));

g0 = MultiplexBU('B', {B, B, B}); % 'SEMIPOSITIVIZE_RULE', 'zero', 'SYMMETRIZE_RULE', 'max'
A = dediagonalize(max(B, B') > 0);
A0 = {
    A               eye(length(B))  eye(length(B))
    eye(length(B))  A               eye(length(B))
    eye(length(B))  eye(length(B))  A
    };
assert(isequal(g0.get('A'), A0), ...
    [BRAPH2.STR ':MultiplexBU:' BRAPH2.FAIL_TEST], ...
    'MultiplexBU is not constructing well.')

g_max = MultiplexBU('B', {B, B, B}, 'SYMMETRIZE_RULE', 'max'); % 'SEMIPOSITIVIZE_RULE', 'zero'
A = dediagonalize(max(B, B') > 0);
A_max = {
    A               eye(length(B))  eye(length(B))
    eye(length(B))  A               eye(length(B))
    eye(length(B))  eye(length(B))  A
    };
assert(isequal(g_max.get('A'), A_max), ...
    [BRAPH2.STR ':MultiplexBU:' BRAPH2.FAIL_TEST], ...
    'MultiplexBU is not constructing well.')

g_sum = MultiplexBU('B', {B, B, B}, 'SYMMETRIZE_RULE', 'sum'); % 'SEMIPOSITIVIZE_RULE', 'zero'
A = dediagonalize(B + B' > 0);
A_sum = {
    A               eye(length(B))  eye(length(B))
    eye(length(B))  A               eye(length(B))
    eye(length(B))  eye(length(B))  A
    };
assert(isequal(g_sum.get('A'), A_sum), ...
    [BRAPH2.STR ':MultiplexBU:' BRAPH2.FAIL_TEST], ...
    'MultiplexBU is not constructing well.')

g_average = MultiplexBU('B', {B, B, B}, 'SYMMETRIZE_RULE', 'average'); % 'SEMIPOSITIVIZE_RULE', 'zero'
A = dediagonalize((B + B') / 2 > 0);
A_average = {
    A               eye(length(B))  eye(length(B))
    eye(length(B))  A               eye(length(B))
    eye(length(B))  eye(length(B))  A
    };
assert(isequal(g_average.get('A'), A_average), ...
    [BRAPH2.STR ':MultiplexBU:' BRAPH2.FAIL_TEST], ...
    'MultiplexBU is not constructing well.')

g_min = MultiplexBU('B', {B, B, B}, 'SYMMETRIZE_RULE', 'min'); % 'SEMIPOSITIVIZE_RULE', 'zero'
A = dediagonalize(min(B, B') > 0);
A_min = {
    A               eye(length(B))  eye(length(B))
    eye(length(B))  A               eye(length(B))
    eye(length(B))  eye(length(B))  A
    };
assert(isequal(g_min.get('A'), A_min), ...
    [BRAPH2.STR ':MultiplexBU:' BRAPH2.FAIL_TEST], ...
    'MultiplexBU is not constructing well.')

g_zero = MultiplexBU('B', {B, B, B}, 'SEMIPOSITIVIZE_RULE', 'zero'); % 'SYMMETRIZE_RULE', 'max'
A = dediagonalize(max(B, B') > 0);
A_zero = {
    A               eye(length(B))  eye(length(B))
    eye(length(B))  A               eye(length(B))
    eye(length(B))  eye(length(B))  A
    };
assert(isequal(g_zero.get('A'), A_zero), ...
    [BRAPH2.STR ':MultiplexBU:' BRAPH2.FAIL_TEST], ...
    'MultiplexBU is not constructing well.')

g_zero_max = MultiplexBU('B', {B, B, B}, 'SEMIPOSITIVIZE_RULE', 'zero', 'SYMMETRIZE_RULE', 'max');
A = dediagonalize(max(B, B') > 0);
A_zero_max = {
    A               eye(length(B))  eye(length(B))
    eye(length(B))  A               eye(length(B))
    eye(length(B))  eye(length(B))  A
    };
assert(isequal(g_zero_max.get('A'), A_zero_max), ...
    [BRAPH2.STR ':MultiplexBU:' BRAPH2.FAIL_TEST], ...
    'MultiplexBU is not constructing well.')

g_zero_sum = MultiplexBU('B', {B, B, B}, 'SEMIPOSITIVIZE_RULE', 'zero', 'SYMMETRIZE_RULE', 'sum');
A = dediagonalize(B + B' > 0);
A_zero_sum = {
    A               eye(length(B))  eye(length(B))
    eye(length(B))  A               eye(length(B))
    eye(length(B))  eye(length(B))  A
    };
assert(isequal(g_zero_sum.get('A'), A_zero_sum), ...
    [BRAPH2.STR ':MultiplexBU:' BRAPH2.FAIL_TEST], ...
    'MultiplexBU is not constructing well.')

g_zero_average = MultiplexBU('B', {B, B, B}, 'SEMIPOSITIVIZE_RULE', 'zero', 'SYMMETRIZE_RULE', 'average');
A = dediagonalize((B + B') / 2 > 0);
A_zero_average = {
    A               eye(length(B))  eye(length(B))
    eye(length(B))  A               eye(length(B))
    eye(length(B))  eye(length(B))  A
    };
assert(isequal(g_zero_average.get('A'), A_zero_average), ...
    [BRAPH2.STR ':MultiplexBU:' BRAPH2.FAIL_TEST], ...
    'MultiplexBU is not constructing well.')

g_zero_min = MultiplexBU('B', {B, B, B}, 'SEMIPOSITIVIZE_RULE', 'zero', 'SYMMETRIZE_RULE', 'min');
A = dediagonalize(min(B, B') > 0);
A_zero_min = {
    A               eye(length(B))  eye(length(B))
    eye(length(B))  A               eye(length(B))
    eye(length(B))  eye(length(B))  A
    };
assert(isequal(g_zero_min.get('A'), A_zero_min), ...
    [BRAPH2.STR ':MultiplexBU:' BRAPH2.FAIL_TEST], ...
    'MultiplexBU is not constructing well.')

g_absolute = MultiplexBU('B', {B, B, B}, 'SEMIPOSITIVIZE_RULE', 'absolute'); % 'SYMMETRIZE_RULE', 'max'
A = dediagonalize(max(B, B') ~= 0);
A_absolute = {
    A               eye(length(B))  eye(length(B))
    eye(length(B))  A               eye(length(B))
    eye(length(B))  eye(length(B))  A
    };
assert(isequal(g_absolute.get('A'), A_absolute), ...
    [BRAPH2.STR ':MultiplexBU:' BRAPH2.FAIL_TEST], ...
    'MultiplexBU is not constructing well.')

g_absolute_max = MultiplexBU('B', {B, B, B}, 'SEMIPOSITIVIZE_RULE', 'absolute', 'SYMMETRIZE_RULE', 'max');
A = dediagonalize(max(B, B') ~= 0);
A_absolute_max = {
    A               eye(length(B))  eye(length(B))
    eye(length(B))  A               eye(length(B))
    eye(length(B))  eye(length(B))  A
    };
assert(isequal(g_absolute_max.get('A'), A_absolute_max), ...
    [BRAPH2.STR ':MultiplexBU:' BRAPH2.FAIL_TEST], ...
    'MultiplexBU is not constructing well.')

g_absolute_sum = MultiplexBU('B', {B, B, B}, 'SEMIPOSITIVIZE_RULE', 'absolute', 'SYMMETRIZE_RULE', 'sum');
A = dediagonalize(B + B' ~= 0);
A_absolute_sum = {
    A               eye(length(B))  eye(length(B))
    eye(length(B))  A               eye(length(B))
    eye(length(B))  eye(length(B))  A
    };
assert(isequal(g_absolute_sum.get('A'), A_absolute_sum), ...
    [BRAPH2.STR ':MultiplexBU:' BRAPH2.FAIL_TEST], ...
    'MultiplexBU is not constructing well.')

g_absolute_average = MultiplexBU('B', {B, B, B}, 'SEMIPOSITIVIZE_RULE', 'absolute', 'SYMMETRIZE_RULE', 'average');
A = dediagonalize((B + B') / 2~= 0);
A_absolute_average = {
    A               eye(length(B))  eye(length(B))
    eye(length(B))  A               eye(length(B))
    eye(length(B))  eye(length(B))  A
    };
assert(isequal(g_absolute_average.get('A'), A_absolute_average), ...
    [BRAPH2.STR ':MultiplexBU:' BRAPH2.FAIL_TEST], ...
    'MultiplexBU is not constructing well.')

g_absolute_min = MultiplexBU('B', {B, B, B}, 'SEMIPOSITIVIZE_RULE', 'absolute', 'SYMMETRIZE_RULE', 'min');
A = dediagonalize(min(B, B') ~= 0);
A_absolute_min = {
    A               eye(length(B))  eye(length(B))
    eye(length(B))  A               eye(length(B))
    eye(length(B))  eye(length(B))  A
    };
assert(isequal(g_absolute_min.get('A'), A_absolute_min), ...
    [BRAPH2.STR ':MultiplexBU:' BRAPH2.FAIL_TEST], ...
    'MultiplexBU is not constructing well.')


%%% ¡test!
%%%% ¡name!
Randomize Rules
%%%% ¡probability!
.01
%%%% ¡code!
B1 = randn(10);
B = {B1, B1, B1};

g = MultiplexBU('B', B);
g.set('RANDOMIZE', true);
g.set('ATTEMPTSPEREDGE', 4);
g.get('A_CHECK')

A = g.get('A');

assert(isequal(size(A{1}), size(B{1})), ...
    [BRAPH2.STR ':MultiplexBU:' BRAPH2.FAIL_TEST], ...
    'MultiplexBU Randomize is not functioning well.')

g2 = MultiplexBU('B', B);
g2.set('RANDOMIZE', false);
g2.set('ATTEMPTSPEREDGE', 4);
g2.get('A_CHECK')

A2 = g2.get('A');
random_A = g2.get('RANDOMIZATION', A2);

for i = 1:length(A2)
    if all(A2{i, i}==0, "all") %if all nodes are zero, the random matrix is also all zeros
        assert(isequal(A2{i, i}, random_A{i, i}), ...
            [BRAPH2.STR ':MultiplexBU:' BRAPH2.FAIL_TEST], ...
            'MultiplexBU Randomize is not functioning well.')
    elseif isequal((length(A2{i, i}).^2)- length(A2{i, i}), sum(A2{i, i}==1, "all")) %if all nodes (except diagonal) are one, the random matrix is the same as original
        assert(isequal(A2{i, i}, random_A{i, i}), ...
            [BRAPH2.STR ':MultiplexBU:' BRAPH2.FAIL_TEST], ...
            'MultiplexBU Randomize is not functioning well.')
    else
%         assert(~isequal(A2{i, i}, random_A{i, i}), ...
%             [BRAPH2.STR ':MultiplexBU:' BRAPH2.FAIL_TEST], ...
%             'MultiplexBU Randomize is not functioning well.')
    end

    assert(isequal(numel(find(A2{i, i})), numel(find(random_A{i, i}))), ... % check same number of nodes
        [BRAPH2.STR ':MultiplexBU:' BRAPH2.FAIL_TEST], ...
        'MultiplexBU Randomize is not functioning well.')
        
    assert(issymmetric(random_A{i, i}), ... % check symmetry 
    [BRAPH2.STR ':MultiplexBU:' BRAPH2.FAIL_TEST], ...
    'MultiplexBU Randomize is not functioning well.')
end