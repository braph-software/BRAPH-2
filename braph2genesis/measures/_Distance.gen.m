%% ¡header!
Distance < Measure (m, distance) is the distance.

%%% ¡description!
The distance of a graph is the shortest path 
between all pairs of nodes within a layer of the graph.

%%% ¡shape!
shape = Measure.BINODAL;

%%% ¡scope!
scope = Measure.UNILAYER;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
GraphBD
GraphBU
GraphWD
GraphWU
MultigraphBUD
MultigraphBUT
MultiplexBD
MultiplexBU
MultiplexWD
MultiplexWU

%% ¡props!
%%% ¡prop! 
EDGESNUMBER (DATA, CELL) is a cell of the number of edges matrix

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the distance.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)

distance = cell(g.layernumber(), 1);
connectivity_type =  g.getConnectivityType(g.layernumber());
for li = 1:1:g.layernumber()

    Aii = A{li, li};
    connectivity_layer = connectivity_type(li, li);

    if connectivity_layer == Graph.WEIGHTED  % weighted graphs
        distance(li) = {m.getWeightedCalculation(Aii)};
    else  % binary graphs
        distance(li) = {m.getBinaryCalculation(Aii)};
    end
end

value = distance;

%% ¡methods!
function weighted_distance = getWeightedCalculation(m, A)
    %GETWEIGHTEDCALCULATION calculates the distance value of a weighted adjacency matrix.
    %
    % WEIGHTED_DISTANCE = GETWEIGHTEDCALCULATION(M, A) returns the value of the
    %  distance of a weighted adjacency matrix A.

    ind = A~=0;
    A(ind) = A(ind).^-1;
    n = length(A);
    D = inf(n);
    D(1:n+1:end) = 0; % distance matrix
    B = zeros(n); % number of edges matrix

    for u = 1:n
        S = true(1, n); % distance permanence (true is temporary)
        L1 = A;
        V = u;

        while 1
            S(V) = 0; % distance u->V is now permanent
            L1(:, V) = 0; % no in-edges as already shortest

            for v = V
                T = find(L1(v, :)); % neighbours of shortest nodes
                [d, wi] = min([D(u, T);D(u, v)+L1(v, T)]);
                D(u, T) = d; % smallest of old/new path lengths
                ind = T(wi==2); % indices of lengthened paths
                B(u, ind) = B(u, v) + 1; % increment no. of edges in lengthened paths
            end

            minD = min(D(u, S));
            if isempty(minD) || isinf(minD) % isempty: all nodes reached;
                break % isinf: some nodes cannot be reached
            end

            V = find(D(u,:)==minD);
        end
    end
    % m.B = B;
    cell_B = m.get('EDGESNUMBER');
    cell_B{end+1} = B;
    m.set('EDGESNUMBER', cell_B);
    weighted_distance = D;
end
function binary_distance = getBinaryCalculation(m, A)
    %GETBINARYCALCULATION calculates the distance value of a binary adjacency matrix.
    %
    % BINARY_DISTANCE = GETBINARYCALCULATION(A) returns the value of the
    %  distance of a binary adjacency matrix A.

    l = 1; % path length
    D = A; % distance matrix

    Lpath = A;
    Idx = true;
    while any(Idx(:))
        l = l+1;
        Lpath = Lpath * A;
        Idx = (Lpath ~= 0) & (D == 0);
        D(Idx) = l;
    end

    D(~D) = inf; % assign inf to disconnected nodes
    binary_distance = dediagonalize(D); % assign 0 to the diagonal
end     

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBU
%%%% ¡code!
B = [
    0	1   1	1   0
    1   0   0   1   0
    1   0   0   1   0
    1   1   1   0   0
    0	0	0   0   0
    ];

known_distance = {[
    0   1   1   1   Inf
    1   0   2   1   Inf
    1   2   0   1   Inf
    1   1   1   0   Inf
    Inf Inf Inf Inf 0
    ]};

g = GraphBU('B', B);

m_outside_g = Distance('G', g);
assert(isequal(m_outside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.BUG_ERR], ...
    'Distance is not being calculated correctly for GraphBU.')

m_inside_g = g.getMeasure('Distance');
assert(isequal(m_inside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.BUG_ERR], ...
    'Distance is not being calculated correctly for GraphBU.')

