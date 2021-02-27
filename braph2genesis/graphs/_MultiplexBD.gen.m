%% ¡header!
MultiplexBD < Graph (g, multiplex binary directed graph) is a multiplex binary directed graph.

%%% ¡description!
In a multiplex binary directed (BD) graph, 
the edges can be either 0 (absence of connection) 
or 1 (existence of connection), 
and they are directed.

%%% ¡ensemble!
false

%%% ¡graph!
graph = Graph.MULTIPLEX;

%%% ¡connectivity!
connectivity = Graph.BINARY * ones(layernumber);

%%% ¡directionality!
directionality = Graph.DIRECTED * ones(layernumber);

%%% ¡selfconnectivity!  
selfconnectivity = Graph.SELFCONNECTED * ones(layernumber);
selfconnectivity(1:layernumber+1:end) = Graph.NONSELFCONNECTED;

%%% ¡negativity!
negativity = Graph.NONNEGATIVE * ones(layernumber);

%% ¡props!

%%% ¡prop!
B (data, cell) is the input cell containing the multiplex adjacency matrices.
%%%% ¡default!
{[] []};

%% ¡props_update!

%%% ¡prop!
A (result, cell) is the cell containing the multiplex binary adjacency matrices of the multiplex binary directed graph.
%%%% ¡calculate!
B = g.get('B');
L = length(B); %% number of layers
A = cell(L, L);

varargin = {}; %% TODO add props to manage the relevant properties of dediagonalize, semipositivize, binarize
for layer = 1:1:L
    M = dediagonalize(B{layer}, varargin{:}); %% removes self-connections by removing diagonal from adjacency matrix
    M = semipositivize(M, varargin{:}); %% removes negative weights
    M = binarize(M, varargin{:}); %% enforces binary adjacency matrix
    A(layer, layer) = {M};
end
if ~isempty(A{1, 1})
    for i = 1:1:L
        for j = i+1:1:L
            A(i, j) = {eye(length(A{1, 1}))};
            A(j, i) = {eye(length(A{1, 1}))};
        end
    end
end
value = A;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Constructor
%%%% ¡code!
A = rand(randi(10));
B = {A, A};
g = MultiplexBD('B', B);

A1 = binarize(semipositivize(dediagonalize(A)));
A = {A1, eye(length(A)); eye(length(A)), A1};

assert(isequal(g.get('A'), A), ...
    [BRAPH2.STR ':MultiplexBD:' BRAPH2.BUG_ERR], ...
    'MultiplexBD is not constructing well.')

