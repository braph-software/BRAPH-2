%% ¡header!
GraphWD < Graph (g, weighted directed graph) is a weighted directed graph.

%%% ¡description!
In a weighted directed (WD) graph, 
the edges are associated with a real number between 0 and 1 
indicating the strength of the connection, and they are directed.

%%% ¡graph!
graph = Graph.GRAPH;

%%% ¡connectivity!
connectivity = Graph.WEIGHTED;

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
A (result, cell) is the non-negative adjacency matrix of the weighted directed graph.
%%%% ¡calculate!
B = g.get('B');

varargin = {}; %% TODO add props to manage the relevant properties of dediagonalize, semipositivize, standardize
B = dediagonalize(B, varargin{:}); %% removes self-connections by removing diagonal from adjacency matrix
B = semipositivize(B, varargin{:}); %% removes negative weights
B = standardize(B, varargin{:}); %% ensures all weights are between 0 and 1

A = {B};
value = A;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Constructor
%%%% ¡code!
B = rand(randi(10));
g = GraphWD('B', B);

A = {standardize(semipositivize(dediagonalize(B)))};

assert(isequal(g.get('A'), A), ...
    [BRAPH2.STR ':GraphWD:' BRAPH2.BUG_ERR], ...
    'GraphWD is not constructing well.')