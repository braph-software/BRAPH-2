%% ¡header!
EdgeBetweennessCentralityEnsemble < EdgeBetweennessCentrality (m, edge betweenness centrality of a graph ensemble) is the edge betweenness centrality of a graph ensemble.

%%% ¡description!
The edge betweenness centrality of a graph is the fraction of all shortest paths in the 
graph that pass through a given edge within a layer. Edges with high values 
of betweenness centrality participate in a large number of shortest paths.

%%% ¡compatible_graphs!
GraphBDEnsemble
GraphBUEnsemble
GraphWDEnsemble
GraphWUEnsemble
MultigraphBUTEnsemble
MultigraphBUDEnsemble
MultiplexBDEnsemble
MultiplexBUEnsemble
MultiplexWDEnsemble
MultiplexWUEnsemble

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the ensemble-averaged edge betweenness centrality.
%%%% ¡calculate!
ge = m.get('G'); % graph ensemble from measure class

edge_betweenness_centrality_ensemble = cell(ge.layernumber(), 1);

edge_betweenness_centrality_list = cellfun(@(x) x.getMeasure('EdgeBetweennessCentrality').get('M'), ge.get('G_DICT').getItems, 'UniformOutput', false);
for li = 1:1:ge.layernumber()
    edge_betweenness_centrality_li_list = cellfun(@(x) x{li}, edge_betweenness_centrality_list, 'UniformOutput', false);
    edge_betweenness_centrality_ensemble{li} = mean(cat(3, edge_betweenness_centrality_li_list{:}), 3);
end

value = edge_betweenness_centrality_ensemble;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBUEnsemble
%%%% ¡code!
B = [
    0 1 1; 
    1 0 0; 
    1 0 0
    ];

known_edge_betweenness_centrality = {[
                                    0 2 2;
                                    2 0 0;
                                    2 0 0
                                    ]};

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

m_outside_g = EdgeBetweennessCentralityEnsemble('G', ge);
assert(isequal(m_outside_g.get('M'), known_edge_betweenness_centrality), ...
    [BRAPH2.STR ':EdgeBetweennessCentralityEnsemble:' BRAPH2.BUG_ERR], ...
    'EdgeBetweennessCentralityEnsemble is not being calculated correctly for GraphBUEnsemble.')

m_inside_g = ge.getMeasure('EdgeBetweennessCentralityEnsemble');
assert(isequal(m_inside_g.get('M'), known_edge_betweenness_centrality), ...
    [BRAPH2.STR ':EdgeBetweennessCentralityEnsemble:' BRAPH2.BUG_ERR], ...
    'EdgeBetweennessCentralityEnsemble is not being calculated correctly for GraphBUEnsemble.')

%%% ¡test!
%%%% ¡name!
MultigraphBUTEnsemble
%%%% ¡code!
B = [
    0 1 1; 
    1 0 0; 
    1 0 0
    ];

thresholds = [0 1];

known_edge_betweenness_centrality = {
                                [
                                0 2 2;
                                2 0 0;
                                2 0 0
                                ]
                                [
                                0 0 0;
                                0 0 0;
                                0 0 0
                                ]};

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

m_outside_g = EdgeBetweennessCentralityEnsemble('G', ge);
assert(isequal(m_outside_g.get('M'), known_edge_betweenness_centrality), ...
    [BRAPH2.STR ':EdgeBetweennessCentralityEnsemble:' BRAPH2.BUG_ERR], ...
    'EdgeBetweennessCentralityEnsemble is not being calculated correctly for MultigraphBUTEnsemble.')

m_inside_g = ge.getMeasure('EdgeBetweennessCentralityEnsemble');
assert(isequal(m_inside_g.get('M'), known_edge_betweenness_centrality), ...
    [BRAPH2.STR ':EdgeBetweennessCentralityEnsemble:' BRAPH2.BUG_ERR], ...
    'EdgeBetweennessCentralityEnsemble is not being calculated correctly for MultigraphBUTEnsemble.')


%%% ¡test!
%%%% ¡name!
MultiplexBUEnsemble
B11 = [
      0   1   1
      1   0   0
      1   0   0
      ];
B22 = [
      0   1   0
      1   0   1
      0   1   0
      ];
B = {B11 B22};

known_edge_betweenness_centrality = {[
                                    0 2 2;
                                    2 0 0;
                                    2 0 0
                                    ]
                                    [
                                    0 2 0;
                                    2 0 2;
                                    0 2 0
                                    ]};

ge = MultiplexBUEnsemble();
dict = ge.get('G_DICT');
for i = 1:1:10
    g = MultiplexBU( ...
        'ID', ['g ' int2str(i)], ...
        'B', B ...
        );
    dict.add(g)
end
ge.set('g_dict', dict);
distance = EdgeBetweennessCentralityEnsemble('G', ge);

assert(isequal(distance.get('M'), known_edge_betweenness_centrality), ...
    [BRAPH2.STR ':EdgeBetweennessCentralityEnsemble:' BRAPH2.BUG_ERR], ...
    'EdgeBetweennessCentralityEnsemble is not being calculated correctly for MultiplexBUEnsemble.')


%%% ¡test!
%%%% ¡name!
MultiplexWDEnsemble
B11 = [
      0   1   0
      1   0   0
      4   0   0
      ];
B22 = [
      0   1   0
      1   0   0
      0   4   0
      ];
B = {B11 B22};

known_edge_betweenness_centrality = {[
                                    0 2 0;
                                    1 0 0;
                                    2 0 0
                                    ]
                                    [
                                    0 1 0;
                                    2 0 0;
                                    0 2 0
                                    ]};

ge = MultiplexWDEnsemble();
dict = ge.get('G_DICT');
for i = 1:1:10
    g = MultiplexWD( ...
        'ID', ['g ' int2str(i)], ...
        'B', B ...
        );
    dict.add(g)
end
ge.set('g_dict', dict);
distance = EdgeBetweennessCentralityEnsemble('G', ge);

assert(isequal(distance.get('M'), known_edge_betweenness_centrality), ...
    [BRAPH2.STR ':EdgeBetweennessCentralityEnsemble:' BRAPH2.BUG_ERR], ...
    'EdgeBetweennessCentralityEnsemble is not being calculated correctly for MultiplexWDEnsemble.')