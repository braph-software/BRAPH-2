%% ¡header!
GraphWD < Graph (g, weighted directed graph) is a weighted directed graph.

%%% ¡description!
In a weighted directed (WD) graph, the edges are directed and associated 
 with a real number between 0 and 1 indicating the strength of the connection.

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the weighted directed graph.
%%%% ¡default!
'GraphWD'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the weighted undirected graph.
%%%% ¡default!
'In a weighted directed (WD) graph, the edges are directed and associated with a real number between 0 and 1 indicating the strength of the connection.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the weighted directed graph.
%%%% ¡settings!
'GraphWD'

%%% ¡prop!
ID (data, string) is a few-letter code for the weighted directed graph.
%%%% ¡default!
'GraphWD ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the weighted directed graph.
%%%% ¡default!
'GraphWD label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the weighted directed graph.
%%%% ¡default!
'GraphWD notes'

%%% ¡prop!
GRAPH_TYPE (constant, scalar) returns the graph type __Graph.GRAPH__.
%%%% ¡default!
Graph.GRAPH

%%% ¡prop!
CONNECTIVITY_TYPE (query, smatrix) returns the connectivity type __Graph.WEIGHTED__.
%%%% ¡calculate!
value = Graph.WEIGHTED;

%%% ¡prop!
DIRECTIONALITY_TYPE (query, smatrix) returns the directionality type __Graph.DIRECTED__.
%%%% ¡calculate!
value = Graph.DIRECTED;

%%% ¡prop!
SELFCONNECTIVITY_TYPE (query, smatrix) returns the self-connectivity type __Graph.NONSELFCONNECTED__.
%%%% ¡calculate!
value = Graph.NONSELFCONNECTED;

%%% ¡prop!
NEGATIVITY_TYPE (query, smatrix) returns the negativity type __Graph.NONNEGATIVE__.
%%%% ¡calculate!
value = Graph.NONNEGATIVE;

%%% ¡prop!
A (result, cell) is the non-negative adjacency matrix of the weighted directed graph.
%%%% ¡calculate!
B = g.get('B'); %#ok<PROPLC>

B = dediagonalize(B); %#ok<PROPLC> % removes self-connections by removing diagonal from adjacency matrix, equivalent to dediagonalize(B, 'DediagonalizeRule', 0)
B = semipositivize(B, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); %#ok<PROPLC> % removes negative weights
B = standardize(B, 'StandardizeRule', g.get('STANDARDIZE_RULE')); %#ok<PROPLC> % ensures all weights are between 0 and 1

A = {B}; %#ok<PROPLC>
value = A;
%%%% ¡gui!
pr = PanelPropCell('EL', g, 'PROP', GraphWD.A, ...
    'TABLE_HEIGHT', s(40), ...
    'XSLIDERSHOW', false, ...
    'YSLIDERSHOW', false, ...
    'ROWNAME', g.getCallback('ANODELABELS'), ...
    'COLUMNNAME', g.getCallback('ANODELABELS'), ...
    varargin{:});

%%% ¡prop!
COMPATIBLE_MEASURES (constant, classlist) is the list of compatible measures.
%%%% ¡default!
getCompatibleMeasures('GraphWD')

%% ¡props!

%%% ¡prop!
B (data, smatrix) is the input graph adjacency matrix.
%%%% ¡gui!
pr = PanelPropMatrix('EL', g, 'PROP', GraphWD.B, ...
    'TABLE_HEIGHT', s(40), ...
    'ROWNAME', g.getCallback('ANODELABELS'), ...
    'COLUMNNAME', g.getCallback('ANODELABELS'), ...
    varargin{:});

%%% ¡prop!
SEMIPOSITIVIZE_RULE (parameter, option) determines how to remove the negative edges.
%%%% ¡settings!
{'zero', 'absolute'}

%%% ¡prop!
STANDARDIZE_RULE (parameter, option) determines how to normalize the weights between 0 and 1.
%%%% ¡settings!
{'threshold' 'range'}

%% ¡tests!

%%% ¡excluded_props!
[GraphWD.PFGA GraphWD.PFGH]

%%% ¡test!
%%%% ¡name!
Constructor - Empty
%%%% ¡probability!
.01
%%%% ¡code!
B = [];
g = GraphWD('B', B);

g.get('A_CHECK')

A = {standardize(semipositivize(dediagonalize(B)))};
assert(isequal(g.get('A'), A), ...
    [BRAPH2.STR ':GraphWD:' BRAPH2.FAIL_TEST], ...
    'GraphWD is not constructing well.')

%%% ¡test!
%%%% ¡name!
Constructor - Full
%%%% ¡probability!
.01
%%%% ¡code!
B = rand(randi(10));
g = GraphWD('B', B);

g.get('A_CHECK')

A = {standardize(semipositivize(dediagonalize(B)))};
assert(isequal(g.get('A'), A), ...
    [BRAPH2.STR ':GraphWD:' BRAPH2.FAIL_TEST], ...
    'GraphWD is not constructing well.')

