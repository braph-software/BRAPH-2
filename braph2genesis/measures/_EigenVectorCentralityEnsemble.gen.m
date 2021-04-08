%% ¡header!
EigenVectorCentralityEnsemble < EigenVectorCentrality (m, eigen vector centrality of a graph ensemble) is the eigen vector centrality of a graph ensemble.

%%% ¡description!
The eigen vector centrality of a node is the ith element in the eigenvector corresponding 
to the largest eigenvalue of the largest eigenvalue of the graphs adjacency matrix.

%%% ¡compatible_graphs!
GraphBDEnsemble
GraphWUEnsemble
MultigraphBUTEnsemble
MultigraphBUDEnsemble
MultiplexBDEnsemble
MultiplexWUEnsemble

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the ensemble-averaged eigen vector centrality.
%%%% ¡calculate!
ge = m.get('G'); % graph ensemble from measure class

edge_vector_centrality_ensemble = cell(ge.layernumber(), 1);

edge_vector_centrality_list = cellfun(@(x) x.getMeasure('EigenVectorCentrality').get('M'), ge.get('G_DICT').getItems, 'UniformOutput', false);
for li = 1:1:ge.layernumber()
    edge_vector_centrality_li_list = cellfun(@(x) x{li}, edge_vector_centrality_list, 'UniformOutput', false);
    edge_vector_centrality_ensemble{li} = mean(cat(3, edge_vector_centrality_li_list{:}), 3);
end

value = edge_vector_centrality_ensemble;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphWUEnsemble
%%%% ¡code!
B = [
    0   .5  .5  0
    .5  0   0   .5 
    .5  0   0   .5
    0   .5  .5  0
    ];

known_value = {[1/2 1/2 1/2 1/2]'};

ge = GraphWUEnsemble();
dict = ge.get('G_DICT');
for i = 1:1:10
    g = GraphWU( ...
        'ID', ['g ' int2str(i)], ...
        'B', B ...
        );
    dict.add(g)
end
ge.set('g_dict', dict);

m_outside_g = EigenVectorCentralityEnsemble('G', ge);
tol = 5 * eps(cell2mat(m_outside_g.get('M'))); % A very small value for comparing two floating-point numbers if they are close enough
assert(all(ismembertol(cell2mat(m_outside_g.get('M')), cell2mat(known_value), tol(1))), ...
    [BRAPH2.STR ':EigenVectorCentralityEnsemble:' BRAPH2.BUG_ERR], ...
    'EigenVectorCentralityEnsemble is not being calculated correctly for GraphWUEnsemble.')

m_inside_g = ge.getMeasure('EigenVectorCentralityEnsemble');
tol = 5 * eps(cell2mat(m_inside_g.get('M'))); % A very small value for comparing two floating-point numbers if they are close enough
assert(all(ismembertol(cell2mat(m_inside_g.get('M')), cell2mat(known_value), tol(1))), ...
    [BRAPH2.STR ':EigenVectorCentralityEnsemble:' BRAPH2.BUG_ERR], ...
    'EigenVectorCentralityEnsemble is not being calculated correctly for GraphWUEnsemble.')

%%% ¡test!
%%%% ¡name!
MultiplexBDEnsemble
B11 = [
    0 1 1 0
    1 0 0 1
    1 0 0 1
    0 1 1 0
      ];
B22 = [
    0 1 1 0
    1 0 0 1
    1 0 0 1
    0 1 1 0
      ];
B = {B11 B22};

known_value = {[
              [1/2 1/2 1/2 1/2]'
              [1/2 1/2 1/2 1/2]'
              ]};

ge = MultiplexBDEnsemble();
dict = ge.get('G_DICT');
for i = 1:1:10
    g = MultiplexBD( ...
        'ID', ['g ' int2str(i)], ...
        'B', B ...
        );
    dict.add(g)
end
ge.set('g_dict', dict);
m_outside_g = EigenVectorCentralityEnsemble('G', ge);
tol = 5 * eps(cell2mat(m_outside_g.get('M'))); % A very small value for comparing two floating-point numbers if they are close enough
assert(all(ismembertol(cell2mat(m_outside_g.get('M')), cell2mat(known_value), tol(1))), ...
    [BRAPH2.STR ':EigenVectorCentralityEnsemble:' BRAPH2.BUG_ERR], ...
    'EigenVectorCentralityEnsemble is not being calculated correctly for MultiplexBDEnsemble.')