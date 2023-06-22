%% ¡header!
OrdMlBD < Graph (g, ordinal multilayer binary directed graph) is a ordinal multilayer binary directed graph.

%%% ¡description!
In an ordinal multilayer binary directed (BD) graph, layers could have different number 
 of nodes with within-layer directed edges. Edges can be either 0 (absence of connection) 
or 1 (existence of connection).
All node connections are allowed between layers.
The layers are connected in an ordinal fashion, i.e., only consecutive layers are connected.

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the ordinal multilayer binary directed graph.
%%%% ¡default!
'OrdMlBD'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the ordinal multilayer binary directed graph.
%%%% ¡default!
'In an ordinal multilayer binary directed (BD) graph, layers could have different number  of nodes with within-layer directed edges. Edges can be either 0 (absence of connection)  or 1 (existence of connection). All node connections are allowed between layers. The layers are connected in an ordinal fashion, i.e., only consecutive layers are connected.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the ordinal multilayer binary directed graph.
%%%% ¡settings!
'OrdMlBD'

%%% ¡prop!
ID (data, string) is a few-letter code for the ordinal multilayer binary directed graph.
%%%% ¡default!
'OrdMlBD ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the ordinal multilayer binary directed graph.
%%%% ¡default!
'OrdMlBD label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the ordinal multilayer binary directed graph.
%%%% ¡default!
'OrdMlBD notes'

%%% ¡prop!
GRAPH_TYPE (constant, scalar) returns the graph type Graph.ORDERED_MULTILAYER__.
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
A (result, cell) is the cell containing the within-layer binary adjacency matrices of the multilayer binary directed graph and the ordinal connections between layers.
%%%% ¡calculate!
B = g.get('B'); %#ok<PROPLC>
L = length(B); %#ok<PROPLC> % number of layers
A = cell(L, L);

for i = 1:1:L
    M = dediagonalize(B{i,i}); % removes self-connections by removing diagonal from adjacency matrix, equivalent to dediagonalize(M, 'DediagonalizeRule', 0)
    M = semipositivize(M, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
    M = binarize(M, varargin{:}); % rescales adjacency matrix, equivalent to binarize(M, 'threshold', 0, 'bins', [-1:.001:1])
    A(i, i) = {M};
    if ~isempty(A{1, 1})
        for j = i+1:1:L
            M = semipositivize(B{i,j}, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
            M = binarize(M);  % rescales adjacency matrix
            A(i, j) = {M};
            M = semipositivize(B{j,i}, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); % removes negative weights
            M = binarize(M);  % rescales adjacency matrix
            A(j, i) = {M};
        end
    end
end

value = A;
%%%% ¡gui!
pr = PanelPropCell('EL', g, 'PROP', OrdMlBD.A, ...
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
COMPATIBLE_MEASURES (constant, classlist) is the list of compatible measures.
%%%% ¡default!
getCompatibleMeasures('OrdMlBD')

%% ¡props!

%%% ¡prop!
B (data, cell) is the input cell containing the multilayer adjacency matrices.
%%%% ¡default!
{[] []; [] []}
%%%% ¡gui!
pr = PanelPropCell('EL', g, 'PROP', OrdMlBD.B, ...
    'TABLE_HEIGHT', s(40), ...
    'XSLIDERSHOW', true, ...
    'XSLIDERLABELS', g.get('LAYERLABELS'), ...
    'XSLIDERHEIGHT', s(3.5), ...
    'YSLIDERSHOW', false, ...
    'ROWNAME', g.getCallback('ANODELABELS'), ...
    'COLUMNNAME', g.getCallback('ANODELABELS'), ...
    varargin{:});

%%% ¡prop!
SEMIPOSITIVIZE_RULE (parameter, option) determines how to remove the negative edges.
%%%% ¡settings!
{'zero', 'absolute'}

%% ¡tests!

%%% ¡excluded_props!
[OrdMlBD.PFGA OrdMlBD.PFGH]

%%% ¡test!
%%%% ¡name!
Constructor - Full
%%%% ¡probability!
.01
%%%% ¡code!
B1 = rand(randi(10));
B2 = rand(randi(10));
B3 = rand(randi(10));
B12 = rand(size(B1,1),size(B2,2));
B13 = rand(size(B1,1),size(B3,2));
B23 = rand(size(B2,1),size(B3,2));
B21 = rand(size(B2,1),size(B1,2));
B31 = rand(size(B3,1),size(B1,2));
B32 = rand(size(B3,1),size(B2,2));
B = {
    B1                           B12                            B13
    B21                          B2                             B23
    B31                          B32                            B3
    };
g = OrdMlBD('B', B);
g.get('A_CHECK')
A1 = binarize(semipositivize(dediagonalize(B1)));
A2 = binarize(semipositivize(dediagonalize(B2)));
A3 = binarize(semipositivize(dediagonalize(B3)));
A12 = binarize(semipositivize(B12));
A13 = binarize(semipositivize(B13));
A23 = binarize(semipositivize(B23));
A21 = binarize(semipositivize(B21));
A31 = binarize(semipositivize(B31));
A32 = binarize(semipositivize(B32));
B{1,1} = A1;
B{2,2} = A2;
B{3,3} = A3;
B{1,2} = A12;
B{1,3} = A13;
B{2,3} = A23;
B{2,1} = A21;
B{3,1} = A31;
B{3,2} = A32;
A = B;
assert(isequal(g.get('A'), A), ...
    [BRAPH2.STR ':OrdMlBD:' BRAPH2.FAIL_TEST], ...
    'OrdMlBD is not constructing well.')


% %%% ¡test!
% %%%% ¡name!
% Semipositivize Rule
% %%%% ¡probability!
% .01
% %%%% ¡code!


%% ¡_props!

%%% ¡_prop!
ATTEMPTSPEREDGE (parameter, scalar) is the attempts to rewire each edge.
%%%% ¡_default!
5

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
        random_A = GraphBD.randomize_A(Aii, attempts_per_edge);
        random_multi_A(li) = {random_A};
    end
    random_g = OrdMlBD('B', random_multi_A);
end
