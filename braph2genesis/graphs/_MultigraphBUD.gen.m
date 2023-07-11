%% ¡header!
MultigraphBUD < GraphWU (g, binary undirected multigraph with fixed densities) is a binary undirected multigraph with fixed densities.

%%% ¡description!
In a binary undirected multigraph with fixed densities, all the layers 
 consist of binary undirected (BU) graphs derived from the same weighted 
 connectivity matrix binarized at different densities.
There are no connections between layers.

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
MultigraphBUD.ID
%%%% ¡title!
Graph ID

%%% ¡prop!
%%%% ¡id!
MultigraphBUD.LABEL
%%%% ¡title!
Graph NAME

%%% ¡prop!
%%%% ¡id!
MultigraphBUD.LAYERTICKS
%%%% ¡title!
LAYERS ticks

%%% ¡prop!
%%%% ¡id!
MultigraphBUD.LAYERLABELS
%%%% ¡title!
LAYERS labels

%%% ¡prop!
%%%% ¡id!
MultigraphBUD.NODELABELS
%%%% ¡title!
NODES labels

%%% ¡prop!
%%%% ¡id!
MultigraphBUD.B
%%%% ¡title!
Input ADJACENCY MATRIX

%%% ¡prop!
%%%% ¡id!
MultigraphBUD.SYMMETRIZE_RULE
%%%% ¡title!
SYMMETRIZATION RULE

%%% ¡prop!
%%%% ¡id!
MultigraphBUD.SEMIPOSITIVIZE_RULE
%%%% ¡title!
NEGATIVE EDGE RULE

%%% ¡prop!
%%%% ¡id!
MultigraphBUD.STANDARDIZE_RULE
%%%% ¡title!
NORMALIZATION RULE

%%% ¡prop!
%%%% ¡id!
MultigraphBUD.DENSITIES
%%%% ¡title!
DENSITIES [0% ... 100%]

%%% ¡prop!
%%%% ¡id!
MultigraphBUD.A
%%%% ¡title!
Binary Undirected ADJACENCY MATRICES at fixed Densities

%%% ¡prop!
%%%% ¡id!
MultigraphBUD.PFGA
%%%% ¡title!
Adjacency Matrix Plot

%%% ¡prop!
%%%% ¡id!
MultigraphBUD.PFGH
%%%% ¡title!
Graph Histogram

%%% ¡prop!
%%%% ¡id!
MultigraphBUD.M_DICT
%%%% ¡title!
Graph MEASURES

%%% ¡prop!
%%%% ¡id!
MultigraphBUD.NOTES
%%%% ¡title!
Graph NOTES

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the binary undirected multigraph with fixed densities.
%%%% ¡default!
'MultigraphBUD'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the binary undirected multigraph with fixed densities.
%%%% ¡default!
'In a binary undirected multigraph with fixed densities, all the layers consist of binary undirected (BU) graphs derived from the same weighted connectivity matrix binarized at different densities. There are no connections between layers.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the binary undirected multigraph with fixed densities.
%%%% ¡settings!
'MultigraphBUD'

%%% ¡prop!
ID (data, string) is a few-letter code for the binary undirected multigraph with fixed densities.
%%%% ¡default!
'MultigraphBUD ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the binary undirected multigraph with fixed densities.
%%%% ¡default!
'MultigraphBUD label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the binary undirected multigraph with fixed densities.
%%%% ¡default!
'MultigraphBUD notes'

%%% ¡prop!
GRAPH_TYPE (constant, matrix) returns the graph type __Graph.MULTIGRAPH__.
%%%% ¡default!
Graph.MULTIGRAPH

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
SELFCONNECTIVITY_TYPE (query, smatrix) returns the self-connectivity type __Graph.NONSELFCONNECTED__ * ones(layernumber).
%%%% ¡calculate!
if isempty(varargin)
    layernumber = 1;
else
    layernumber = varargin{1};
end
value = Graph.NONSELFCONNECTED * ones(layernumber);

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
A (result, cell) is the cell array with the symmetric binary adjacency matrices of the binary undirected multigraph.
%%%% ¡calculate!
A_WU = calculateValue@GraphWU(g, prop);

