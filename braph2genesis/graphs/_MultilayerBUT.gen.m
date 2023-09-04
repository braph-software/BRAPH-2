%% ¡header!
MultilayerBUT < MultilayerWU (g, multilayer binary undirected with fixed thresholds graph) is a multilayer binary undirected with fixed thresholds graph.

%%% ¡description!
In a multilayer binary undirected with fixed thresholds (BUT) graph, the layers 
 are those of binary undirected (BU) multilayer graphs derived from the same 
 weighted supra-adjacency matrix binarized at different thresholds. The supra-adjacency 
 matrix has a number of partitions equal to the number of thresholds. Layers
 within the binary undirected (BU) multilayer graphs could have different number of nodes 
 with within-layer binary undirected edges. Edges can be either 0 (absence of connection) 
 or 1 (existence of connection).
All node connections are allowed between layers.
On the diagonal of the supra adjacency matrix, matrices are symmetrized, dediagonalized, semipositivized, and binarized.
On the off-diagonal of the supra adjacency matrix, matrices are semipositivized and binarized.

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
MultilayerBUT.ID
%%%% ¡title!
Graph ID

%%% ¡prop!
%%%% ¡id!
MultilayerBUT.LABEL
%%%% ¡title!
Graph NAME

%%% ¡prop!
%%%% ¡id!
MultilayerBUT.LAYERTICKS
%%%% ¡title!
LAYERS ticks

%%% ¡prop!
%%%% ¡id!
MultilayerBUT.LAYERLABELS
%%%% ¡title!
LAYERS labels

%%% ¡prop!
%%%% ¡id!
MultilayerBUT.NODELABELS
%%%% ¡title!
NODES labels

%%% ¡prop!
%%%% ¡id!
MultilayerBUT.B
%%%% ¡title!
Input ADJACENCY MATRIX

%%% ¡prop!
%%%% ¡id!
MultilayerBUT.SYMMETRIZE_RULE
%%%% ¡title!
SYMMETRIZATION RULE

%%% ¡prop!
%%%% ¡id!
MultilayerBUT.SEMIPOSITIVIZE_RULE
%%%% ¡title!
NEGATIVE EDGE RULE

%%% ¡prop!
%%%% ¡id!
MultilayerBUT.STANDARDIZE_RULE
%%%% ¡title!
NORMALIZATION RULE

%%% ¡prop!
%%%% ¡id!
MultilayerBUT.THRESHOLDS
%%%% ¡title!
THRESHOLDS [-1 ... 1]

%%% ¡prop!
%%%% ¡id!
MultilayerBUT.A
%%%% ¡title!
Binary Undirected ADJACENCY MATRICES at fixed Thresholds

%%% ¡prop!
%%%% ¡id!
MultilayerBUT.PFGA
%%%% ¡title!
Adjacency Matrix Plot

%%% ¡prop!
%%%% ¡id!
MultilayerBUT.PFGH
%%%% ¡title!
Graph Histogram

%%% ¡prop!
%%%% ¡id!
MultilayerBUT.M_DICT
%%%% ¡title!
Graph MEASURES

%%% ¡prop!
%%%% ¡id!
MultilayerBUT.NOTES
%%%% ¡title!
Graph NOTES

%% ¡props_update!

%%% ¡prop!

NAME (constant, string) is the name of the multilayer undirected with fixed thresholds graph.
%%%% ¡default!
'MultilayerBUT'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the multilayer undirected with fixed thresholds graph.
%%%% ¡default!
'In a multilayer binary undirected with fixed thresholds (BUT) graph, the layers are those of binary undirected (BU) multilayer graphs derived from the same weighted supra-adjacency matrix binarized at different thresholds. The supra-adjacency  matrix has a number of partitions equal to the number of thresholds. Layers within the binary undirected (BU) multilayer graphs could have different number of nodes with within-layer binary undirected edges. Edges can be either 0 (absence of connection) or 1 (existence of connection). All node connections are allowed between layers. On the diagonal of the supra adjacency matrix, matrices are symmetrized, dediagonalized, semipositivized, and binarized. On the off-diagonal of the supra adjacency matrix, matrices are semipositivized and binarized.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the multilayer binarized at different thresholds graph.
%%%% ¡settings!
'MultilayerBUT'

%%% ¡prop!
ID (data, string) is a few-letter code for the multilayer binary  undirected with fixed thresholds graph.
%%%% ¡default!
'MultilayerBUT ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the multilayer binary  undirected with fixed thresholds graph.
%%%% ¡default!
'MultilayerBUT label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the multilayer binary undirected with fixed thresholds graph.
%%%% ¡default!
'MultilayerBUT notes'

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
A (result, cell) is the cell array containing the binary supra-adjacency matrix of the multilayer binary undirected with fixed thresholds (BUT) graph.
%%%% ¡calculate!
A_WU = calculateValue@MultilayerWU(g, prop);

thresholds = g.get('THRESHOLDS');
L = length(A_WU); % number of layers
A = cell(length(thresholds)*L);

