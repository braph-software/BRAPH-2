%% ¡header!
MultiplexGraphBD < Graph (g, multiplex binary directed graph) is a multiplex binary directed graph.

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
if layernumber == 1
    selfconnectivity_type = Graph.SELFCONNECTED;
else          
    selfconnectivity_type = Graph.SELFCONNECTED * ones(layernumber);
    selfconnectivity_type(1:layernumber+1:end) = Graph.NONSELFCONNECTED;                
end

%%% ¡negativity!
negativity = Graph.NONNEGATIVE * ones(layernumber);

%% ¡props!

%%% ¡prop!
B (data, cell) is the input cell containing the multiplex adjacency matrices on the diagonal.
%%%% ¡default!
{
round(rand(4))            round(diag(rand(4, 1)))   round(diag(rand(4, 1)))	
round(diag(rand(4, 1)))   round(rand(4))            round(diag(rand(4, 1)))	
round(diag(rand(4, 1)))   round(diag(rand(4, 1)))   round(rand(4))      
};

%% ¡props_update!

%%% ¡prop!
A (result, cell) is the cell containing the multiplex binary adjacency matrices of the multiplex binary directed graph.
%%%% ¡calculate!
B = g.get('B');
L = length(B); %% number of layers

varargin = {}; %% TODO add props to manage the relevant properties of dediagonalize, semipositivize, binarize
for layer = 1:1:L
    M = B{layer, layer};
    M = dediagonalize(M, varargin{:});  % removes self-connections by removing diagonal from adjacency matrix
    M = semipositivize(M, varargin{:});  % removes negative weights
    M = binarize(M, varargin{:});  % enforces binary adjacency matrix
    B(layer, layer) = {M};
end
% enforce zero off-diagonal values and binary diagonal values
for i = 1:1:size(B, 1)
    for j = i+1:1:size(B, 2)
        B(i, j) = {diagonalize(B{i, j}, varargin{:})};
        B(j, i) = {diagonalize(B{j, i}, varargin{:})};
        B(i, j) = {semipositivize(B{i, j}, varargin{:})};
        B(j, i) = {semipositivize(B{j, i}, varargin{:})};
        B(i, j) = {binarize(B{i, j}, varargin{:})};
        B(j, i) = {binarize(B{j, i}, varargin{:})};
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
g = MultiplexGraphBD('B', B);

A1 = {binarize(semipositivize(dediagonalize(C)))};
A2 = {binarize(semipositivize(diagonalize(C)))};
A = {A1, A2; A2, A1};

assert(isequal(g.get('A'), A), ...
    [BRAPH2.STR ':GraphBD:' BRAPH2.BUG_ERR], ...
    'GraphBD is not constructing well.')

