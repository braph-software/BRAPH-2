%% ¡header!
OrdMxBUD < OrdMxWU (g, binary undirected multiplex with fixed densities) is a ordinal multiplex binary undirected with fixed densities.

%%% ¡description!
In an ordinal binary undirected multiplex with fixed densities (BUD), the layers are 
 those of binary undirected (BU) multiplex graphs derived from the same 
 weighted supra-adjacency matrices binarized at different densities.
The supra-adjacency matrix has a number of partitions equal to the number of densities.
The layers are connected in an ordinal fashion, i.e., only consecutive layers are connected.

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
OrdMxBUD.ID
%%%% ¡title!
Graph ID

%%% ¡prop!
%%%% ¡id!
OrdMxBUD.LABEL
%%%% ¡title!
Graph NAME

%%% ¡prop!
%%%% ¡id!
OrdMxBUD.LAYERTICKS
%%%% ¡title!
LAYERS ticks

%%% ¡prop!
%%%% ¡id!
OrdMxBUD.LAYERLABELS
%%%% ¡title!
LAYERS labels

%%% ¡prop!
%%%% ¡id!
OrdMxBUD.NODELABELS
%%%% ¡title!
NODES labels

%%% ¡prop!
%%%% ¡id!
OrdMxBUD.B
%%%% ¡title!
Input ADJACENCY MATRIX

%%% ¡prop!
%%%% ¡id!
OrdMxBUD.SYMMETRIZE_RULE
%%%% ¡title!
SYMMETRIZATION RULE

%%% ¡prop!
%%%% ¡id!
OrdMxBUD.SEMIPOSITIVIZE_RULE
%%%% ¡title!
NEGATIVE EDGE RULE

%%% ¡prop!
%%%% ¡id!
OrdMxBUD.STANDARDIZE_RULE
%%%% ¡title!
NORMALIZATION RULE

%%% ¡prop!
%%%% ¡id!
OrdMxBUD.DENSITIES
%%%% ¡title!
DENSITIES [0% ... 100%]

%%% ¡prop!
%%%% ¡id!
OrdMxBUD.A
%%%% ¡title!
Binary Undirected ADJACENCY MATRICES at fixed Densities

%%% ¡prop!
%%%% ¡id!
OrdMxBUD.PFGA
%%%% ¡title!
Adjacency Matrix Plot

%%% ¡prop!
%%%% ¡id!
OrdMxBUD.PFGH
%%%% ¡title!
Graph Histogram

%%% ¡prop!
%%%% ¡id!
OrdMxBUD.M_DICT
%%%% ¡title!
Graph MEASURES

%%% ¡prop!
%%%% ¡id!
OrdMxBUD.NOTES
%%%% ¡title!
Graph NOTES

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the ordinal binary undirected multiplex with fixed densities.
%%%% ¡default!
'OrdMxBUD'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the ordinal binary undirected multiplex with fixed densities.
%%%% ¡default!
'In an ordinal binary undirected multiplex with fixed densities (BUD), the layers are those of binary undirected (BU) multiplex graphs derived from the same weighted supra-adjacency matrix binarized at different densities. The supra-adjacency matrix has a number of partitions equal to the number of densities.The layers are connected in an ordinal fashion, where just consecutive layers are connected'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the ordinal binary undirected multiplex with fixed densities.
%%%% ¡settings!
'OrdMxBUD'

%%% ¡prop!
ID (data, string) is a few-letter code for the ordinal binary undirected multiplex with fixed densities.
%%%% ¡default!
'OrdMxBUD ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the ordinal binary undirected multiplex with fixed densities.
%%%% ¡default!
'OrdMxBUD label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the ordinal binary undirected multiplex with fixed densities.
%%%% ¡default!
'OrdMxBUD notes'

