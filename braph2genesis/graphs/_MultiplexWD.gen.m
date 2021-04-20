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

%%% ¡prop!
ATTEMPTSPEREDGE (parameter, scalar) is the attempts to rewire each edge.
%%%% ¡default!
5

%%% ¡prop!
NUMBEROFWEIGHTS (parameter, scalar) specifies the number of weights sorted at the same time.
%%%% ¡default!
10

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

%% ¡methods!
function random_g = randomize(g, varargin)
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
% The multiplex is randomized layer by layer where randomized
% adjacency matrix of each layer are then integrated in the
% 2-D supra-adjacency matrix cell array.
%
% See also GraphBD

% get rules
number_of_weights = g.get('NUMBEROFWEIGHTS');
attempts_per_edge = g.get('ATTEMPTSPEREDGE');

if nargin<2
    attempts_per_edge = 5;
end

% get A
A = g.get('A');
L = g.layernumber();
random_multi_A = cell(1, size(A, 1));

for li = 1:1:L
    Aii = A{li, li};
    random_A = GraphWD.randomize_A(Aii, attempts_per_edge, number_of_weights);
    random_multi_A(li) = {random_A};
end
random_g = MultiplexWD('B', random_multi_A);
end

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