densities = g.get('DENSITIES');
A = cell(length(densities));

if ~isempty(cell2mat(A_WU))
    for i = 1:1:length(densities)
        density = densities(i);
        A{i, i} = dediagonalize(binarize(cell2mat(A_WU), 'density', density));
    end
end

value = A;
%%%% ¡gui!
pr = PanelPropCell('EL', g, 'PROP', MultigraphBUD.A, ...
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
    alayerlabels = cellfun(@(x) [num2str(x) '%'], num2cell(g.get('DENSITIES')), 'uniformoutput', false);
end
value = alayerlabels;

%%% ¡prop!
COMPATIBLE_MEASURES (constant, classlist) is the list of compatible measures.
%%%% ¡default!
getCompatibleMeasures('MultigraphBUD')

%% ¡props!

%%% ¡prop!
DENSITIES (parameter, rvector) is the vector of densities.
%%%% ¡gui!
pr = PanelPropRVectorSmart('EL', g, 'PROP', MultigraphBUD.DENSITIES, 'MAX', 100, 'MIN', 0, varargin{:});

%% ¡tests!

%%% ¡excluded_props!
[MultigraphBUD.PFGA MultigraphBUD.PFGH]

%%% ¡test!
%%%% ¡name!
Constructor - Empty
%%%% ¡probability!
.01
%%%% ¡code!

% 1
B = [];
g = MultigraphBUD('B', B, 'DENSITIES', []);

g.get('A_CHECK')

A = {};
assert(isequal(g.get('A'), A), ...
    [BRAPH2.STR ':MultigraphBUD:' BRAPH2.FAIL_TEST], ...
    'MultigraphBUD is not constructing well.')

% 2
B = [];
g = MultigraphBUD('B', B, 'DENSITIES', [0 55 100]);

g.get('A_CHECK')

A = g.get('A');
assert(isequal(A{1, 1}, []) && isequal(A{2, 2}, []) && isequal(A{3, 3}, []), ...
    [BRAPH2.STR ':MultigraphBUD:' BRAPH2.FAIL_TEST], ...
    'MultigraphBUD is not constructing well.')

% 3
B = [
     0 .1 .2 .3 .4
    .1  0 .5 .6 .7
    .2 .5  0 .8 .9
    .3 .6 .8  0  1
    .4 .7 .9  1  0
    ];
g = MultigraphBUD('B', B, 'DENSITIES', []);

g.get('A_CHECK')
A = {};
assert(isequal(g.get('A'), A), ...
    [BRAPH2.STR ':MultigraphBUD:' BRAPH2.FAIL_TEST], ...
    'MultigraphBUD is not constructing well.')

%%% ¡test!
%%%% ¡name!
Constructor - Full
%%%% ¡probability!
.01
%%%% ¡code!
B = [
     0 .1 .2 .3 .4
    .1  0 .5 .6 .7
    .2 .5  0 .8 .9
    .3 .6 .8  0  1
    .4 .7 .9  1  0
    ];
g = MultigraphBUD('B', B, 'DENSITIES', [0 55 100]);

g.get('A_CHECK')

A = g.get('A');
assert(isequal( ...
    A{1, 1}, ...
    [
    0 0 0 0 0
    0 0 0 0 0
    0 0 0 0 0
    0 0 0 0 0
    0 0 0 0 0
    ]) ...
    && ...
    isequal( ...
    A{2, 2}, ...
    [
    0 0 0 0 0
    0 0 0 1 1
    0 0 0 1 1
    0 1 1 0 1
    0 1 1 1 0
    ]) ...
    && ...
    isequal( ...
    A{3, 3}, ...
    [
    0 1 1 1 1
    1 0 1 1 1
    1 1 0 1 1
    1 1 1 0 1
    1 1 1 1 0
    ]), ...
    [BRAPH2.STR ':MultigraphBUD:' BRAPH2.FAIL_TEST], ...
    'MultigraphBUD is not constructing well.')