%%% ¡test!
%%%% ¡name!
Semipositivize and Standardize Rules
%%%% ¡probability!
.01
%%%% ¡code!
B = 10 * rand(randi(10) + 5) - 5; % random number in U(-5, 5)

g0 = GraphWD('B', B); % 'SEMIPOSITIVIZE_RULE', 'zero', 'STANDARDIZE_RULE', 'threshold'
A0 = B;
A0(A0 < 0) = 0;
A0(A0 > 1) = 1;
A0 = {dediagonalize(A0)};
assert(isequal(g0.get('A'), A0), ...
    [BRAPH2.STR ':GraphWD:' BRAPH2.FAIL_TEST], ...
    'GraphWD is not constructing well.')

g_zero = GraphWD('B', B, 'SEMIPOSITIVIZE_RULE', 'zero'); % 'STANDARDIZE_RULE', 'threshold'
A_zero = B;
A_zero(A_zero < 0) = 0;
A_zero(A_zero > 1) = 1;
A_zero = {dediagonalize(A_zero)};
assert(isequal(g_zero.get('A'), A_zero), ...
    [BRAPH2.STR ':GraphWD:' BRAPH2.FAIL_TEST], ...
    'GraphWD is not constructing well.')

g_absolute = GraphWD('B', B, 'SEMIPOSITIVIZE_RULE', 'absolute'); % 'STANDARDIZE_RULE', 'threshold'
A_absolute = abs(B);
A_absolute(A_absolute < 0) = 0;
A_absolute(A_absolute > 1) = 1;
A_absolute = {dediagonalize(A_absolute)};
assert(isequal(g_absolute.get('A'), A_absolute), ...
    [BRAPH2.STR ':GraphWD:' BRAPH2.FAIL_TEST], ...
    'GraphWD is not constructing well.')

g_theresold = GraphWD('B', B, 'STANDARDIZE_RULE', 'threshold'); % 'SEMIPOSITIVIZE_RULE', 'zero'
A_theresold = B;
A_theresold(A_theresold < 0) = 0;
A_theresold(A_theresold > 1) = 1;
A_theresold = {dediagonalize(A_theresold)};
assert(isequal(g_theresold.get('A'), A_theresold), ...
    [BRAPH2.STR ':GraphWD:' BRAPH2.FAIL_TEST], ...
    'GraphWD is not constructing well.')

g_zero_theresold = GraphWD('B', B, 'SEMIPOSITIVIZE_RULE', 'zero', 'STANDARDIZE_RULE', 'threshold');
A_zero_theresold = B;
A_zero_theresold(A_zero_theresold < 0) = 0;
A_zero_theresold(A_zero_theresold > 1) = 1;
A_zero_theresold = {dediagonalize(A_zero_theresold)};
assert(isequal(g_zero_theresold.get('A'), A_zero_theresold), ...
    [BRAPH2.STR ':GraphWD:' BRAPH2.FAIL_TEST], ...
    'GraphWD is not constructing well.')

g_absolute_theresold = GraphWD('B', B, 'SEMIPOSITIVIZE_RULE', 'absolute', 'STANDARDIZE_RULE', 'threshold');
A_absolute_theresold = abs(B);
A_absolute_theresold(A_absolute_theresold < 0) = 0;
A_absolute_theresold(A_absolute_theresold > 1) = 1;
A_absolute_theresold = {dediagonalize(A_absolute_theresold)};
assert(isequal(g_absolute_theresold.get('A'), A_absolute_theresold), ...
    [BRAPH2.STR ':GraphWD:' BRAPH2.FAIL_TEST], ...
    'GraphWD is not constructing well.')

g_range = GraphWD('B', B, 'STANDARDIZE_RULE', 'range'); % 'SEMIPOSITIVIZE_RULE', 'zero'
A_range = dediagonalize(B);
A_range(A_range < 0) = 0;
A_range = A_range / max(max(A_range));
A_range = {A_range};
assert(isequal(g_range.get('A'), A_range), ...
    [BRAPH2.STR ':GraphWD:' BRAPH2.FAIL_TEST], ...
    'GraphWD is not constructing well.')

g_zero_range = GraphWD('B', B, 'SEMIPOSITIVIZE_RULE', 'zero', 'STANDARDIZE_RULE', 'range');
A_zero_range = dediagonalize(B);
A_zero_range(A_zero_range < 0) = 0;
A_zero_range = A_zero_range / max(max(A_zero_range));
A_zero_range = {A_zero_range};
assert(isequal(g_zero_range.get('A'), A_zero_range), ...
    [BRAPH2.STR ':GraphWD:' BRAPH2.FAIL_TEST], ...
    'GraphWD is not constructing well.')

g_absolute_range = GraphWD('B', B, 'SEMIPOSITIVIZE_RULE', 'absolute', 'STANDARDIZE_RULE', 'range');
A_absolute_range = abs(B);
A_absolute_range = standardize(dediagonalize(A_absolute_range), 'StandardizeRule', 'range');
A_absolute_range = {A_absolute_range};
assert(isequal(g_absolute_range.get('A'), A_absolute_range), ...
    [BRAPH2.STR ':GraphWD:' BRAPH2.FAIL_TEST], ...
    'GraphWD is not constructing well.')









