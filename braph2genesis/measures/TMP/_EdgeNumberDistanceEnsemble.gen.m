%% ¡header!
EdgeNumberDistanceEnsemble < EdgeNumberDistance (m, edge number distance of a graph ensemble) is the edge number distance of a graph ensemble.

%%% ¡description!
The edge distance number of a graph is the number of edges in the shortest
weighted path between two nodes within a layer.

%%% ¡compatible_graphs!
GraphWDEnsemble
GraphWUEnsemble
MultiplexWDEnsemble
MultiplexWUEnsemble

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the ensemble-averaged edge number distance.
%%%% ¡calculate!
ge = m.get('G'); % graph ensemble from measure class

edge_number_distance_ensemble = cell(ge.layernumber(), 1);

edge_number_distance_list = cellfun(@(x) x.getMeasure('EdgeNumberDistance').get('M'), ge.get('G_DICT').getItems, 'UniformOutput', false);
for li = 1:1:ge.layernumber()
    edge_number_distance_centrality_li_list = cellfun(@(x) x{li}, edge_number_distance_list, 'UniformOutput', false);
    edge_number_distance_ensemble{li} = mean(cat(3, edge_number_distance_centrality_li_list{:}), 3);
end

value = edge_number_distance_ensemble;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphWUEnsemble
%%%% ¡code!
B = [
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

m_outside_g = EdgeNumberDistanceEnsemble('G', ge);
assert(isequal(m_outside_g.get('M'), known_value), ...
    [BRAPH2.STR ':EdgeNumberDistanceEnsemble:' BRAPH2.BUG_ERR], ...
    'EdgeNumberDistanceEnsemble is not being calculated correctly for GraphWUEnsemble.')

m_inside_g = ge.getMeasure('EdgeNumberDistanceEnsemble');
assert(isequal(m_inside_g.get('M'), known_value), ...
    [BRAPH2.STR ':EdgeNumberDistanceEnsemble:' BRAPH2.BUG_ERR], ...
    'EdgeNumberDistanceEnsemble is not being calculated correctly for GraphWUEnsemble.')

%%% ¡test!
%%%% ¡name!
MultiplexWDEnsemble
B11 = [
      0 .1 .2 .25 0;
      .125 0 0 0  0;
      .2 .5 0 .25 0;
      .125 10 0 0 0;
      0  0  0  0  0
      ];
B22 = [
      0 .1 .2 .25 0;
      .125 0 0 0  0;
      .2 .5 0 .25 0;
      .125 10 0 0 0;
      0  0  0  0  0
      ];
B = {B11 B22};

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
distance = EdgeNumberDistanceEnsemble('G', ge);

assert(isequal(distance.get('M'), known_value), ...
    [BRAPH2.STR ':EdgeNumberDistanceEnsemble:' BRAPH2.BUG_ERR], ...
    'EdgeNumberDistanceEnsemble is not being calculated correctly for MultiplexWDEnsemble.')