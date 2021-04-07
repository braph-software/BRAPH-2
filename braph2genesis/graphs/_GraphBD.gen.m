%% ¡header!
GraphBD < Graph (g, binary directed graph) is a binary directed graph.

%%% ¡description!
In a binary directed (BD) graph, 
the edges can be either 0 (absence of connection) 
or 1 (existence of connection), 
and they are directed.

%%% ¡graph!
graph = Graph.GRAPH;

%%% ¡connectivity!
connectivity = Graph.BINARY;

%%% ¡directionality!
directionality = Graph.DIRECTED;

%%% ¡selfconnectivity!
selfconnectivity = Graph.NONSELFCONNECTED;

%%% ¡negativity!
negativity = Graph.NONNEGATIVE;

%% ¡props!

%%% ¡prop!
B (data, smatrix) is the input graph adjacency matrix.

%% ¡props_update!

%%% ¡prop!
A (result, cell) is the binary adjacency matrix of the binary directed graph.
%%%% ¡calculate!
B = g.get('B');

varargin = {}; %% TODO add props to manage the relevant properties of dediagonalize, semipositivize, binarize
B = dediagonalize(B, varargin{:}); %% removes self-connections by removing diagonal from adjacency matrix
B = semipositivize(B, varargin{:}); %% removes negative weights
B = binarize(B, varargin{:}); %% enforces binary adjacency matrix

A = {B};
value = A;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Constructor
%%%% ¡code!
B = rand(randi(10));
g = GraphBD('B', B);

A = {binarize(semipositivize(dediagonalize(B)))};

assert(isequal(g.get('A'), A), ...
    [BRAPH2.STR ':GraphBD:' BRAPH2.BUG_ERR], ...
    'GraphBD is not constructing well.')
