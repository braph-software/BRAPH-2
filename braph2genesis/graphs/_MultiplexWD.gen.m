%% ¡header!
MultiplexWD < Graph (g, multiplex weighted directed graph) is a multiplex weighted directed graph.

%%% ¡description!
In a multiplex weighted directed (WD) graph, all layers have the same number 
 of nodes with within-layer weighted directed edges, associated with a real 
 number between 0 and 1 and indicating the strength of the connection.
There are connections between layers connecting the corresponding nodes.

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
MultiplexWD.ID
%%%% ¡title!
Graph ID

%%% ¡prop!
%%%% ¡id!
MultiplexWD.LABEL
%%%% ¡title!
Graph NAME

%%% ¡prop!
%%%% ¡id!
MultiplexWD.LAYERTICKS
%%%% ¡title!
LAYERS ticks

%%% ¡prop!
%%%% ¡id!
MultiplexWD.LAYERLABELS
%%%% ¡title!
LAYERS labels

%%% ¡prop!
%%%% ¡id!
MultiplexWD.NODELABELS
%%%% ¡title!
NODES labels

%%% ¡prop!
%%%% ¡id!
MultiplexWD.B
%%%% ¡title!
Input ADJACENCY MATRIX

%%% ¡prop!
%%%% ¡id!
MultiplexWD.SEMIPOSITIVIZE_RULE
%%%% ¡title!
NEGATIVE EDGE RULE

%%% ¡prop!
%%%% ¡id!
MultiplexWD.STANDARDIZE_RULE
%%%% ¡title!
NORMALIZATION RULE

%%% ¡prop!
%%%% ¡id!
MultiplexWD.A
%%%% ¡title!
Weighted Directed ADJACENCY MATRICES

%%% ¡prop!
%%%% ¡id!
MultiplexWD.PFGA
%%%% ¡title!
Adjacency Matrix Plot

%%% ¡prop!
%%%% ¡id!
MultiplexWD.PFGH
%%%% ¡title!
Graph Histogram

%%% ¡prop!
%%%% ¡id!
MultiplexWD.M_DICT
%%%% ¡title!
Graph MEASURES

%%% ¡prop!
%%%% ¡id!
MultiplexWD.NOTES
%%%% ¡title!
Graph NOTES

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the multiplex weighted directed graph.
%%%% ¡default!
'MultiplexWD'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the multiplex weighted directed graph.
%%%% ¡default!
'In a multiplex weighted directed (WD) graph, all layers have the same number of nodes with within-layer weighted directed edges, associated with a real number between 0 and 1 and indicating the strength of the connection. There are connections between layers connecting the corresponding nodes.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the multiplex weighted directed graph.
%%%% ¡settings!
'MultiplexWD'

%%% ¡prop!
ID (data, string) is a few-letter code for the multiplex weighted directed graph.
%%%% ¡default!
'MultiplexWD ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the multiplex weighted directed graph.
%%%% ¡default!
'MultiplexWD label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the multiplex weighted directed graph.
%%%% ¡default!
'MultiplexWD notes'

%%% ¡prop!
GRAPH_TYPE (constant, scalar) returns the graph type __Graph.MULTIPLEX__.
%%%% ¡default!
Graph.MULTIPLEX

%%% ¡prop!
CONNECTIVITY_TYPE (query, smatrix) returns the connectivity type __Graph.WEIGHTED__ * ones(layernumber).
%%%% ¡calculate!
if isempty(varargin)
    layernumber = 1;
else
    layernumber = varargin{1};
end
value = Graph.WEIGHTED * ones(layernumber);

%%% ¡prop!
DIRECTIONALITY_TYPE (query, smatrix) returns the directionality type __Graph.DIRECTED__ * ones(layernumber).
%%%% ¡calculate!
if isempty(varargin)
    layernumber = 1;
else
    layernumber = varargin{1};
end
value = Graph.DIRECTED * ones(layernumber);

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
A (result, cell) is the cell containing the multiplex weighted adjacency matrices of the multiplex weighted directed graph.
%%%% ¡calculate!
B = g.get('B'); %#ok<PROPLC>
L = length(B); %#ok<PROPLC> % number of layers
A = cell(L, L);

