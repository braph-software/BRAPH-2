%% ¡header!
InDegreeEnsemble < InDegree (m, in-degree of a graph ensemble) is the in-degree of a graph ensemble.

%%% ¡description!
The in-degree of a node is the number of inward edges connected to a node within a layer.
Connection weights are ignored in calculations.

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

in_degree_ensemble = cell(ge.layernumber(), 1);

in_degree_list = cellfun(@(x) x.getMeasure('InDegree').get('M'), ge.get('G_DICT').getItems, 'UniformOutput', false);
for li = 1:1:ge.layernumber()
    degree_li_list = cellfun(@(x) x{li}, in_degree_list, 'UniformOutput', false);
    in_degree_ensemble{li} = mean(cat(3, degree_li_list{:}), 3);
end

value = in_degree_ensemble;

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

known_in_degree = {[1 1 1]'};

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

m_outside_g = InDegreeEnsemble('G', ge);
assert(isequal(m_outside_g.get('M'), known_in_degree), ...
    [BRAPH2.STR ':InDegreeEnsemble:' BRAPH2.BUG_ERR], ...
    'InDegreeEnsemble is not being calculated correctly for GraphBDEnsemble.')

m_inside_g = ge.getMeasure('InDegreeEnsemble');
assert(isequal(m_inside_g.get('M'), known_in_degree), ...
    [BRAPH2.STR ':InDegreeEnsemble:' BRAPH2.BUG_ERR], ...
    'InDegreeEnsemble is not being calculated correctly for GraphBDEnsemble.')

%%% ¡test!
%%%% ¡name!
GraphWDEnsemble
%%%% ¡code!
B = [
    0   .2  1
    0   0   .8
    1   0   0
    ];

known_in_degree = {[1 1 2]'};

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

m_outside_g = InDegreeEnsemble('G', ge);
assert(isequal(m_outside_g.get('M'), known_in_degree), ...
    [BRAPH2.STR ':InDegreeEnsemble:' BRAPH2.BUG_ERR], ...
    'InDegreeEnsemble is not being calculated correctly for GraphWDEnsemble.')

m_inside_g = ge.getMeasure('InDegreeEnsemble');
assert(isequal(m_inside_g.get('M'), known_in_degree), ...
    [BRAPH2.STR ':InDegreeEnsemble:' BRAPH2.BUG_ERR], ...
    'InDegreeEnsemble is not being calculated correctly for GraphWDEnsemble.')

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

known_in_degree = {
    [1 1 1]'
    [2 2 1]'
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
in_degree_ensemble = InDegreeEnsemble('G', ge);

assert(isequal(in_degree_ensemble.get('M'), known_in_degree), ...
    [BRAPH2.STR ':InDegreeEnsemble:' BRAPH2.BUG_ERR], ...
    'InDegreeEnsemble is not being calculated correctly for MultiplexBDEnsemble.')

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

known_in_degree = {
                  [1 1 2]'
                  [1 2 2]'
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
in_degree_ensemble = InDegreeEnsemble('G', ge);

assert(isequal(in_degree_ensemble.get('M'), known_in_degree), ...
    [BRAPH2.STR ':InDegreeEnsemble:' BRAPH2.BUG_ERR], ...
    'InDegreeEnsemble is not being calculated correctly for MultiplexWDEnsemble.')