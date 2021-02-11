%% ¡header!
GraphWU < Graph (g, weighted undirected graph) is a weighted undirected graph.

%%% ¡description!
In a weighted undirected (WU) graph, 
the edges are associated with a real number between 0 and 1 
indicating the strength of the connection, and are undirected.
The connectivity matrix is symmetric.

%%% ¡ensemble!
false

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
B (data, cell) is the input graph adjacency matrix.

%% ¡props_update!

%%% ¡prop!
A (result, cell) is the symmetric non-negative adjacency matrix of the weighted undirected graph.
%%%% ¡calculate!
B = g.get('B');
A = B{1, 1};

varargin = {}; %% TODO add props to manage the relevant properties of symmetrize, dediagonalize, semipositivize, standardize
A = symmetrize(A, varargin{:}); %% enforces symmetry of adjacency matrix
A = dediagonalize(A, varargin{:}); %% removes self-connections by removing diagonal from adjacency matrix
A = semipositivize(A, varargin{:}); %% removes negative weights
A = standardize(A, varargin{:}); %% ensures all weights are between 0 and 1

value = {A};

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Constructor
%%%% ¡code!
B = rand(randi(10));
g = GraphWU('B', {B});

A = standardize(symmetrize(semipositivize(dediagonalize(B))));

assert(isequal(g.get('A'), {A}), ...
    [BRAPH2.STR ':GraphWU:' BRAPH2.BUG_ERR], ...
    'GraphWU is not constructing well.')
