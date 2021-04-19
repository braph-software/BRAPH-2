%% ¡header!
MultiplexWD < Graph (g, multiplex weighted directed graph) is a multiplex weighted directed graph.

%%% ¡description!
In a multiplex weighted directed (WD) graph, 
the edges are associated with a real number between 0 and 1 
indicating the strength of the connection, and they are directed.

%%% ¡graph!
graph = Graph.MULTIPLEX;

%%% ¡connectivity!
connectivity = Graph.WEIGHTED * ones(layernumber);

%%% ¡directionality!
directionality = Graph.DIRECTED * ones(layernumber);

%%% ¡selfconnectivity!
selfconnectivity = Graph.SELFCONNECTED * ones(layernumber);
selfconnectivity(1:layernumber+1:end) = Graph.NONSELFCONNECTED;

%%% ¡negativity!
negativity = Graph.NONNEGATIVE * ones(layernumber);

%% ¡props!

%%% ¡prop!
B (data, cell) is the input cell containing the multiplex adjacency matrices on the diagonal.
%%%% ¡default!
{[] []};

%% ¡props_update!

%%% ¡prop!
A (result, cell) is the cell containing the multiplex weighted adjacency matrices of the multiplex weighted directed graph.
%%%% ¡calculate!
B = g.get('B');
L = length(B); %% number of layers
A = cell(L, L);

varargin = {}; %% TODO add props to manage the relevant properties of dediagonalize, semipositivize, binarize
for i = 1:1:L
    M = dediagonalize(B{i}, varargin{:}); %% removes self-connections by removing diagonal from adjacency matrix
    M = semipositivize(M, varargin{:}); %% removes negative weights
    M = standardize(M, varargin{:}); %% enforces binary adjacency matrix
    A(i, i) = {M};
    if ~isempty(A{1, 1})
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
g = MultiplexWD('B', B);

A1 = standardize(semipositivize(dediagonalize(A)));
A = {A1, eye(length(A)); eye(length(A)), A1};

assert(isequal(g.get('A'), A), ...
    [BRAPH2.STR ':MultiplexWD:' BRAPH2.BUG_ERR], ...
    'MultiplexWD is not constructing well.')
