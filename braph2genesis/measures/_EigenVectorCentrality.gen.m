%% ¡header!
EigenVectorCentrality < Measure (m, eigen vector centrality) is the eigen vector centrality.

%%% ¡description!
The eigen vector centrality of a node is the ith element in the eigenvector corresponding 
to the largest eigenvalue of the largest eigenvalue of the graphs adjacency matrix.

%%% ¡shape!
shape = Measure.NODAL;

%%% ¡scope!
scope = Measure.UNILAYER;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
GraphBD
GraphWU
MultiplexBU
MultiplexWU

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the eigen vector centrality.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
N = g.nodenumber(); 
eigenvector_centrality = cell(g.layernumber(), 1);

for li = 1:1:g.layernumber()    
    Aii = A{li, li};   
    
    if N(li) < 1000
        [V, D] = eig(Aii);
    else
        [V, D] = eigs(sparse(Aii));
    end
    
    [~, idx] = max(diag(D));
    ec = abs(V(:, idx));
    eigenvector_centrality(li) = {reshape(ec, length(ec), 1)};
end
value = eigenvector_centrality; 

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBU
%%%% ¡code!
A = [
    0 1 1 0 
    1 0 0 1 
    1 0 0 1
    0 1 1 0
    ];

known_eigenvector_centrality = {[1/2 1/2 1/2 1/2]'};

g = GraphBU('B', A);
eigenvector_centrality = EigenvectorCentrality('G', g).get('M');

assert(isequal(round(cell2mat(eigenvector_centrality), 6), round(cell2mat(known_eigenvector_centrality), 6)), ...
    [BRAPH2.STR ':EigenvectorCentrality:' BRAPH2.BUG_ERR], ...
    'EigenvectorCentrality is not being calculated correctly for GraphBU.')

%%% ¡test!
%%%% ¡name!
GraphWU
%%%% ¡code!
A = [
    0   .5  .5  0
    .5  0   0   .5 
    .5  0   0   .5
    0   .5  .5  0
    ];

known_eigenvector_centrality = {[1/2 1/2 1/2 1/2]'};

g = GraphWU('B', A);
eigenvector_centrality = EigenvectorCentrality('G', g).get('M');

assert(isequal(round(cell2mat(eigenvector_centrality), 6), round(cell2mat(known_eigenvector_centrality), 6)), ...
    [BRAPH2.STR ':EigenvectorCentrality:' BRAPH2.BUG_ERR], ...
    'EigenvectorCentrality is not being calculated correctly for GraphWU.')

%%% ¡test!
%%%% ¡name!
MultiplexBU
%%%% ¡code!
A11 = [
    0 1 1 0
    1 0 0 1
    1 0 0 1
    0 1 1 0
    ];

A22 = [
    0 1 1 0
    1 0 0 1
    1 0 0 1
    0 1 1 0
    ];
A = {A11 A22};

known_eigenvector_centrality = {
    [1/2 1/2 1/2 1/2]'
    [1/2 1/2 1/2 1/2]'
    };

g = MultiplexBU('B', A);
eigenvector_centrality = EigenvectorCentrality('G', g).get('M');

assert(isequal(round(cell2mat(eigenvector_centrality), 6), round(cell2mat(known_eigenvector_centrality), 6)), ...
    [BRAPH2.STR ':EigenvectorCentrality:' BRAPH2.BUG_ERR], ...
    'EigenvectorCentrality is not being calculated correctly for MultiplexBU.')