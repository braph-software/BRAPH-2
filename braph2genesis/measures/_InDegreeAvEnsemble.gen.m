%% ¡header!
InDegreeAvEnsemble < InDegreeAv (m, average in-degree of a graph ensemble) is the graph average in-degree of a graph ensemble.

%%% ¡description!
The average in-degree of a graph is the average of all number of inward 
edges connected to a node within a layer. 

%%% ¡compatible_graphs!
GraphWDEnsemble
GraphBDEnsemble
MultiplexWDEnsemble
MultiplexBDEnsemble

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the ensemble-averaged in-degree.
%%%% ¡calculate!
ge = m.get('G'); % graph ensemble from measure class

in_degree_av_ensemble = cell(ge.layernumber(), 1);

in_degree_av_list = cellfun(@(x) x.getMeasure('InDegreeAv').get('M'), ge.get('G_DICT').getItems, 'UniformOutput', false);
for li = 1:1:ge.layernumber()
    degree_av_li_list = cellfun(@(x) x{li}, in_degree_av_list, 'UniformOutput', false);
    in_degree_av_ensemble{li} = mean(cat(3, degree_av_li_list{:}), 3);
end

value = in_degree_av_ensemble;

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

known_in_degree_av = {mean([1 1 1])};

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

m_outside_g = InDegreeAvEnsemble('G', ge);
assert(isequal(m_outside_g.get('M'), known_in_degree_av), ...
    [BRAPH2.STR ':InDegreeAvEnsemble:' BRAPH2.BUG_ERR], ...
    'InDegreeAvEnsemble is not being calculated correctly for GraphBDEnsemble.')

m_inside_g = ge.getMeasure('InDegreeAvEnsemble');
assert(isequal(m_inside_g.get('M'), known_in_degree_av), ...
    [BRAPH2.STR ':InDegreeAvEnsemble:' BRAPH2.BUG_ERR], ...
    'InDegreeAvEnsemble is not being calculated correctly for GraphBDEnsemble.')

%%% ¡test!
%%%% ¡name!
GraphWDEnsemble
%%%% ¡code!
B = [
    0   .2  1
    0   0   .8
    1   0   0
    ];

known_in_degree_av = {mean([1 1 2])};

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

m_outside_g = InDegreeAvEnsemble('G', ge);
assert(isequal(round(cell2mat(m_outside_g.get('M')), 5), round(cell2mat(known_in_degree_av), 5)), ...
    [BRAPH2.STR ':InDegreeAvEnsemble:' BRAPH2.BUG_ERR], ...
    'InDegreeAvEnsemble is not being calculated correctly for GraphWDEnsemble.')

m_inside_g = ge.getMeasure('InDegreeAvEnsemble');
assert(isequal(round(cell2mat(m_inside_g.get('M')), 5), round(cell2mat(known_in_degree_av), 5)), ...
    [BRAPH2.STR ':InDegreeAvEnsemble:' BRAPH2.BUG_ERR], ...
    'InDegreeAvEnsemble is not being calculated correctly for GraphWDEnsemble.')

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

known_in_degree_av = {
    mean([1 1 1])
    mean([2 2 1])
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
in_degree_av_ensemble = InDegreeAvEnsemble('G', ge);

assert(isequal(round(cell2mat(in_degree_av_ensemble.get('M')), 5), round(cell2mat(known_in_degree_av), 5)), ...
    [BRAPH2.STR ':InDegreeAvEnsemble:' BRAPH2.BUG_ERR], ...
    'InDegreeAvEnsemble is not being calculated correctly for MultiplexBDEnsemble.')

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

known_in_degree_av = {
                  mean([1 1 2])
                  mean([1 2 2])
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
in_degree_av_ensemble = InDegreeAvEnsemble('G', ge);

assert(isequal(round(cell2mat(in_degree_av_ensemble.get('M')), 5), round(cell2mat(known_in_degree_av), 5)), ...
    [BRAPH2.STR ':InDegreeAvEnsemble:' BRAPH2.BUG_ERR], ...
    'InDegreeAvEnsemble is not being calculated correctly for MultiplexWDEnsemble.')