%% ¡_props!

%%% ¡_prop!
ATTEMPTSPEREDGE (parameter, scalar) is the attempts to rewire each edge.
%%%% ¡_default!
5

%%% ¡_prop!
NUMBEROFWEIGHTS (parameter, scalar) specifies the number of weights sorted at the same time.
%%%% ¡_default!
10

%% ¡_staticmethods!
function [random_A, correlation_coefficients] = randomize_A(A, attempts_per_edge, number_of_weights)
    % RANDOMIZE_A returns a randomized correlation matrix
    % This algorithm was proposed by Rubinov and Sporns (Neuroimage 56, 4, 2011).
    %
    % RANDOM_A = RANDOMIZE_A(G, ATTEMPTS_PER_EDGE, NUMBER_OF_WEIGHTS)
    % returns the randomized matrix. RANDOM_A. NUMBER_OF_WEIGHTS
    % specifies the number of weights sorted at the same time.
    % ATTEMPTS_PER_EDGE is passed as an argument to GraphWD.
    %
    % [RANDOM_A, CORRELATION_COEFFICIENTS] = RANDOMIZE_A(G)
    % returns the randomized matrix. RANDOM_A. NUMBER_OF_WEIGHTS
    % specifies the number of weights sorted at the same time, it
    % will be default value of 10. Returns the correlation coefficients
    % between the original and randomized nodal strengths.
    % High coefficients indicate more accurate preservation of
    % the strength sequences. ATTEMPTS_PER_EDGE is passed as an
    % argument to GraphWD, it will be default value of 5.
    %
    % [RANDOM_A, CORRELATION_COEFFICIENTS] = RANDOMIZE_A(G, ATTEMPTS_PER_EDGE, NUMBER_OF_WEIGHTS)
    % returns the randomized matrix. RANDOM_A. NUMBER_OF_WEIGHTS
    % specifies the number of weights sorted at the same time. Returns the
    % correlation coefficients between the original and randomized nodal
    % strengths. High coefficients indicate more accurate preservation of
    % the strength sequences. ATTEMPTS_PER_EDGE is passed as an
    % argument to GraphWD.
    %
    % See also randomize.

    if nargin < 2
        attempts_per_edge = 5;
    end

    if nargin < 3
        number_of_weights = 10;
    end

    W = A;  % swaps with A
    A = GraphWD.randomize_A(W, attempts_per_edge);
    % remove self connections
    A(1:length(A)+1:numel(A)) = 0;
    W(1:length(W)+1:numel(W)) = 0;
    W_bin = W > 0;
    N = size(A,1); % number of nodes
    random_A = zeros(N); % initialize null model matrix

    S_in = sum(W,1).'; % nodal in-strength
    S_out = sum(W,2);  % nodal out-strength
    W_sorted = sort(W(W_bin)); % sorted weights vector
    % find all the edges
    [I_edges, J_edges] = find(A);
    edges = I_edges + (J_edges-1)*N;
    % expected weights matrix
    P = (S_out*S_in.');

    for m = numel(W_sorted):-number_of_weights:1

        % sort the expected weights matrix
        [~, ind] = sort(P(edges));

        % random index of sorted expected weight
        selected_indices = randperm(m, min(m,number_of_weights)).';
        selected_edges = ind(selected_indices);

        % assign corresponding sorted weight at this index
        random_A(edges(selected_edges)) = W_sorted(selected_indices);

        % recalculate expected weight for node I_edges(selected_edge)
        WAi = accumarray(I_edges(selected_edges), W_sorted(selected_indices), [N,1]);
        Iu = any(WAi,2);
        % readjust expected weight probabilities
        F = 1 - WAi(Iu)./S_out(Iu);
        P(Iu,:) = P(Iu,:).*F(:,ones(1,N));
        % readjust in-strength
        S_out(Iu) = S_out(Iu) - WAi(Iu);

        % recalculate expected weight for node J_edges(selected_edge)
        WAj = accumarray(J_edges(selected_edges), W_sorted(selected_indices), [N,1]);
        Ju = any(WAj,2);
        % readjust expected weight probabilities
        F = 1 - WAj(Ju)./S_in(Ju);
        P(:,Ju) = P(:,Ju).*F(:,ones(1,N)).';
        % readjust out-strength
        S_in(Ju) = S_in(Ju) - WAj(Ju);

        % remove the edge/weight from further consideration
        selected_edges = ind(selected_indices);
        edges(selected_edges) = [];
        I_edges(selected_edges) = [];
        J_edges(selected_edges) = [];
        W_sorted(selected_indices) = [];
    end

    % calculate correlation of original vs reassinged in/out strength
    rpos_in = corrcoef(sum(W,1), sum(random_A,1));
    rpos_out = corrcoef(sum(W,2), sum(random_A,2));
    correlation_coefficients = [rpos_in(2) rpos_out(2)];
end

%% ¡_methods!
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
    random_A = GraphWD.randomize_A(A, attempts_per_edge, number_of_weights);
    random_g = GraphWD('B', random_A);
end