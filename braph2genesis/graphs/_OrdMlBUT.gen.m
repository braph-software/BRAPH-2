%% ¡header!
OrdMlBUT < OrdMlWU (g, binary undirected multilayer with fixed thresholds) is an ordinal multilayer binary undirected with fixed thresholds.

%%% ¡description!
In an ordinal binary undirected multilayer with fixed thresholds (BUT) graph, layers 
 consist of binary undirected (BU) multilayer graphs derived from the same 
 weighted supra-connectivity matrices binarized at different thresholds. Layers 
 within the binary undirected (BU) multilayer graphs could have different number of nodes 
 with within-layer binary undirected edges. Edges can be either 0 (absence of connection) 
 or 1 (existence of connection).
The supra-connectivity matrix has a number of partitions equal to the number of thresholds.
The layers are connected in an ordinal fashion, i.e., only consecutive layers are connected.

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the binary undirected ordinal multilayer with fixed thresholds.
%%%% ¡default!
'OrdMlBUT'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the binary undirected multilayer with fixed thresholds.
%%%% ¡default!
'In an ordinal binary undirected multilayer with fixed thresholds (BUT) graph, layers consist of binary undirected (BU) multilayer graphs derived from the same weighted supra-connectivity matrices binarized at different thresholds. Layers within the binary undirected (BU) multilayer graphs could have different number of nodes with within-layer binary undirected edges. Edges can be either 0 (absence of connection) or 1 (existence of connection). The supra-connectivity matrix has a number of partitions equal to the number of thresholds. The layers are connected in an ordinal fashion, i.e., only consecutive layers are connected.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the binary undirected ordinal multilayer with fixed thresholds.

%%% ¡prop!
ID (data, string) is a few-letter code for the binary undirected ordinal multilayer with fixed thresholds.
%%%% ¡default!
'OrdMlBUT ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the binary undirected ordinal multilayer with fixed thresholds.
%%%% ¡default!
'OrdMlBUT label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the binary undirected ordinal multilayer with fixed thresholds.
%%%% ¡default!
'OrdMlBUT notes'

%%% ¡prop!
GRAPH_TYPE (constant, scalar) returns the graph type __Graph.ORDERED_MULTILAYER__.
%%%% ¡default!
Graph.ORDERED_MULTILAYER

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
A (result, cell) is the cell array containing the multilayer binary supra-adjacency matrices of the binary undirected multilayer. 
%%%% ¡calculate!
A_WU = calculateValue@OrdMlWU(g, prop);

thresholds = g.get('THRESHOLDS');
L = length(A_WU); % number of layers
A = cell(length(thresholds)*L);

if L > 0 && ~isempty(cell2mat(A_WU))
    A(:, :) = {zeros(length(A_WU{1, 1}))};
    for i = 1:1:length(thresholds)
        threshold = thresholds(i);
        layer = 1;
        for j = (i - 1) * L + 1:1:i * L
	        for k = (i - 1) * L + 1:1:i * L
                if j == k
                    A{j, j} = dediagonalize(binarize(A_WU{layer, layer}, 'threshold', threshold));
                elseif (j-k)==1 || (k-j)==1
                    A(j, k) = {eye(length(A{1, 1}))};
                else
                    A(j, k) = {zeros(length(A{1, 1}))};
                end
            end
            layer = layer + 1;
        end
    end
end

value = A;

%%%% ¡gui!
pr = PanelPropCell('EL', g, 'PROP', OrdMlBUT.A, ...
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
COMPATIBLE_MEASURES (constant, stringlist) is the list of compatible measures.
%%%% ¡default!
getCompatibleMeasures('OrdMlBUT')

%% ¡props!

%%% ¡prop!
THRESHOLDS (parameter, rvector) is the vector of thresholds.
%%%% ¡gui!
pr = PanelPropRVectorSmart('EL', g, 'PROP', OrdMlBUT.THRESHOLDS, 'MAX', 1, 'MIN', -1, varargin{:});

%% ¡tests!

%%% ¡excluded_props!
[OrdMlBUT.PFGA OrdMlBUT.PFGH]

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
B13 = zeros(size(B1, 1),size(B3, 2));
B23 = rand(size(B2, 1),size(B3, 2));
B = {
    B1                           B12                            B13
    B12'                         B2                             B23
    B13'                         B23'                           B3
    };
thresholds = [0 .1 .2 .3 .4];
g = OrdMlBUT('B', B, 'THRESHOLDS', thresholds);

g.get('A_CHECK')

A = g.get('A');
for i = 1:1:length(thresholds)
    threshold = thresholds(i);
    for j = (i - 1) * length(B) + 1:1:i * length(B)
        for k = (i - 1) * length(B) + 1:1:i * length(B)
            if j == k
                assert(isequal(A{j, j}, binarize(B1, 'threshold', threshold)), ...
                    [BRAPH2.STR ':OrdMlBUT:' BRAPH2.FAIL_TEST], ...
                    'OrdMlBUT is not constructing well.')
            elseif (j-k)==1 || (k-j)==1
                assert(isequal(A{j, k}, eye(length(B1))), ...
                    [BRAPH2.STR ':OrdMlBUT:' BRAPH2.FAIL_TEST], ...
                    'OrdMlBUT is not constructing well.')
            else 
                assert(isequal(A{j, k}, zeros(length(B1))), ...
                    [BRAPH2.STR ':OrdMlBUT:' BRAPH2.FAIL_TEST], ...
                    'OrdMlBUT is not constructing well.')
            end
        end
    end
end