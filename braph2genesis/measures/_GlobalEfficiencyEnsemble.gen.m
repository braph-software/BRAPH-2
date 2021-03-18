%% ¡header!
GlobalEfficiencyEnsemble < GlobalEfficiency (m, average global efficiency of a graph ensemble) is the average global efficiency of a graph ensemble.

%%% ¡description!
The global efficiency is the average inverse shortest path length within each layer.

%%% ¡compatible_graphs!
GraphWUEnsemble
GraphBUEnsemble
MultigraphBUTEnsemble
MultigraphBUDEnsemble
MultiplexBUEnsemble
MultiplexWUEnsemble

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the ensemble-averaged global efficiency is the average inverse shortest path length within each layer.
I.
%%%% ¡calculate!
ge = m.get('G'); % graph ensemble from measure class

global_efficiency_ensemble = cell(ge.layernumber(), 1);
global_efficiency_list = cellfun(@(x) x.getMeasure('GlobalEfficiency').get('M'), ge.get('G_DICT').getItems, 'UniformOutput', false);
for li = 1:1:ge.layernumber()
    global_efficiency_li_list = cellfun(@(x) x{li}, global_efficiency_list, 'UniformOutput', false);
    global_efficiency_ensemble{li} = mean(cat(3, global_efficiency_li_list{:}), 3);
end

value = global_efficiency_ensemble;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBUEnsemble
%%%% ¡code!
B = [
    0   .1  0   0   0
    .2  0   0   0   0
    0   0   0   .2  0
    0   0   .1  0   0
    0   0   0   0   0
    ];

known_global_efficiency = {[1/4 1/4 1/4 1/4 0]'};

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

m_outside_g = GlobalEfficiencyEnsemble('G', ge);
assert(isequal(m_outside_g.get('M'), known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiencyEnsemble:' BRAPH2.BUG_ERR], ...
    'GlobalEfficiencyEnsemble is not being calculated correctly for GraphBUEnsemble.')

m_inside_g = ge.getMeasure('GlobalEfficiencyEnsemble');
assert(isequal(m_inside_g.get('M'), known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiencyEnsemble:' BRAPH2.BUG_ERR], ...
    'GlobalEfficiencyEnsemble is not being calculated correctly for GraphBUEnsemble.')


%%% ¡test!
%%%% ¡name!
MultigraphBUTEnsemble
%%%% ¡code!
B = [
    0   .1  0   0   0
    .2  0   0   0   0
    0   0   0   .2  0
    0   0   .1  0   0
    0   0   0   0   0
    ];

thresholds = [0 1];
known_global_efficiency = {
    [1/4 1/4 1/4 1/4 0]'
    [0 0 0 0 0]'
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


m_outside_g = GlobalEfficiencyEnsemble('G', ge);
assert(isequal(m_outside_g.get('M'), known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiencyEnsemble:' BRAPH2.BUG_ERR], ...
    'GlobalEfficiencyEnsemble is not being calculated correctly for MultigraphBUTEnsemble.')

m_inside_g = ge.getMeasure('GlobalEfficiencyEnsemble');
assert(isequal(m_inside_g.get('M'), known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiencyEnsemble:' BRAPH2.BUG_ERR], ...
    'GlobalEfficiencyEnsemble is not being calculated correctly for MultigraphBUTEnsemble.')


%%% ¡test!
%%%% ¡name!
MultiplexBUEnsemble
%%%% ¡code!
B11 = [
      0   .1  0   0   0
      .2  0   0   0   0
      0   0   0   .2  0
      0   0   .1  0   0
      0   0   0   0   0
      ];
B22 = [
      0   .1  0   0   0
      .2  0   0   0   0
      0   0   0   .2  0
      0   0   .1  0   0
      0   0   0   0   0
      ];
B = {
    B11 B22
    };

known_global_efficiency = {
    [1/4 1/4 1/4 1/4 0]'
    [1/4 1/4 1/4 1/4 0]'
    };

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

m_outside_g = GlobalEfficiencyEnsemble('G', ge);
assert(isequal(m_outside_g.get('M'), known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiencyEnsemble:' BRAPH2.BUG_ERR], ...
    'GlobalEfficiencyEnsemble is not being calculated correctly for MultiplexBUEnsemble.')

m_inside_g = ge.getMeasure('GlobalEfficiencyEnsemble');
assert(isequal(m_inside_g.get('M'), known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiencyEnsemble:' BRAPH2.BUG_ERR], ...
    'GlobalEfficiencyEnsemble is not being calculated correctly for MultiplexBUEnsemble.')
