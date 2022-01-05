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

%% ¡staticmethods!
function [random_A, correlation_coefficients] = randomize_A(A, attempts_per_edge, number_of_weights)
    % RANDOMIZE_A returns a randomized correlation matrix
    % This algorithm was proposed by Rubinov and Sporns (Neuroimage 56, 4, 2011).
    %
    % RANDOM_A = RANDOMIZE_A(G, ATTEMPTS_PER_EDGE, NUMBER_OF_WEIGHTS)
    % returns the randomized matrix. RANDOM_A. NUMBER_OF_WEIGHTS
    % specifies the number of weights sorted at the same time.
    % ATTEMPTS_PER_EDGE is passed as an argument to GraphBD.
    %
    % [RANDOM_A, CORRELATION_COEFFICIENTS] = RANDOMIZE_A(G)
    % returns the randomized matrix. RANDOM_A. NUMBER_OF_WEIGHTS
    % specifies the number of weights sorted at the same time, it
    % will be default value of 10. Returns the correlation coefficients
    % between the original and randomized nodal strengths.
    % High coefficients indicate more accurate preservation of
    % the strength sequences. ATTEMPTS_PER_EDGE is passed as an
    % argument to GraphBD, it will be default value of 5.
    %
    % [RANDOM_A, CORRELATION_COEFFICIENTS] = RANDOMIZE_A(G, ATTEMPTS_PER_EDGE, NUMBER_OF_WEIGHTS)
    % returns the randomized matrix. RANDOM_A. NUMBER_OF_WEIGHTS
    % specifies the number of weights sorted at the same time. Returns the
    % correlation coefficients between the original and randomized nodal
    % strengths. High coefficients indicate more accurate preservation of
    % the strength sequences. ATTEMPTS_PER_EDGE is passed as an
    % argument to GraphBD.
    %
    % See also randomize.

    if nargin < 2
        attempts_per_edge = 5;
    end

    if nargin < 3
        number_of_weights = 10;
    end

    W = A;  % swaps with A
    A = GraphBU.randomize_A(W, attempts_per_edge);

    % remove self connections
    A(1:length(A)+1:numel(A)) = 0;
    W(1:length(W)+1:numel(W)) = 0;
    W_bin = W > 0;
    N = size(A,1); % number of nodes
    random_A = zeros(N); % intialize null model matrix

    S = sum(W,2); % nodal strength
    W_sorted = sort(W(triu(W_bin))); % sorted weights vector
    % find all the edges
    [I_edges, J_edges] = find(triu(A));
    edges = I_edges + (J_edges-1)*N;
    % expected weights matrix
    P = (S*S.');

    for m = numel(W_sorted):-number_of_weights:1

        % sort the expected weights matrix
        [~, ind] = sort(P(edges));

        % random index of sorted expected weight
        selected_indices = randperm(m, min(m,number_of_weights)).';
        selected_edges = ind(selected_indices);

        % assign corresponding sorted weight at this index
        random_A(edges(selected_edges)) = W_sorted(selected_indices);

        % recalculate expected weight for node I_edges(selected_edge)
        % cumulative weight
        WA = accumarray([I_edges(selected_edges); J_edges(selected_edges)], W_sorted([selected_indices; selected_indices]), [N,1]);
        IJu = any(WA,2);
        F = 1 - WA(IJu)./S(IJu);
        F = F(:,ones(1,N));
        % readjust expected weight probabilities
        P(IJu,:) = P(IJu,:).*F;
        P(:,IJu) = P(:,IJu).*F.';
        % re-adjust strengths
        S(IJu) = S(IJu) - WA(IJu);

        % remove the edge/weight from further consideration
        selected_edges = ind(selected_indices);
        edges(selected_edges) = [];
        I_edges(selected_edges) = [];
        J_edges(selected_edges) = [];
        W_sorted(selected_indices) = [];
    end

    % calculate the final matrix
    random_A = random_A + transpose(random_A);

    % calculate correlation of original vs reassinged strength
    rpos = corrcoef(sum(W), sum(random_A));
    correlation_coefficients = rpos(2);
end

%% ¡methods!
function random_g = randomize(g)
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
    number_of_weights = g.get('NUMBEROFWEIGHTS');
    attempts_per_edge = g.get('ATTEMPTSPEREDGE');

    A = cell2mat(g.get('A'));
    random_A = GraphWU.randomize_A(A, attempts_per_edge, number_of_weights);
    random_g = GraphWU('B', random_A);
end

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