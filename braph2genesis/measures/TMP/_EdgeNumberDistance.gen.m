%% ¡header!
EdgeNumberDistance < Distance (m, edge number distance) is the graph edge number distance.

%%% ¡description!
The edge distance number of a graph is the number of edges in the shortest
weighted path between two nodes within a layer.

%%% ¡shape!
shape = Measure.BINODAL;

%%% ¡scope!
scope = Measure.UNILAYER;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
GraphWD
GraphWU
MultiplexWD
MultiplexWU

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the edge number distance.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)

edge_number_distance = cell(g.layernumber(), 1);

for li = 1:1:g.layernumber()
    Aii = A{li, li};
    edge_number_distance(li) = {m.getEdgeNumberDistance(Aii)};
end

value = edge_number_distance;

%% ¡methods!
function edge_number_distance = getEdgeNumberDistance(m, A)
    %GETEDGENUMBERDISTANCE calculates the edge distance number of a graph.

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
    edge_number_distance = B;
end
%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphWU
%%%% ¡code!
A = [
    0 .1 .2 .25 0;
    .125 0 0 0  0;
    .2 .5 0 .25 0;
    .125 10 0 0 0;
    0  0  0  0  0
    ];

known_value = {[
                0 2 1 1 0;
                2 0 1 1 0;
                1 1 0 2 0;
                1 1 2 0 0;
                0 0 0 0 0;
                ]};

g = GraphWU('B', A);
edge_number_distance = EdgeNumberDistance('G', g).get('M');

assert(isequal(edge_number_distance, known_value), ...
    [BRAPH2.STR ':EdgeNumberDistance:' BRAPH2.BUG_ERR], ...
    'EdgeNumberDistance is not being calculated correctly for GraphWU.')

%%% ¡test!
%%%% ¡name!
MultiplexWD
%%%% ¡code!
A11 = [
        0 .1 .2 .25 0;
        .125 0 0 0  0;
        .2 .5 0 .25 0;
        .125 10 0 0 0;
        0  0  0  0  0
       ];
A22 = [
        0 .1 .2 .25 0;
        .125 0 0 0  0;
        .2 .5 0 .25 0;
        .125 10 0 0 0;
        0  0  0  0  0
       ];
A = {A11 A22};

known_value = {[
                0 2 1 1 0;
                1 0 2 2 0;
                1 1 0 1 0;
                1 1 2 0 0;
                0 0 0 0 0;
               ]
               [
                0 2 1 1 0;
                1 0 2 2 0;
                1 1 0 1 0;
                1 1 2 0 0;
                0 0 0 0 0;
               ]};

g = MultiplexWD('B', A);
edge_number_distance = EdgeNumberDistance('G', g).get('M');

assert(isequal(edge_number_distance, known_value), ...
    [BRAPH2.STR ':EdgeNumberDistance:' BRAPH2.BUG_ERR], ...
    'EdgeNumberDistance is not being calculated correctly for MultiplexGraphWD.')
