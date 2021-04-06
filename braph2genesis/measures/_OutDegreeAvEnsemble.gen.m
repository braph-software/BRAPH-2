%% ¡header!
OutDegreeAvEnsemble < OutDegreeAv (m, average out-degree of a graph ensemble) is the graph average out-degree of a graph ensemble.

%%% ¡description!
The average out-degree of a graph is the average of all number of outward 
edges connected to a node within a layer. 

%%% ¡compatible_graphs!
GraphWDEnsemble
GraphBDEnsemble
MultiplexWDEnsemble
MultiplexBDEnsemble

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the ensemble-averaged out-degree.
%%%% ¡calculate!
ge = m.get('G'); % graph ensemble from measure class

out_degree_av_ensemble = cell(ge.layernumber(), 1);

out_degree_av_list = cellfun(@(x) x.getMeasure('OutDegreeAv').get('M'), ge.get('G_DICT').getItems, 'UniformOutput', false);
for li = 1:1:ge.layernumber()
    degree_av_li_list = cellfun(@(x) x{li}, out_degree_av_list, 'UniformOutput', false);
    out_degree_av_ensemble{li} = mean(cat(3, degree_av_li_list{:}), 3);
end

value = out_degree_av_ensemble;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBDEnsemble
%%%% ¡code!
B = [
    0   1   1
    0   0   0
    1   0   0
    ];

known_out_degree_av = {mean([2 0 1])};

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

m_outside_g = OutDegreeAvEnsemble('G', ge);
assert(isequal(m_outside_g.get('M'), known_out_degree_av), ...
    [BRAPH2.STR ':OutDegreeAvEnsemble:' BRAPH2.BUG_ERR], ...
    'OutDegreeAvEnsemble is not being calculated correctly for GraphBDEnsemble.')

m_inside_g = ge.getMeasure('OutDegreeAvEnsemble');
assert(isequal(m_inside_g.get('M'), known_out_degree_av), ...
    [BRAPH2.STR ':OutDegreeAvEnsemble:' BRAPH2.BUG_ERR], ...
    'OutDegreeAvEnsemble is not being calculated correctly for GraphBDEnsemble.')

%%% ¡test!
%%%% ¡name!
GraphWDEnsemble
%%%% ¡code!
B = [
    0   .2  1
    0   0   .8
    1   0   0
    ];

known_out_degree_av = {mean([2 1 1])};

ge = GraphWDEnsemble();
dict = ge.get('G_DICT');
for i = 1:1:10
    g = GraphWD( ...
        'ID', ['g ' int2str(i)], ...
        'B', B ...
        );
    dict.add(g)
end
ge.set('g_dict', dict);

m_outside_g = OutDegreeAvEnsemble('G', ge);
assert(isequal(round(cell2mat(m_outside_g.get('M')), 5), round(cell2mat(known_out_degree_av), 5)), ...
    [BRAPH2.STR ':OutDegreeAvEnsemble:' BRAPH2.BUG_ERR], ...
    'OutDegreeAvEnsemble is not being calculated correctly for GraphWDEnsemble.')

m_inside_g = ge.getMeasure('OutDegreeAvEnsemble');
assert(isequal(round(cell2mat(m_inside_g.get('M')), 5), round(cell2mat(known_out_degree_av), 5)), ...
    [BRAPH2.STR ':OutDegreeAvEnsemble:' BRAPH2.BUG_ERR], ...
    'OutDegreeAvEnsemble is not being calculated correctly for GraphWDEnsemble.')

%%% ¡test!
%%%% ¡name!
MultiplexBDEnsemble
%%%% ¡code!
B11 = [
      0  1  1
      0  0  0
      1  0  0
      ];
B22 = [
       0  1  0
       1  0  1
       1  1  0
       ];
B = {B11 B22};

known_out_degree_av = { 
                   mean([2 0 1])
                   mean([1 2 2])
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
out_degree_av_ensemble = OutDegreeAvEnsemble('G', ge);

assert(isequal(round(cell2mat(out_degree_av_ensemble.get('M')), 5), round(cell2mat(known_out_degree_av), 5)), ...
    [BRAPH2.STR ':OutDegreeAvEnsemble:' BRAPH2.BUG_ERR], ...
    'OutDegreeAvEnsemble is not being calculated correctly for MultiplexBDEnsemble.')

%%% ¡test!
%%%% ¡name!
MultiplexWDEnsemble
%%%% ¡code!
B11 = [
      0   .2  1
      0   0   .8
      1   0   0
      ];
B22 = [
      0  1   .6
      1  0   .4
      0  .4  0
      ];
B = {B11 B22};

known_out_degree_av = {
                  mean([2 1 1])
                  mean([2 2 1])
                  };

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
out_degree_av_ensemble = OutDegreeAvEnsemble('G', ge);

assert(isequal(round(cell2mat(out_degree_av_ensemble.get('M')), 5), round(cell2mat(known_out_degree_av), 5)), ...
    [BRAPH2.STR ':OutDegreeAvEnsemble:' BRAPH2.BUG_ERR], ...
    'OutDegreeAvEnsemble is not being calculated correctly for MultiplexWDEnsemble.')