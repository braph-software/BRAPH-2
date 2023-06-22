%% ¡header!
OrdMxBUT < OrdMxWU (g, ordinal multiplex binary undirected with fixed thresholds) is a binary undirected ordinal multiplex with fixed thresholds.

%%% ¡description!
In a binary undirected ordinal multiplex with fixed thresholds (BUT), 
all the layers consist of binary undirected (BU) multiplex graphs 
derived from the same weighted supra-connectivity matrices 
binarized at different thresholds.
The supra-connectivity matrix has a number of partitions equal to the number of thresholds.
The layers are connected in an ordinal fashion, i.e., only consecutive layers are connected.

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the binary undirected ordinal multiplex with fixed thresholds.
%%%% ¡default!
'OrdMxBUT'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the binary undirected multiplex with fixed thresholds.
%%%% ¡default!
'In a binary undirected ordinal multiplex with fixed thresholds (BUT),  all the layers consist of binary undirected (BU) multiplex graphs  derived from the same weighted supra-connectivity matrices  binarized at different thresholds. The supra-connectivity matrix has a number of partitions equal to the number of thresholds. The layers are connected in an ordinal fashion, i.e., only consecutive layers are connected.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the binary undirected ordinal multiplex with fixed thresholds.
%%%% ¡settings!
'OrdMxBUT'

%%% ¡prop!
ID (data, string) is a few-letter code for the binary undirected ordinal multiplex with fixed thresholds.
%%%% ¡default!
'OrdMxBUT ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the binary undirected ordinal multiplex with fixed thresholds.
%%%% ¡default!
'OrdMxBUT label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the binary undirected ordinal multiplex with fixed thresholds.
%%%% ¡default!
'OrdMxBUT notes'

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
A (result, cell) is the cell array containing the binary supra-adjacency matrix of the binary undirected multiplex with fixed thresholds (BUT).
%%%% ¡calculate!
A_WU = calculateValue@OrdMxWU(g, prop);

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
pr = PanelPropCell('EL', g, 'PROP', OrdMxBUT.A, ...
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
getCompatibleMeasures('OrdMxBUT')

%% ¡props!

%%% ¡prop!
THRESHOLDS (parameter, rvector) is the vector of thresholds.
%%%% ¡gui!
pr = PanelPropRVectorSmart('EL', g, 'PROP', OrdMxBUT.THRESHOLDS, 'MAX', 1, 'MIN', -1, varargin{:});

%% ¡tests!

%%% ¡excluded_props!
[OrdMxBUT.PFGA OrdMxBUT.PFGH]

%%% ¡test!
%%%% ¡name!
Constructor - Full
%%%% ¡probability!
.01
%%%% ¡code!
B1 = [
     0 .1 .2 .3 .4 
    .1 0 .1 .2 .3
    .2 .1 0 .1 .2
    .3 .2 .1 0 .1
    .4 .3 .2 .1 0
    ];
B = {B1, B1, B1};
thresholds = [0 .1 .2 .3 .4];
g = OrdMxBUT('B', B, 'THRESHOLDS', thresholds);

g.get('A_CHECK')

A = g.get('A');
for i = 1:1:length(thresholds)
    threshold = thresholds(i);
    for j = (i - 1) * length(B) + 1:1:i * length(B)
        for k = (i - 1) * length(B) + 1:1:i * length(B)
            if j == k
                assert(isequal(A{j, j}, binarize(B1, 'threshold', threshold)), ...
                    [BRAPH2.STR ':OrdMxBUT:' BRAPH2.FAIL_TEST], ...
                    'OrdMxBUT is not constructing well.')
            elseif (j-k)==1 || (k-j)==1
                assert(isequal(A{j, k}, eye(length(B1))), ...
                    [BRAPH2.STR ':OrdMxBUT:' BRAPH2.FAIL_TEST], ...
                    'OrdMxBUT is not constructing well.')
            else 
                assert(isequal(A{j, k}, zeros(length(B1))), ...
                    [BRAPH2.STR ':OrdMxBUT:' BRAPH2.FAIL_TEST], ...
                    'OrdMxBUT is not constructing well.')
            end
        end
    end
end
