%% ¡header!
GraphWU < Graph (g, weighted undirected graph) is a weighted undirected graph.

%%% ¡description!
In a weighted undirected (WU) graph, the edges are are undirected and associated 
 with a real number between 0 and 1 indicating the strength of the connection.
The connectivity matrix is symmetric.

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the weighted undirected graph.
%%%% ¡default!
'GraphWU'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the weighted undirected graph.
%%%% ¡default!
'In a weighted undirected (WU) graph, the edges are are undirected and associated with a real number between 0 and 1 indicating the strength of the connection. The connectivity matrix is symmetric.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the weighted undirected graph.
%%%% ¡settings!
'GraphWU'

%%% ¡prop!
ID (data, string) is a few-letter code for the weighted undirected graph.
%%%% ¡default!
'GraphWU ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the weighted undirected graph.
%%%% ¡default!
'GraphWU label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the weighted undirected graph.
%%%% ¡default!
'GraphWU notes'

%%% ¡prop!
GRAPH_TYPE (constant, scalar) returns the graph type __Graph.GRAPH__.
%%%% ¡default!
Graph.GRAPH

%%% ¡prop!
CONNECTIVITY_TYPE (query, smatrix) returns the connectivity type __Graph.WEIGHTED__.
%%%% ¡calculate!
value = Graph.WEIGHTED;

%%% ¡prop!
DIRECTIONALITY_TYPE (query, smatrix) returns the directionality type __Graph.UNDIRECTED__.
%%%% ¡calculate!
value = Graph.UNDIRECTED;

%%% ¡prop!
SELFCONNECTIVITY_TYPE (query, smatrix) returns the self-connectivity type __Graph.NONSELFCONNECTED__.
%%%% ¡calculate!
value = Graph.NONSELFCONNECTED;

%%% ¡prop!
NEGATIVITY_TYPE (query, smatrix) returns the negativity type __Graph.NONNEGATIVE__.
%%%% ¡calculate!
value = Graph.NONNEGATIVE;

%%% ¡prop!
A (result, cell) is the symmetric non-negative adjacency matrix of the weighted undirected graph.
%%%% ¡calculate!
B = g.get('B'); %#ok<PROPLC>

B = symmetrize(B, 'SymmetrizeRule', g.get('SYMMETRIZE_RULE')); %#ok<PROPLC> % enforces symmetry of adjacency matrix
B = dediagonalize(B); %#ok<PROPLC> % removes self-connections by removing diagonal from adjacency matrix, equivalent to dediagonalize(B, 'DediagonalizeRule', 0)
B = semipositivize(B, 'SemipositivizeRule', g.get('SEMIPOSITIVIZE_RULE')); %#ok<PROPLC> % removes negative weights
B = standardize(B, 'StandardizeRule', g.get('STANDARDIZE_RULE')); %#ok<PROPLC> % ensures all weights are between 0 and 1

A = {B}; %#ok<PROPLC>
value = A;
%%%% ¡gui!
pr = PanelPropCell('EL', g, 'PROP', GraphWU.A, ...
    'TABLE_HEIGHT', s(40), ...
    'XSLIDERSHOW', false, ...
    'YSLIDERSHOW', false, ...
    'ROWNAME', g.getCallback('ANODELABELS'), ...
    'COLUMNNAME', g.getCallback('ANODELABELS'), ...
    varargin{:});

%%% ¡prop!
COMPATIBLE_MEASURES (constant, classlist) is the list of compatible measures.
%%%% ¡default!
getCompatibleMeasures('GraphWU')

%% ¡props!

%%% ¡prop!
B (data, smatrix) is the input graph adjacency matrix.
%%%% ¡gui!
pr = PanelPropMatrix('EL', g, 'PROP', GraphWU.B, ...
    'TABLE_HEIGHT', s(40), ...    
    'ROWNAME', g.getCallback('ANODELABELS'), ...
    'COLUMNNAME', g.getCallback('ANODELABELS'), ...
    varargin{:});

%%% ¡prop!
SYMMETRIZE_RULE (parameter, option) determines how to symmetrize the matrix.
%%%% ¡settings!
{'max', 'sum', 'average', 'min'}

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
[GraphWU.PFGA GraphWU.PFGH]

%%% ¡test!
%%%% ¡name!
Constructor - Empty
%%%% ¡probability!
.01
%%%% ¡code! 
B = [];
g = GraphWU('B', []);

g.get('A_CHECK')

A = {[]};
assert(isequal(g.get('A'), A), ...
    [BRAPH2.STR ':GraphWU:' BRAPH2.FAIL_TEST], ...
    'GraphWU is not constructing well.')

%%% ¡test!
%%%% ¡name!
Constructor - Full
%%%% ¡probability!
.01
%%%% ¡code! 
B = rand(randi(10));
g = GraphWU('B', B);

g.get('A_CHECK')

A = {standardize(symmetrize(semipositivize(dediagonalize(B))))};
assert(isequal(g.get('A'), A), ...
    [BRAPH2.STR ':GraphWU:' BRAPH2.FAIL_TEST], ...
    'GraphWU is not constructing well.')

%%% ¡test!
%%%% ¡name!
Symmetrize, Semipositivize and Standardize Rules
%%%% ¡probability!
.01
%%%% ¡code!
B = 10 * rand(randi(10) + 5) - 5; % random number in U(-5, 5)

g0 = GraphWU('B', B); % 'SYMMETRIZE_RULE', 'max', 'SEMIPOSITIVIZE_RULE', 'zero', 'STANDARDIZE_RULE', 'threshold'
A0 = max(B, B');
A0(A0 < 0) = 0;
A0(A0 > 1) = 1;
A0 = {dediagonalize(A0)};
assert(isequal(g0.get('A'), A0), ...
    [BRAPH2.STR ':GraphWD:' BRAPH2.FAIL_TEST], ...
    'GraphWD is not constructing well.')

symmetrize_rules = GraphWU.getPropSettings('SYMMETRIZE_RULE');
semipositivize_rules = GraphWU.getPropSettings('SEMIPOSITIVIZE_RULE');
standardize_rules = GraphWU.getPropSettings('STANDARDIZE_RULE');

for i = 1:1:length(symmetrize_rules)
    symmetrize_rule = symmetrize_rules{i};
    for j = 1:1:length(semipositivize_rules)
        semipositivize_rule = semipositivize_rules{j};
        for k = 1:1:length(standardize_rules)
            standardize_rule = standardize_rules{k};
            g0 = GraphWU('B', B, 'SYMMETRIZE_RULE', symmetrize_rule, 'SEMIPOSITIVIZE_RULE', semipositivize_rule, 'STANDARDIZE_RULE', standardize_rule);
        end
    end
end






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

    % correction for multigraphs
    if Graph.is_multigraph(g)
        tmp_b = g.get('B');
        tmp_g = GraphWU('B', tmp_b);
        tmp_A = cell2mat(tmp_g.get('A'));
        random_B = GraphWU.randomize_A(tmp_A, attempts_per_edge, number_of_weights);
        if isa(g, 'MultigraphBUD')
            random_g = MultigraphBUD('B', random_B, 'Densities', g.get('DENSITIES'));
        else
            random_g = MultigraphBUT('B', random_B, 'Thresholds', g.get('THRESHOLDS'));
        end
    else
        A = cell2mat(g.get('A'));
        random_A = GraphWU.randomize_A(A, attempts_per_edge, number_of_weights);
        random_g = GraphWU('B', random_A);
    end
end