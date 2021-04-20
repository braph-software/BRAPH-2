%% ¡header!
GraphBU < Graph (g, binary undirected graph) is a binary undirected graph.

%%% ¡description!
In a binary undirected (BU) graph, 
the edges can be either 0 (absence of connection) 
or 1 (existence of connection), and they are undirected. 
The connectivity matrix is symmetric.

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

%%% ¡prop!
ATTEMPTSPEREDGE (parameter, scalar) is the attempts to rewire each edge.
%%%% ¡default!
5

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

%% ¡staticmethods!
function [random_A, swaps] = randomize_A(A, attempts_per_edge)
% RANDOMIZE_A returns a randomized correlation matrix
%
% RANDOM_A = RANDOMIZE(G) returns the randomized matrix
% RANDOM_A. Tries to swap 5 times an edge. The matrix has to
% contain more than 1 edge.
%
% [RANDOM_A, SWAPS] = RANDOMIZE_A(G) attempts to rewire each edge
% 5 times. Returns the randomized matrix RANDOM_A. Returns the
% number of succesful edge swaps.The matrix has to
% contain more than 1 edge. This algorithm was proposed
% by Maslov and Sneppen (Science 296, 910, 2002)
%
% [RANDOM_A, SWAPS] = RANDOMIZE_A(G, ATTEMPTS_PER_EDGE) attempts
% to rewire each edge ATTEMPTS_PER_EDGE times then it returns the
% randomized matrix RANDOM_A. Returns the number of succesful edge swaps.
% The matrix has to contain more than 1 edge.
%
% See also randomize

if nargin < 2
    attempts_per_edge = 5;
end

% remove self connections
A(1:length(A) + 1:numel(A)) = 0;
[I_edges, J_edges] = find(triu(A)); % find the edges
E = length(I_edges); % number of edges

if E == 0
    random_A = A;
    swaps = 0;
    return
end

if E == 1
    A(I_edges(1), J_edges(1)) = 0;
    A(J_edges(1), I_edges(1)) = 0;
    selected_nodes = randperm(size(A, 1), 2);
    A(selected_nodes(1), selected_nodes(2)) = 1;
    A(selected_nodes(2), selected_nodes(1)) = 1;
    random_A = A;
    swaps = 1;
    return
end

random_A = A;
swaps = 0; % number of successful edge swaps
for attempt = 1:1:attempts_per_edge * E
    
    % select two edges
    selected_edges = randperm(E, 2);
    node_start_1 = I_edges(selected_edges(1));
    node_end_1 = J_edges(selected_edges(1));
    node_start_2 = I_edges(selected_edges(2));
    node_end_2 = J_edges(selected_edges(2));
    
    if rand(1) > 0.5
        I_edges(selected_edges(2)) = node_end_2;
        J_edges(selected_edges(2)) = node_start_2;
        
        node_start_2 = I_edges(selected_edges(2));
        node_end_2 = J_edges(selected_edges(2));
    end
    
    % Swap edges if:
    % 1) no edge between node_start_1 and node_end_2
    % 2) no edge between node_start_2 and node_end_1
    % 3) node_start_1 ~= node_start_2
    % 4) node_end_1 ~= node_end_2
    % 5) node_start_1 ~= node_end_2
    % 6) node_start_2 ~= node_end_1
    
    if ~random_A(node_start_1, node_end_2) && ...
            ~random_A(node_start_2, node_end_1) && ...
            node_start_1 ~= node_start_2 && ...
            node_end_1 ~= node_end_2 && ...
            node_start_1 ~= node_end_2 && ...
            node_start_2 ~= node_end_1
        
        % erase old edges
        random_A(node_start_1, node_end_1) = 0;
        random_A(node_end_1, node_start_1) = 0;
        
        random_A(node_start_2, node_end_2) = 0;
        random_A(node_end_2, node_start_2) = 0;
        
        % write new edges
        random_A(node_start_1, node_end_2) = 1;
        random_A(node_end_2, node_start_1) = 1;
        
        random_A(node_start_2, node_end_1) = 1;
        random_A(node_end_1, node_start_2) = 1;
        
        % update edge list
        J_edges(selected_edges(1)) = node_end_2;
        J_edges(selected_edges(2)) = node_end_1;
        
        swaps = swaps + 1;
    end
end
end

%% ¡methods!
function random_g = randomize(g, varargin)
% RANDOMIZE returns a randomized graph and the correlation coefficients
%
% RANDOM_G = RANDOMIZE(G) returns the randomized graph
% RANDOM_G obtained with a randomized correlation
% matrix via the static function randomize_A.
%
% RANDOM_G = RANDOMIZE(G, 'AttemptPerEdge', VALUE, 'NumberOfWeights', VALUE)
% returns the randomized graph RANDOM_G obtained with a randomized correlation
% matrix via the static function randomize_A, it passes the
% attempts per edge and the number of weights specified by the user.
%
% See also randomize_A

% get rules
attempts_per_edge = g.get('ATTEMPTSPEREDGE');

A = cell2mat(g.get('A'));
random_A = GraphBU.randomize_A(A, attempts_per_edge);
random_g = GraphBU('B', random_A);
end

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