%%% ¡test!
%%%% ¡name!
GraphBD
%%%% ¡code!
B = [
    0   1	1   1   0
    1	0   0   0   0
    1   1   0   1   0
    1   1   0   0   0
    0	0   0   0   0
    ];

known_distance = {[
    0   1   1   1   Inf
    1   0   2   2   Inf
    1   1   0   1   Inf
    1   1   2   0   Inf
    Inf Inf Inf Inf 0
    ]};

g = GraphBD('B', B);

m_outside_g = Distance('G', g);
assert(isequal(m_outside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.BUG_ERR], ...
    'Distance is not being calculated correctly for GraphBD.')

m_inside_g = g.getMeasure('Distance');
assert(isequal(m_inside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.BUG_ERR], ...
    'Distance is not being calculated correctly for GraphBD.')

%%% ¡test!
%%%% ¡name!
GraphWU
%%%% ¡code!
B = [
    0     .1    .2  .25  0
    .125  0     0   0    0
    .2    .5    0   .25  0
    .125  10    0   0    0
    0     0     0   0    0
    ];

known_distance = {[
    0   5   5   4   Inf
    5   0   2   1   Inf
    5   2   0   3   Inf
    4   1   3   0   Inf
    Inf Inf Inf Inf 0
    ]};

g = GraphWU('B', B);

m_outside_g = Distance('G', g);
assert(isequal(m_outside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.BUG_ERR], ...
    'Distance is not being calculated correctly for GraphWU.')

m_inside_g = g.getMeasure('Distance');
assert(isequal(m_inside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.BUG_ERR], ...
    'Distance is not being calculated correctly for GraphWU.')


%%% ¡test!
%%%% ¡name!
GraphWD
%%%% ¡code!
B = [
    0     .1  .2  .25  0
    .125  0   0   0    0
    .2    .5  0   .25  0
    .125  10   0   0   0
    0     0   0   0    0
    ];

known_distance = {[
    0   5   5   4   Inf
    8   0   13  12  Inf
    5   2   0   4   Inf
    8   1   13  0   Inf
    Inf Inf Inf Inf 0
    ]};

g = GraphWD('B', B);

m_outside_g = Distance('G', g);
assert(isequal(m_outside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.BUG_ERR], ...
    'Distance is not being calculated correctly for GraphWD.')

m_inside_g = g.getMeasure('Distance');
assert(isequal(m_inside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.BUG_ERR], ...
    'Distance is not being calculated correctly for GraphWD.')

%%% ¡test!
%%%% ¡name!
MultigraphBUT
%%%% ¡code!
B = [
    0   .2   .7
    .2   0   0
    .7   0   0
    ];

thresholds = [0 .5 1];

known_distance = {
    [
    0   1   1
    1   0   2
    1   2   0
    ]
    [
    0   Inf 1
    Inf 0   Inf
    1 Inf 0
    ]
    [
    0   Inf Inf
    Inf 0   Inf
    Inf Inf 0
    ]
    };

g = MultigraphBUT('B', B, 'THRESHOLDS', thresholds);

m_outside_g = Distance('G', g);
assert(isequal(m_outside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.BUG_ERR], ...
    'Distance is not being calculated correctly for MultigraphBUT.')

m_inside_g = g.getMeasure('Distance');
assert(isequal(m_inside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.BUG_ERR], ...
    'Distance is not being calculated correctly for MultigraphBUT.')


%%% ¡test!
%%%% ¡name!
MultigraphBUD
%%%% ¡code!
B = [
    0   .2   .7
    .2   0   .1
    .7  .1   0
    ];

densities = [0 33 67 100];

known_distance = {
    [
    0   Inf Inf
    Inf 0   Inf
    Inf Inf 0    
    ]
    [
    0   Inf 1
    Inf 0   Inf
    1   Inf 0
    ]
    [
    0   1   1
    1   0   2
    1   2   0
    ]
    [
    0   1   1
    1   0   1
    1   1   0
    ]
    };

g = MultigraphBUD('B', B, 'DENSITIES', densities);

m_outside_g = Distance('G', g);
assert(isequal(m_outside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.BUG_ERR], ...
    'Distance is not being calculated correctly for MultigraphBUD.')

m_inside_g = g.getMeasure('Distance');
assert(isequal(m_inside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.BUG_ERR], ...
    'Distance is not being calculated correctly for MultigraphBUD.')

