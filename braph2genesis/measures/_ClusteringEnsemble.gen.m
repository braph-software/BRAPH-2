%% ¡header!
ClusteringEnsemble < Clustering (m, clustering of a graph ensemble) is the clustering of a graph ensemble.

%%% ¡description!
The clustering coefficient of a node is the fraction of triangles present
around a node. The clustering coefficient is calculated as the ratio between
the number of triangles present around a node and the maximum number of 
triangles that could possibly be formed around that node.

%%% ¡compatible_graphs!
GraphBUEnsemble
GraphWUEnsemble
GraphBDEnsemble
GraphWDEnsemble
MultigraphBUDEnsemble
MultigraphBUTEnsemble
MultiplexBUEnsemble
MultiplexWUEnsemble
MultiplexBDEnsemble
MultiplexWDEnsemble

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the ensemble-averaged clustering.
%%%% ¡calculate!
ge = m.get('G'); % graph ensemble from measure class

clustering_ensemble = cell(ge.layernumber(), 1);
directed_triangles_rule = m.get('rule');
clustering_list = cellfun(@(x) x.getMeasure('Clustering', 'rule', directed_triangles_rule).get('M'), ge.get('G_DICT').getItems, 'UniformOutput', false);
for li = 1:1:ge.layernumber()
    clustering_li_list = cellfun(@(x) x{li}, clustering_list, 'UniformOutput', false);
    clustering_ensemble{li} = mean(cat(3, clustering_li_list{:}), 3);
end

value = clustering_ensemble;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBUEnsemble
%%%% ¡code!
B = [
    0 1 1 1;
    1 0 1 0;
    1 1 0 1;
    1 0 1 0;
    ];

known_clustering = {[2/3 1 2/3 1]'};

ge = GraphBUEnsemble();
dict = ge.get('G_DICT');
for i = 1:1:10
    g = GraphBU( ...
        'ID', ['g ' int2str(i)], ...
        'B', B ...
        );
    dict.add(g)
end
ge.set('g_dict', dict);

m_outside_g = ClusteringEnsemble('G', ge);
assert(isequal(round(cell2mat(m_outside_g.get('M')), 5), round(cell2mat(known_clustering), 5)), ...
    [BRAPH2.STR ':ClusteringEnsemble:' BRAPH2.BUG_ERR], ...
    'ClusteringEnsemble is not being calculated correctly for GraphBUEnsemble.')

m_inside_g = ge.getMeasure('ClusteringEnsemble');
assert(isequal(round(cell2mat(m_inside_g.get('M')), 5), round(cell2mat(known_clustering), 5)), ...
    [BRAPH2.STR ':ClusteringEnsemble:' BRAPH2.BUG_ERR], ...
    'ClusteringEnsemble is not being calculated correctly for GraphBUEnsemble.')

%%% ¡test!
%%%% ¡name!
GraphBDEnsemble
%%%% ¡code!
B = [
    0 0 1;
    1 0 0;
    0 1 0 ;
    ];

known_clustering = {[0 0 0]'};

ge = GraphBDEnsemble();
dict = ge.get('G_DICT');
for i = 1:1:10
    g = GraphBD( ...
        'ID', ['g ' int2str(i)], ...
        'B', B ...
        );
    dict.add(g)
end
ge.set('g_dict', dict);

m_outside_g = ClusteringEnsemble('G', ge, 'rule', 'out');
assert(isequal(m_outside_g.get('M'), known_clustering), ...
    [BRAPH2.STR ':ClusteringEnsemble:' BRAPH2.BUG_ERR], ...
    'ClusteringEnsemble is not being calculated correctly for GraphBDEnsemble.')

m_inside_g = ge.getMeasure('ClusteringEnsemble');
assert(isequal(m_inside_g.get('M'), known_clustering), ...
    [BRAPH2.STR ':ClusteringEnsemble:' BRAPH2.BUG_ERR], ...
    'ClusteringEnsemble is not being calculated correctly for GraphBDEnsemble.')

%%% ¡test!
%%%% ¡name!
MultigraphBUTEnsemble
%%%% ¡code!
B = [
    0 1 1 1;
    1 0 1 0;
    1 1 0 1;
    1 0 1 0;
    ];

known_clustering = {
    [2/3 1 2/3 1]'
    [0   0 0   0]'
    };

ge = MultigraphBUTEnsemble('THRESHOLDS', thresholds);
dict = ge.get('G_DICT');
for i = 1:1:10
    g = MultigraphBUT( ...
        'ID', ['g ' int2str(i)], ...
        'THRESHOLDS', ge.get('THRESHOLDS'), ...
        'B', B ...
        );
    dict.add(g)
end
ge.set('g_dict', dict);


m_outside_g = ClusteringEnsemble('G', ge);
assert(isequal(round(cell2mat(m_outside_g.get('M')), 5), round(cell2mat(known_clustering), 5)), ...
    [BRAPH2.STR ':ClusteringEnsemble:' BRAPH2.BUG_ERR], ...
    'ClusteringEnsemble is not being calculated correctly for MultigraphBUTEnsemble.')

m_inside_g = ge.getMeasure('ClusteringEnsemble');
assert(isequal(round(cell2mat(m_inside_g.get('M')), 5), round(cell2mat(known_clustering), 5)), ...
    [BRAPH2.STR ':ClusteringEnsemble:' BRAPH2.BUG_ERR], ...
    'ClusteringEnsemble is not being calculated correctly for MultigraphBUTEnsemble.')


%%% ¡test!
%%%% ¡name!
MultiplexBDEnsemble
B11 = [
      0 0 1; 
      1 0 0; 
      0 1 0 
      ];
B22 = [
      0 0 1; 
      1 0 0; 
      0 1 0 
      ];

B = {B11 B22};

known_clustering = {
    [1 1 1]'
    [1 1 1]'
    };

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
clustering = ClusteringEnsemble('G', ge);

assert(isequal(clustering.get('M'), known_clustering), ...
    [BRAPH2.STR ':ClusteringEnsemble:' BRAPH2.BUG_ERR], ...
    'ClusteringEnsemble is not being calculated correctly for MultiplexBDEnsemble.')