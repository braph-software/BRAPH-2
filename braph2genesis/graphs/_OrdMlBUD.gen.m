%% ¡header!
OrdMlBUD < OrdMlWU (g, binary undirected multilayer with fixed densities) is an ordinal multilayer binary undirected with fixed densities.

%%% ¡description!
In an ordinal binary undirected multilayer with fixed densities (BUD) graph, layers 
 consist of binary undirected (BU) multilayer graphs derived from the same 
 weighted supra-connectivity matrices binarized at different densities. Layers 
 within the binary undirected (BU) multilayer graphs could have different number of nodes 
 with within-layer binary undirected edges. Edges can be either 0 (absence of connection) 
 or 1 (existence of connection).
The supra-connectivity matrix has a number of partitions equal to the number of densities.
The layers are connected in an ordinal fashion, i.e., only consecutive layers are connected.
On the diagonal of the supra adjacency matrix, matrices are symmetrized, dediagonalized, semipositivized, and binarized.
On the off-diagonal of the supra adjacency matrix, matrices are semipositivized and binarized.

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the ordinal binary undirected multilayer with fixed densities.
%%%% ¡default!
'OrdMlBUD'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the ordinal binary undirected multilayer with fixed densities.
%%%% ¡default!
'In an ordinal binary undirected multilayer with fixed densities (BUD) graph, layers consist of binary undirected (BU) multilayer graphs derived from the same weighted supra-connectivity matrices binarized at different densities. Layers within the binary undirected (BU) multilayer graphs could have different number of nodes with within-layer binary undirected edges. Edges can be either 0 (absence of connection) or 1 (existence of connection). The supra-connectivity matrix has a number of partitions equal to the number of densities. The layers are connected in an ordinal fashion, i.e., only consecutive layers are connected. On the diagonal of the supra adjacency matrix, matrices are symmetrized, dediagonalized, semipositivized, and binarized. On the off-diagonal of the supra adjacency matrix, matrices are semipositivized and binarized.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the ordinal binary undirected multilayer with fixed densities.
%%%% ¡settings!
'OrdMlBUD'

%%% ¡prop!
ID (data, string) is a few-letter code for the ordinal binary undirected multilayer with fixed densities.
%%%% ¡default!
'OrdMlBUD ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the ordinal binary undirected multilayer with fixed densities.
%%%% ¡default!
'OrdMlBUD label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the ordinal binary undirected multilayer with fixed densities.
%%%% ¡default!
'OrdMlBUD notes'

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
densities = g.get('DENSITIES');
L = length(A_WU); % number of layers of MultilayerWU
A = cell(length(densities) * L); % the new g.layernumber() will be equal to = L*length(densities)
if L > 0 && ~isempty(cell2mat(A_WU))
    for i = 1:1:length(A)
        if mod(i, L) == 0
            i_layer = L;
            i_density = densities(fix(i/L));
        else
            i_layer = mod(i, L);
            i_density = densities(fix(i/L)+1);
        end
        M = symmetrize(A_WU{i_layer, i_layer}, 'SymmetrizeRule', g.get('SYMMETRIZE_RULE')); %#ok<PROPLC> % enforces symmetry of adjacency matrix
        M = dediagonalize(M); % removes self-connections by removing diagonal from adjacency matrix, equivalent to dediagonalize(M, 'DediagonalizeRule', 0)
        M = semipositivize(M, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
        M = binarize(M, 'density', i_density); % enforces binary adjacency matrix, equivalent to binarize(M, 'threshold', 0, 'bins', [-1:.001:1])
        A(i, i) = {M};
        for j = i+1:1:length(A)
            if mod(j, L) == 0
                j_layer = L;
                j_density = densities(fix(j/L));
            else
                j_layer = mod(j, L);
                j_density = densities(fix(j/L)+1);
            end
            if i_density == j_density && j == i + 1
                    M = semipositivize(A_WU{i_layer, j_layer}, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
                    M = binarize(M, 'density', i_density, 'diagonal', 'include');  % enforces binary adjacency matrix, equivalent to binarize(M, 'threshold', 0, 'bins', [-1:.001:1])
                    A(i, j) = {M};
                    M = semipositivize(A_WU{j_layer, i_layer}, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
                    M = binarize(M, 'density', i_density, 'diagonal', 'include');  % enforces binary adjacency matrix, equivalent to binarize(M, 'threshold', 0, 'bins', [-1:.001:1])
                    A(j, i) = {M};
            else
                A(i, j) = {zeros(size(A_WU{i_layer, i_layer}, 1), size(A_WU{j_layer, j_layer}, 2))};
                A(j, i) = {zeros(size(A_WU{j_layer, j_layer}, 2), size(A_WU{i_layer, i_layer}, 1))};
            end
        end
    end
end
value = A;

%%%% ¡gui!
pr = PanelPropCell('EL', g, 'PROP', OrdMlBUD.A, ...
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
getCompatibleMeasures('OrdMlBUD')

%% ¡props!

%%% ¡prop!
DENSITIES (parameter, rvector) is the vector of densities.
%%%% ¡gui!
pr = PanelPropRVectorSmart('EL', g, 'PROP', MultilayerBUD.DENSITIES, 'MAX', 100, 'MIN', 0, varargin{:});

%% ¡tests!

%%% ¡excluded_props!
[OrdMlBUD.PFGA OrdMlBUD.PFGH]

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
densities = [0 55 100];
g = OrdMlBUD('B', B, 'DENSITIES', densities); 
g.get('A_CHECK')
A = g.get('A');
L = length(B); % number of layers

for i = 1:1:length(A)
    if mod(i, L) == 0
        i_layer = L;
        i_density = densities(fix(i/L));
    else
        i_layer = mod(i, L);
        i_density = densities(fix(i/L)+1);
    end
    assert(isequal(A{i, i},binarize(symmetrize(dediagonalize(semipositivize(B{i_layer, i_layer}))), 'density', i_density)), ...
        [BRAPH2.STR ':OrdMlBUD:' BRAPH2.FAIL_TEST], ...
        'OrdMlBUD is not constructing well.')
    for j = i+1:1:length(A)
        if mod(j, L) == 0
            j_layer = L;
            j_density = densities(fix(j/L));
        else
            j_layer = mod(j, L);
            j_density = densities(fix(j/L)+1);
        end
        if i_density == j_density && j == i + 1
            assert(isequal(A{i, j}, binarize(semipositivize(B{i_layer, j_layer}), 'density', i_density, 'diagonal', 'include')), ...
                [BRAPH2.STR ':OrdMlBUD:' BRAPH2.FAIL_TEST], ...
                'OrdMlBUD is not constructing well.')
            assert(isequal(A{j, i}, binarize(semipositivize(B{j_layer, i_layer}), 'density', i_density, 'diagonal', 'include')), ...
                [BRAPH2.STR ':OrdMlBUD:' BRAPH2.FAIL_TEST], ...
                'OrdMlBUD is not constructing well.')
        else
            assert(isequal(A{i, j}, zeros(size(B{i_layer, i_layer}, 1), size(B{j_layer, j_layer}, 2))), ...
                [BRAPH2.STR ':OrdMlBUD:' BRAPH2.FAIL_TEST], ...
                'OrdMlBUD is not constructing well.')
            assert(isequal(A{j, i}, zeros(size(B{j_layer, j_layer}, 1), size(B{i_layer, i_layer}, 2))), ...
                [BRAPH2.STR ':OrdMlBUD:' BRAPH2.FAIL_TEST], ...
                'OrdMlBUD is not constructing well.')
        end
    end
end