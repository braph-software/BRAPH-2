%% ¡header!
GraphWU < Graph (g, weighted undirected graph) is a weighted undirected graph.

%%% ¡description!
In a weighted undirected (WU) graph, 
the edges are associated with a real number between 0 and 1 
indicating the strength of the connection, and are undirected.
The connectivity matrix is symmetric.

%%% ¡graph!
graph = Graph.GRAPH;

%%% ¡connectivity!
connectivity = Graph.WEIGHTED;

%%% ¡directionality!
directionality = Graph.UNDIRECTED;

%%% ¡selfconnectivity!
selfconnectivity = Graph.NONSELFCONNECTED;

%%% ¡negativity!
negativity = Graph.NONNEGATIVE;

%% ¡props!

%%% ¡prop!
B (data, smatrix) is the input graph adjacency matrix.

%% ¡props_update!

%%% ¡prop!
A (result, cell) is the symmetric non-negative adjacency matrix of the weighted undirected graph.
%%%% ¡calculate!
B = g.get('B');

varargin = {}; %% TODO add props to manage the relevant properties of symmetrize, dediagonalize, semipositivize, standardize
B = symmetrize(B, varargin{:}); %% enforces symmetry of adjacency matrix
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
g = GraphWU('B', B);

A = {standardize(symmetrize(semipositivize(dediagonalize(B))))};

assert(isequal(g.get('A'), A), ...
    [BRAPH2.STR ':GraphWU:' BRAPH2.BUG_ERR], ...
    'GraphWU is not constructing well.')