%%% ¡test!
%%%% ¡name!
MultiplexBU
B11 = [
    0	1   1  0    0;
    1   0   0  0	0; 
    1   1   0   1   0;
    1	1   0   0   0;
    0   0   0   0   0;
    ];
B22 = [
    0   1   1   1   0; 
    1   0   0   0   0;
    1   1   0   1   0;
    1   1   0   0   0;
    0   0   0   0   0;
    ];
B = {B11 B22};

known_distance = {
    [
    0   1   1   1   Inf;
    1   0   1   1   Inf;
    1   1   0   1   Inf;
    1   1   1   0   Inf;
    Inf Inf Inf Inf 0;
    ]
    [
    0   1   1   1   Inf;
    1   0   1   1   Inf;
    1   1   0   1   Inf;
    1   1   1   0   Inf;
    Inf Inf Inf Inf 0;
    ]
    };

g = MultiplexBU('B', B);
distance = Distance('G', g);

assert(isequal(distance.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.BUG_ERR], ...
    'Distance is not being calculated correctly for MultiplexBU.')

%%% ¡test!
%%%% ¡name!
MultiplexBD
B11 = [
    0	1   1   1   0;
    1   0   0   0	0; 
    1   1   0   1   0;
    1	1   0   0   0;
    0   0   0   0   0;
    ];
B22 = [
    0	1   1   1   0;
    1   0   0   0	0; 
    1   1   0   1   0;
    1	1   0   0   0;
    0   0   0   0   0;
    ];
B = {B11 B22};
known_distance = {
    [
    0   1   1   1   Inf;
    1   0   2   2   Inf;
    1   1   0   1   Inf;
    1   1   2   0   Inf;
    Inf Inf Inf Inf 0;
    ]
    [
    0   1   1   1   Inf;
    1   0   2   2   Inf;
    1   1   0   1   Inf;
    1   1   2   0   Inf;
    Inf Inf Inf Inf 0;
    ]
    };

g = MultiplexBD('B', B);
distance = Distance('G', g);

assert(isequal(distance.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.BUG_ERR], ...
    'Distance is not being calculated correctly for MultiplexBD.')

%%% ¡test!
%%%% ¡name!
MultiplexWU
B11 = [
    0       .1  .2  .25  0;
    .125    0   0   0    0;
    .2      .5  0   .25  0;
    .125    10  0   0    0;
    0       0   0   0    0;
    ];
B22 = [
    0       .1  .2  .25  0;
    .125    0   0   0    0;
    .2      .5  0   .25  0;
    .125    10  0   0    0;
    0       0   0   0    0;
    ];
B = {B11 B22};

known_distance = {
    [
    0   5   5   4   Inf;
    5   0   2   1   Inf;
    5   2   0   3   Inf;
    4   1   3   0   Inf;
    Inf Inf Inf Inf 0;
	]
    [
    0   5   5   4   Inf;
    5   0   2   1   Inf;
    5   2   0   3   Inf;
    4   1   3   0   Inf;
    Inf Inf Inf Inf 0;
	]
    };

g = MultiplexWU('B', B);
distance = Distance('G', g);

assert(isequal(distance.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.BUG_ERR], ...
    'Distance is not being calculated correctly for MultiplexWU.')

%%% ¡test!
%%%% ¡name!
MultiplexWD
B11 = [
    0       .1  .2  .25  0;
    .125    0   0   0    0;
    .2      .5  0   .25  0;
    .125    10  0   0    0;
    0       0   0   0    0;
    ];
B22 = [
    0       .1  .2  .25  0;
    .125    0   0   0    0;
    .2      .5  0   .25  0;
    .125    10  0   0    0;
    0       0   0   0    0;
    ];
B = {B11 B22};

known_distance = {
    [
    0   5   5   4   Inf;
    8   0   13  12  Inf;
    5   2   0   4   Inf;
    8   1   13  0   Inf;
    Inf Inf Inf Inf 0;
    ]
    [
    0   5   5   4   Inf;
    8   0   13  12  Inf;
    5   2   0   4   Inf;
    8   1   13  0   Inf;
    Inf Inf Inf Inf 0;
    ]
    };

g = MultiplexWD('B', B);
distance = Distance('G', g);

assert(isequal(distance.get('M'), known_distance), ...
    [BRAPH2.STR ':Distance:' BRAPH2.BUG_ERR], ...
    'Distance is not being calculated correctly for MultiplexWD.')