if L > 0 && ~isempty(cell2mat(A_WU))
    for i = 1:1:length(thresholds)
        threshold = thresholds(i);
        layer_x = 1;
        for j = (i - 1) * L + 1:1:i * L
            layer_y = 1;
	        for k = (i - 1) * L + 1:1:i * L
                if j==k
                    M = symmetrize(A_WU{layer_x, layer_x}, 'SymmetrizeRule', g.get('SYMMETRIZE_RULE')); %#ok<PROPLC> % enforces symmetry of adjacency matrix
                    M = dediagonalize(M); % removes self-connections by removing diagonal from adjacency matrix, equivalent to dediagonalize(M, 'DediagonalizeRule', 0)
                    M = semipositivize(M, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
                    M = binarize(M,  'threshold', threshold); % enforces binary adjacency matrix, equivalent to binarize(M, 'threshold', 0, 'bins', [-1:.001:1])
                    A(j, j) = {M};
                else
                    M = semipositivize(A_WU{layer_x, layer_y}, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
                    M = binarize(M, 'threshold', threshold, 'diagonal', 'include');  % enforces binary adjacency matrix, equivalent to binarize(M, 'threshold', 0, 'bins', [-1:.001:1])
                    A(j, k) = {M};
                end
                layer_y = layer_y + 1;
            end
            layer_y = 1;
            for n = k + 1:1:length(thresholds)*L
                if layer_y == L+1
                    layer_y = 1;
                end
                A(j, n) = {zeros(size(A_WU{layer_x, layer_y}, 1), size(A_WU{layer_x, layer_y}, 2))};
                A(n, j) = {zeros(size(A_WU{layer_y, layer_x}, 1), size(A_WU{layer_y, layer_x}, 2))};
                layer_y = layer_y + 1;
            end
            layer_x = layer_x + 1;
        end
    end
end
value = A;

%%%% ¡gui!
pr = PanelPropCell('EL', g, 'PROP', MultilayerBUT.A, ...
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
thresholds = g.get('THRESHOLDS');
value = ones(1, length(thresholds)) * l / length(thresholds);

%%% ¡prop!
ALAYERLABELS (query, stringlist) returns the layer labels to be used by the slider.
%%%% ¡calculate!
alayerlabels = g.get('LAYERLABELS');
if ~isa(g.getr('A'), 'NoValue') && length(alayerlabels) ~= g.get('LAYERNUMBER') % ensures that it's not unecessarily calculated
    thresholds = cellfun(@num2str, num2cell(g.get('THRESHOLDS')), 'uniformoutput', false);

    if length(alayerlabels) == length(g.get('B'))
        blayerlabels = alayerlabels;
    else % includes isempty(layerlabels)
        blayerlabels = cellfun(@num2str, num2cell([1:1:length(g.get('B'))]), 'uniformoutput', false);
    end
    
    alayerlabels = {};
    for i = 1:1:length(thresholds)
        for j = 1:1:length(blayerlabels)
            alayerlabels = [alayerlabels, [blayerlabels{j} '|' thresholds{i}]];
        end
    end
end
value = alayerlabels;

%%% ¡prop!
COMPATIBLE_MEASURES (constant, classlist) is the list of compatible measures.
%%%% ¡default!
getCompatibleMeasures('MultilayerBUT')

%% ¡props!

%%% ¡prop!
THRESHOLDS (parameter, rvector) is the vector of thresholds.
%%%% ¡default!
[0 0 0 0]
%%%% ¡gui!
pr = PanelPropRVectorSmart('EL', g, 'PROP', MultilayerBUT.THRESHOLDS, 'MAX', 1, 'MIN', -1, varargin{:});

%% ¡tests!

%%% ¡excluded_props!
[MultilayerBUT.PFGA MultilayerBUT.PFGH]

%%% ¡test!
%%%% ¡name!
Constructor - Full
%%%% ¡probability!
.01
%%%% ¡code!
B1 = rand(randi([2, 10]));
B2 = rand(randi([2, 10]));
B3 = rand(randi([2, 10]));
B12 = rand(size(B1, 1),size(B2, 2));
B13 = rand(size(B1, 1),size(B3, 2));
B23 = rand(size(B2, 1),size(B3, 2));
B = {
    B1                           B12                            B13
    B12'                         B2                             B23
    B13'                         B23'                           B3
    };

thresholds = [0 .5 1];
g = MultilayerBUT('B', B, 'THRESHOLDS', thresholds); 
g.get('A_CHECK')
A = g.get('A');

L = length(B); % number of layers

for i = 1:1:length(thresholds)
    threshold = thresholds(i);
    layer_x = 1;
    for j = (i - 1) * L + 1:1:i * L
        layer_y = 1;
        for k = (i - 1) * L + 1:1:i * L
            if j==k
                assert(isequal(A{j, j},binarize(symmetrize(dediagonalize(semipositivize(B{layer_x, layer_x}))), 'threshold', threshold)), ...
                    [BRAPH2.STR ':MultilayerBUT:' BRAPH2.FAIL_TEST], ...
                    'MultilayerBUT is not constructing well.')
            else
                assert(isequal(A{j, k},binarize(semipositivize(B{layer_x, layer_y}), 'threshold', threshold)), ...
                    [BRAPH2.STR ':MultilayerBUT:' BRAPH2.FAIL_TEST], ...
                    'MultilayerBUT is not constructing well.')
            end
            layer_y = layer_y + 1;
        end
        layer_y = 1;
        for n = k + 1:1:length(thresholds)*L
            if layer_y == L+1
                layer_y = 1;
            end
            assert(isequal(A{j, n},zeros(size(B{layer_x, layer_y}, 1), size(B{layer_x, layer_y}, 2))), ...
            [BRAPH2.STR ':MultilayerBUT:' BRAPH2.FAIL_TEST], ...
            'MultilayerBUT is not constructing well.')
            assert(isequal(A{n, j},zeros(size(B{layer_y, layer_x}, 1), size(B{layer_y, layer_x}, 2))), ...
            [BRAPH2.STR ':MultilayerBUT:' BRAPH2.FAIL_TEST], ...
            'MultilayerBUT is not constructing well.')
            layer_y = layer_y + 1;
        end
        layer_x = layer_x + 1;
    end
end
