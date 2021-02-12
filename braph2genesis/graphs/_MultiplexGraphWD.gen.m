%% ¡header!
MultiplexGraphWD < Graph (g, multiplex weighted directed graph) is a multiplex weighted directed graph.

%%% ¡description!
In a multiplex weighted directed (WD) graph, 
the edges are associated with a real number between 0 and 1 
indicating the strength of the connection, and they are directed.

%%% ¡ensemble!
false

%%% ¡graph!
graph = Graph.MULTIPLEX;

%%% ¡connectivity!
connectivity = Graph.WEIGHTED * ones(layernumber);

%%% ¡directionality!
directionality = Graph.DIRECTED * ones(layernumber);

%%% ¡selfconnectivity!
if layernumber == 1
    selfconnectivity = Graph.SELFCONNECTED;
else          
    selfconnectivity = Graph.SELFCONNECTED * ones(layernumber);
    selfconnectivity(1:layernumber+1:end) = Graph.NONSELFCONNECTED;                
end

%%% ¡negativity!
negativity = Graph.NONNEGATIVE * ones(layernumber);

%% ¡props!

%%% ¡prop!
B (data, cell) is the input cell containing the multiplex adjacency matrices on the diagonal.
%%%% ¡default!
{[] [] []; [] [] []; [] [] []};

%% ¡props_update!

%%% ¡prop!
A (result, cell) is the cell containing the multiplex weighted adjacency matrices of the multiplex weighted directed graph.
%%%% ¡calculate!
B = g.get('B');
L = length(B); %% number of layers

varargin = {}; %% TODO add props to manage the relevant properties of dediagonalize, semipositivize, binarize
for layer = 1:1:L
    M = B{layer, layer};
    M = dediagonalize(M, varargin{:});  % removes self-connections by removing diagonal from adjacency matrix
    M = semipositivize(M, varargin{:});  % removes negative weights
    M = standardize(M, varargin{:});  % enforces binary adjacency matrix
    B(layer, layer) = {M};
end
% enforce zero off-diagonal values and binary diagonal values
for i = 1:1:size(B, 1)
    for j = i+1:1:size(B, 2)
        B(i, j) = {diagonalize(B{i, j}, varargin{:})};
        B(j, i) = {diagonalize(B{j, i}, varargin{:})};
        B(i, j) = {semipositivize(B{i, j}, varargin{:})};
        B(j, i) = {semipositivize(B{j, i}, varargin{:})};
        B(i, j) = {standardize(B{i, j}, varargin{:})};
        B(j, i) = {standardize(B{j, i}, varargin{:})};
    end
end

A = B;
value = A;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Constructor
%%%% ¡code!
C = rand(randi(10));
B = {C, C; C, C};
g = MultiplexGraphWD('B', B);

A1 = standardize(semipositivize(dediagonalize(C)));
A2 = standardize(semipositivize(diagonalize(C)));
A = {A1, A2; A2, A1};

assert(isequal(g.get('A'), A), ...
    [BRAPH2.STR ':MultiplexGraphWD:' BRAPH2.BUG_ERR], ...
    'MultiplexGraphWD is not constructing well.')
