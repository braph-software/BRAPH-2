%% ¡header!
PathLengthEnsemble < PathLength (m, pathlength of a graph ensemble) is the pathlength of a graph ensemble.

%%% ¡description!
The path length is the average shortest path length of one node to all
other nodes within a layer.

%%% ¡compatible_graphs!
GraphBUEnsemble
GraphWUEnsemble
MultigraphBUDEnsemble
MultigraphBUTEnsemble
MultiplexBUEnsemble
MultiplexWUEnsemble

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the ensemble-averaged pathlength.
%%%% ¡calculate!
ge = m.get('G'); % graph ensemble from measure class

pathlength_ensemble = cell(ge.layernumber(), 1);

pathlength_list = cellfun(@(x) x.getMeasure('PathLength').get('M'), ge.get('G_DICT').getItems, 'UniformOutput', false);
for li = 1:1:ge.layernumber()
    pathlength_li_list = cellfun(@(x) x{li}, pathlength_list, 'UniformOutput', false);
    pathlength_ensemble{li} = mean(cat(3, pathlength_li_list{:}), 3);
end

value = pathlength_ensemble;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBUEnsemble
%%%% ¡code!
B = [
    0   .1  0   0
    .2  0   .1  0
    0   .1  0   .2
    0   0   .1  0
    ];

known_pathlength = {[2 4/3 4/3 2]'};

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

m_outside_g = PathLengthEnsemble('G', ge);
assert(isequal(round(cell2mat(m_outside_g.get('M')), 5), round(cell2mat(known_pathlength), 5)), ...
    [BRAPH2.STR ':PathLengthEnsemble:' BRAPH2.BUG_ERR], ...
    'PathLengthEnsemble is not being calculated correctly for GraphBUEnsemble.')

m_inside_g = ge.getMeasure('PathLengthEnsemble');
assert(isequal(round(cell2mat(m_inside_g.get('M')), 5), round(cell2mat(known_pathlength), 5)), ...
    [BRAPH2.STR ':PathLengthEnsemble:' BRAPH2.BUG_ERR], ...
    'PathLengthEnsemble is not being calculated correctly for GraphBUEnsemble.')

%%% ¡test!
%%%% ¡name!
MultigraphBUTEnsemble
%%%% ¡code!
B = [
    0   .1  0   0
    .2  0   .1  0
    0   .1  0   .2
    0   0   .1  0
    ];

thresholds = [0 1];

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

known_pathlength = {
    [2    4/3  4/3  2]'
    [Inf  Inf  Inf  Inf]'
    };

m_outside_g = PathLengthEnsemble('G', ge);
assert(isequal(round(cell2mat(m_outside_g.get('M')), 5), round(cell2mat(known_pathlength), 5)), ...
    [BRAPH2.STR ':PathLengthEnsemble:' BRAPH2.BUG_ERR], ...
    'PathLengthEnsemble is not being calculated correctly for MultigraphBUTEnsemble.')

m_inside_g = ge.getMeasure('PathLengthEnsemble');
assert(isequal(round(cell2mat(m_inside_g.get('M')), 5), round(cell2mat(known_pathlength), 5)), ...
    [BRAPH2.STR ':PathLengthEnsemble:' BRAPH2.BUG_ERR], ...
    'PathLengthEnsemble is not being calculated correctly for MultigraphBUTEnsemble.')

%%% ¡test!
%%%% ¡name!
MultiplexBUEnsemble
A11 = [
    0   .1  0   0
    .2  0   .1  0
    0   .1  0   .2
    0   0   .1  0
    ];

A22 = [
    0   .1  0   0
    .2  0   .1  0
    0   .1  0   .2
    0   0   .1  0
    ];

B = {A11 A22};

known_pathlength = {
    [2 4/3 4/3 2]'
    [2 4/3 4/3 2]'
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
pathlength = PathLengthEnsemble('G', ge);

assert(isequal(round(cell2mat(pathlength.get('M')), 5), round(cell2mat(known_pathlength), 5)), ...
    [BRAPH2.STR ':PathLengthEnsemble:' BRAPH2.BUG_ERR], ...
    'PathLengthEnsemble is not being calculated correctly for MultiplexBUEnsemble.')