for i = 1:1:L
    M = dediagonalize(B{i}); %#ok<PROPLC> % removes self-connections by removing diagonal from adjacency matrix, equivalent to dediagonalize(B{i}, 'DediagonalizeRule', 0)
    M = semipositivize(M, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
    M = standardize(M, 'StandardizeRule', g.get('STANDARDIZE_RULE')); % enforces binary adjacency matrix
    A(i, i) = {M};
    if ~isempty(A{1, 1})
        for j = i+1:1:L
            A(i, j) = {eye(length(A{1, 1}))};
            A(j, i) = {eye(length(A{1, 1}))};
        end
    end
end

value = A;
%%%% ¡gui!
pr = PanelPropCell('EL', g, 'PROP', MultiplexWD.A, ...
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
ALAYERLABELS (query, stringlist) returns the layer labels for A.
%%%% ¡calculate!
alayerlabels = g.get('LAYERLABELS');
if isempty(alayerlabels) && ~isa(g.getr('A'), 'NoValue') % ensures that it's not unecessarily calculated
    alayerlabels = cellfun(@num2str, num2cell([1:1:g.get('LAYERNUMBER')]), 'uniformoutput', false);
end
value = alayerlabels;

%%% ¡prop!
COMPATIBLE_MEASURES (constant, classlist) is the list of compatible measures.
%%%% ¡default!
getCompatibleMeasures('MultiplexWD')

%% ¡props!

%%% ¡prop!
B (data, cell) is the input cell containing the multiplex adjacency matrices on the diagonal.
%%%% ¡default!
{[] []}
%%%% ¡gui!
pr = PanelPropCell('EL', g, 'PROP', MultiplexWD.B, ...
    'TABLE_HEIGHT', s(40), ...
    'XSLIDERSHOW', true, ...
    'XSLIDERLABELS', g.get('ALAYERLABELS'), ...
    'XSLIDERHEIGHT', s(3.5), ...
    'YSLIDERSHOW', false, ...
    'ROWNAME', g.getCallback('ANODELABELS'), ...
    'COLUMNNAME', g.getCallback('ANODELABELS'), ...
    varargin{:});

%%% ¡prop!
SEMIPOSITIVIZE_RULE (parameter, option) determines how to remove the negative edges.
%%%% ¡settings!
{'zero', 'absolute'}

%%% ¡prop!
STANDARDIZE_RULE (parameter, option) determines how to normalize the weights between 0 and 1.
%%%% ¡settings!
{'threshold' 'range'}

%% ¡tests!

%%% ¡excluded_props!
[MultiplexWD.PFGA MultiplexWD.PFGH]

%%% ¡test!
%%%% ¡name!
Constructor - Full
%%%% ¡probability!
.01
%%%% ¡code!
B1 = rand(randi(10));
B = {B1, B1, B1};
g = MultiplexWD('B', B);

g.get('A_CHECK')

A1 = standardize(semipositivize(dediagonalize(B1)));
A = {
    A1              eye(length(A1)) eye(length(A1))
    eye(length(A1)) A1              eye(length(A1))
    eye(length(A1)) eye(length(A1)) A1
    };
assert(isequal(g.get('A'), A), ...
    [BRAPH2.STR ':MultiplexWD:' BRAPH2.FAIL_TEST], ...
    'MultiplexWD is not constructing well.')

%%% ¡test!
%%%% ¡name!
Semipositivize and Standardize Rules
%%%% ¡probability!
.01
%%%% ¡code!
B = 10 * rand(randi(10) + 5) - 5; % random number in U(-5, 5)

g0 = MultiplexWD('B', {B, B, B}); % 'SEMIPOSITIVIZE_RULE', 'zero', 'STANDARDIZE_RULE', 'threshold'
A = B;
A(A < 0) = 0;
A(A > 1) = 1;
A = dediagonalize(A);
A0 = {
    A               eye(length(B))  eye(length(B))
    eye(length(B))  A               eye(length(B))
    eye(length(B))  eye(length(B))  A
    };
assert(isequal(g0.get('A'), A0), ...
    [BRAPH2.STR ':MultiplexWD:' BRAPH2.FAIL_TEST], ...
    'MultiplexWD is not constructing well.')

g_zero = MultiplexWD('B', {B, B, B}, 'SEMIPOSITIVIZE_RULE', 'zero'); % 'STANDARDIZE_RULE', 'threshold'
A = B;
A(A < 0) = 0;
A(A > 1) = 1;
A = dediagonalize(A);
A_zero = {
    A               eye(length(B))  eye(length(B))
    eye(length(B))  A               eye(length(B))
    eye(length(B))  eye(length(B))  A
    };
assert(isequal(g_zero.get('A'), A_zero), ...
    [BRAPH2.STR ':MultiplexWD:' BRAPH2.FAIL_TEST], ...
    'MultiplexWD is not constructing well.')

g_absolute = MultiplexWD('B', {B, B, B}, 'SEMIPOSITIVIZE_RULE', 'absolute'); % 'STANDARDIZE_RULE', 'threshold'
A = abs(B);
A(A < 0) = 0;
A(A > 1) = 1;
A = dediagonalize(A);
A_absolute = {
    A               eye(length(B))  eye(length(B))
    eye(length(B))  A               eye(length(B))
    eye(length(B))  eye(length(B))  A
    };
assert(isequal(g_absolute.get('A'), A_absolute), ...
    [BRAPH2.STR ':MultiplexWD:' BRAPH2.FAIL_TEST], ...
    'MultiplexWD is not constructing well.')

g_theresold = MultiplexWD('B', {B, B, B}, 'STANDARDIZE_RULE', 'threshold'); % 'SEMIPOSITIVIZE_RULE', 'zero'
A = B;
A(A < 0) = 0;
A(A > 1) = 1;
A = dediagonalize(A);
A_theresold = {
    A               eye(length(B))  eye(length(B))
    eye(length(B))  A               eye(length(B))
    eye(length(B))  eye(length(B))  A
    };
assert(isequal(g_theresold.get('A'), A_theresold), ...
    [BRAPH2.STR ':MultiplexWD:' BRAPH2.FAIL_TEST], ...
    'MultiplexWD is not constructing well.')

g_zero_theresold = MultiplexWD('B', {B, B, B}, 'SEMIPOSITIVIZE_RULE', 'zero', 'STANDARDIZE_RULE', 'threshold');
A = B;
A(A < 0) = 0;
A(A > 1) = 1;
A = dediagonalize(A);
A_zero_theresold = {
    A               eye(length(B))  eye(length(B))
    eye(length(B))  A               eye(length(B))
    eye(length(B))  eye(length(B))  A
    };
assert(isequal(g_zero_theresold.get('A'), A_zero_theresold), ...
    [BRAPH2.STR ':MultiplexWD:' BRAPH2.FAIL_TEST], ...
    'MultiplexWD is not constructing well.')

g_absolute_theresold = MultiplexWD('B', {B, B, B}, 'SEMIPOSITIVIZE_RULE', 'absolute', 'STANDARDIZE_RULE', 'threshold');
A = abs(B);
A(A < 0) = 0;
A(A > 1) = 1;
A = dediagonalize(A);
A_absolute_theresold = {
    A               eye(length(B))  eye(length(B))
    eye(length(B))  A               eye(length(B))
    eye(length(B))  eye(length(B))  A
    };
assert(isequal(g_absolute_theresold.get('A'), A_absolute_theresold), ...
    [BRAPH2.STR ':MultiplexWD:' BRAPH2.FAIL_TEST], ...
    'MultiplexWD is not constructing well.')

g_range = MultiplexWD('B', {B, B, B}, 'STANDARDIZE_RULE', 'range'); % 'SEMIPOSITIVIZE_RULE', 'zero'
A = dediagonalize(B);
A(A < 0) = 0;
A = A / max(max(A));
A_range = {
    A               eye(length(B))  eye(length(B))
    eye(length(B))  A               eye(length(B))
    eye(length(B))  eye(length(B))  A
    };
assert(isequal(g_range.get('A'), A_range), ...
    [BRAPH2.STR ':MultiplexWD:' BRAPH2.FAIL_TEST], ...
    'MultiplexWD is not constructing well.')

g_zero_range = MultiplexWD('B', {B, B, B}, 'SEMIPOSITIVIZE_RULE', 'zero', 'STANDARDIZE_RULE', 'range');
A = dediagonalize(B);
A(A < 0) = 0;
A = A / max(max(A));
A_zero_range = {
    A               eye(length(B))  eye(length(B))
    eye(length(B))  A               eye(length(B))
    eye(length(B))  eye(length(B))  A
    };
assert(isequal(g_zero_range.get('A'), A_zero_range), ...
    [BRAPH2.STR ':MultiplexWD:' BRAPH2.FAIL_TEST], ...
    'MultiplexWD is not constructing well.')

g_absolute_range = MultiplexWD('B', {B, B, B}, 'SEMIPOSITIVIZE_RULE', 'absolute', 'STANDARDIZE_RULE', 'range');
A = abs(B);
A = standardize(dediagonalize(A), 'StandardizeRule', 'range');
A_absolute_range = {
    A               eye(length(B))  eye(length(B))
    eye(length(B))  A               eye(length(B))
    eye(length(B))  eye(length(B))  A
    };
assert(isequal(g_absolute_range.get('A'), A_absolute_range), ...
    [BRAPH2.STR ':MultiplexWD:' BRAPH2.FAIL_TEST], ...
    'MultiplexWD is not constructing well.')









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
    % The multiplex is randomized layer by layer where randomized
    % adjacency matrix of each layer are then integrated in the
    % 2-D supra-adjacency matrix cell array.
    %
    % See also GraphBD

    % get rules
    number_of_weights = g.get('NUMBEROFWEIGHTS');
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
        random_A = GraphWD.randomize_A(Aii, attempts_per_edge, number_of_weights);
        random_multi_A(li) = {random_A};
    end
    random_g = MultiplexWD('B', random_multi_A);
end