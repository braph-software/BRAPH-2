%% ¡header!
GraphBU < Graph (g, binary undirected graph) is a binary undirected graph.

%%% ¡description!
In a binary undirected (BU) graph, 
the edges can be either 0 (absence of connection) 
or 1 (existence of connection), and they are undirected. 
The connectivity matrix is symmetric.

%%% ¡ensemble!
false

%%% ¡graph!
graph = Graph.GRAPH;

%%% ¡connectivity!
connectivity = Graph.BINARY;

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
A (result, cell) is the symmetric binary adjacency matrix of the binary undirected graph.
%%%% ¡calculate!
B = g.get('B');

varargin = {}; %% TODO add props to manage the relevant properties of symmetrize, dediagonalize, semipositivize, binarize
B = symmetrize(B, varargin{:}); %% enforces symmetry of adjacency matrix
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
g = GraphBU('B', B);

A = {symmetrize(binarize(semipositivize(dediagonalize(B))))};

assert(isequal(g.get('A'), A), ...
       [BRAPH2.STR ':GraphBU:' BRAPH2.BUG_ERR], ...
       'GraphBU is not constructing well.')