%%% ¡prop!
GRAPH_TYPE (constant, scalar) returns the graph type __Graph.ORDERED_MULTIPLEX__.
%%%% ¡default!
Graph.ORDERED_MULTIPLEX

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
A (result, cell) is the cell array containing the multiplex binary supra-adjacency matrices of the binary undirected multiplex. 
%%%% ¡calculate!
A_WU = calculateValue@OrdMxWU(g, prop);

densities = g.get('DENSITIES');
L = length(A_WU); % number of layers of MultiplexWU
A = cell(length(densities) * L); % the new g.layernumber() will be equal to = L*length(densities)

if L > 0 && ~isempty(cell2mat(A_WU))
    A(:, :) = {eye(length(A_WU{1, 1}))};
    for i = 1:1:length(densities)
        density = densities(i);
        layer = 1;
        for j = (i - 1) * L + 1:1:i * L
            A{j, j} = dediagonalize(binarize(A_WU{layer, layer}, 'density', density));
            layer = layer + 1;
        end
    end
end

value = A;
%%%% ¡gui!
pr = PanelPropCell('EL', g, 'PROP', OrdMxBUD.A, ...
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
l = g.get('LAYERNUMBER');
densities = g.get('DENSITIES');
value = ones(1, length(densities)) * l / length(densities);

%%% ¡prop!
ALAYERLABELS (query, stringlist) returns the layer labels for A.
%%%% ¡calculate!
alayerlabels = g.get('LAYERLABELS');
if ~isa(g.getr('A'), 'NoValue') && length(alayerlabels) ~= g.get('LAYERNUMBER') % ensures that it's not unecessarily calculated
    densities = cellfun(@(x) [num2str(x) '%'], num2cell(g.get('DENSITIES')), 'uniformoutput', false);

    if length(alayerlabels) == length(g.get('B'))
        blayerlabels = alayerlabels;
    else % includes isempty(layerlabels)
        blayerlabels = cellfun(@num2str, num2cell([1:1:length(g.get('B'))]), 'uniformoutput', false);
    end
    
    alayerlabels = {};
    for i = 1:1:length(densities)
        for j = 1:1:length(blayerlabels)
            alayerlabels = [alayerlabels, [blayerlabels{j} '|' densities{i}]];
        end
    end
end
value = alayerlabels;

%%% ¡prop!
COMPATIBLE_MEASURES (constant, classlist) is the list of compatible measures.
%%%% ¡default!
getCompatibleMeasures('OrdMxBUD')

%% ¡props!

%%% ¡prop!
DENSITIES (parameter, rvector) is the vector of densities.
%%%% ¡gui!
pr = PanelPropRVectorSmart('EL', g, 'PROP', MultiplexBUD.DENSITIES, 'MAX', 100, 'MIN', 0, varargin{:});

%% ¡tests!

%%% ¡excluded_props!
[OrdMxBUD.PFGA OrdMxBUD.PFGH]

%%% ¡test!
%%%% ¡name!
Constructor - Full
%%%% ¡probability!
.01
%%%% ¡code!
B1 = [
     0 .1 .2 .3 .4
    .1  0 .5 .6 .7
    .2 .5  0 .8 .9
    .3 .6 .8  0  1
    .4 .7 .9  1  0
    ];
B = {B1, B1, B1};
densities = [0 55 100];
g = OrdMxBUD('B', B, 'DENSITIES', [0 55 100]);

g.get('A_CHECK')

A = g.get('A');
for i = 1:1:length(B) * length(densities)
    for j = 1:1:length(B) * length(densities)
        if i == j
            density = densities(floor((i - 1) / length(B)) + 1);
            assert(isequal(A{i, i}, binarize(B1, 'density', density)), ...
                [BRAPH2.STR ':OrdMxBUD:' BRAPH2.FAIL_TEST], ...
                'OrdMxBUD is not constructing well.')
        else
            assert(isequal(A{i, j}, eye(length(B1))), ...
                [BRAPH2.STR ':OrdMxBUD:' BRAPH2.FAIL_TEST], ...
                'OrdMxBUD is not constructing well.')            
        end
    end
end
