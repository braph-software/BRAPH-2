%% ¡header!
DegreeAvEnsemble < DegreeAv (m, average degree of a graph ensemble) is the graph average degree of a graph ensemble.

%%% ¡description!
The average degree of a graph is the average of all number of edges 
connected to a node within a layer. 
Connection weights are ignored in calculations.

%%% ¡compatible_graphs!
GraphWUEnsemble
MultigraphBUTEnsemble
MultigraphBUDEnsemble
MultiplexGraphBUEnsemble
MultiplexGraphWUEnsemble

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the ensemble-averaged degree.
%%%% ¡calculate!
ge = m.get('G'); % graph ensemble from measure class

degree_av_ensemble = cell(ge.layernumber(), 1);

degree_av_list = cellfun(@(x) x.getMeasure('DegreeAv').get('M'), ge.get('G_DICT').getItems, 'UniformOutput', false);
for li = 1:1:ge.layernumber()
    degree_av_li_list = cellfun(@(x) x{li}, degree_av_list, 'UniformOutput', false);
    degree_av_ensemble{li} = mean(cat(3, degree_av_li_list{:}), 3);
end

value = degree_av_ensemble;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphWUEnsemble
%%%% ¡code!
B = [
    0   1   1
    1   0   1
    1   1   0
    ];

known_degree_av = {mean([2 2 2])};

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

m_outside_g = DegreeAvEnsemble('G', ge);
assert(isequal(m_outside_g.get('M'), known_degree_av), ...
    [BRAPH2.STR ':DegreeAvEnsemble:' BRAPH2.BUG_ERR], ...
    'DegreeAvEnsemble is not being calculated correctly for GraphWUEnsemble.')

m_inside_g = ge.getMeasure('DegreeAvEnsemble');
assert(isequal(m_inside_g.get('M'), known_degree_av), ...
    [BRAPH2.STR ':DegreeAvEnsemble:' BRAPH2.BUG_ERR], ...
    'DegreeAvEnsemble is not being calculated correctly for GraphWUEnsemble.')

%%% ¡test!
%%%% ¡name!
MultigraphBUTEnsemble
%%%% ¡code!
B = [
     0  .2  .7   0
    .2   0   0  .3
    .7   0   0   0 
     0  .3   0   0
    ];

thresholds = [0 .5 1];

known_degree_av = { ...
    mean([2 2 1 1])
    mean([1 0 1 0])
    mean([0 0 0 0])
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

m_outside_g = DegreeAvEnsemble('G', ge);
assert(isequal(m_outside_g.get('M'), known_degree_av), ...
    [BRAPH2.STR ':DegreeAvEnsemble:' BRAPH2.BUG_ERR], ...
    'DegreeAvEnsemble is not being calculated correctly for MultigraphBUTEnsemble.')

m_inside_g = ge.getMeasure('DegreeAvEnsemble');
assert(isequal(m_inside_g.get('M'), known_degree_av), ...
    [BRAPH2.STR ':DegreeAvEnsemble:' BRAPH2.BUG_ERR], ...
    'DegreeAvEnsemble is not being calculated correctly for MultigraphBUTEnsemble.')

%%% ¡test!
%%%% ¡name!
MultigraphBUDEnsemble
%%%% ¡code!
B = [
     0  .2  .7   0
    .2   0   0  .3
    .7   0   0   0 
     0  .3   0   0
    ];

densities = [0 33 67 100];

known_degree_av = { ...
    mean([0 0 0 0])
    mean([1 1 1 1])
    mean([2 2 1 1])
    mean([4 4 4 4])
    };

ge = MultigraphBUDEnsemble('DENSITIES', densities);
dict = ge.get('G_DICT');
for i = 1:1:10
    g = MultigraphBUD( ...
        'ID', ['g ' int2str(i)], ...
        'DENSITIES', ge.get('DENSITIES'), ...
        'B', B ...
        );
     dict.add(g)
end
ge.set('g_dict', dict);

m_outside_g = DegreeAvEnsemble('G', ge);
assert(isequal(m_outside_g.get('M'), known_degree_av), ...
    [BRAPH2.STR ':DegreeAvEnsemble:' BRAPH2.BUG_ERR], ...
    'DegreeAvEnsemble is not being calculated correctly for MultigraphBUDEnsemble.')

m_inside_g = ge.getMeasure('DegreeAvEnsemble');
assert(isequal(m_inside_g.get('M'), known_degree_av), ...
    [BRAPH2.STR ':DegreeAvEnsemble:' BRAPH2.BUG_ERR], ...
    'DegreeAvEnsemble is not being calculated correctly for MultigraphBUDEnsemble.')

%%% ¡test!
%%%% ¡name!
MultiplexGraphBUEnsemble
%%%% ¡code!
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

known_degree_av = {
    mean([2 1 1])
    mean([1 2 1])
    };

ge = MultiplexGraphBUEnsemble();
dict = ge.get('G_DICT');
for i = 1:1:10
    g = MultiplexGraphBU( ...
        'ID', ['g ' int2str(i)], ...
        'B', B ...
        );
    dict.add(g)
end
ge.set('g_dict', dict);
degree_av_ensemble = DegreeAvEnsemble('G', ge).get('M');

assert(isequal(cellfun(@(x) round(x, 3), degree_av_ensemble, 'UniformOutput', false), cellfun(@(x) round(x, 3), known_degree_av, 'UniformOutput', false)), ...
    [BRAPH2.STR ':DegreeAvEnsemble:' BRAPH2.BUG_ERR], ...
    'DegreeAvEnsemble is not being calculated correctly for MultiplexGraphBU.')

%%% ¡test!
%%%% ¡name!
MultiplexGraphWUEnsemble
%%%% ¡code!
B11 = [
    0   .2  1
    .2  0   0
    1   0   0
    ];
B22 = [
    0   1   0
    1   0   .3
    0   .3  0
    ];
B= {B11 B22};

known_degree_av = {
    mean([2 1 1])
    mean([1 2 1])
    };

ge = MultiplexGraphWUEnsemble();
dict = ge.get('G_DICT');
for i = 1:1:10
    g = MultiplexGraphWU( ...
        'ID', ['g ' int2str(i)], ...
        'B', B ...
        );
    dict.add(g)
end
ge.set('g_dict', dict);
degree_av_ensemble = DegreeAvEnsemble('G', ge).get('M');

assert(isequal(cellfun(@(x) round(x, 3), degree_av_ensemble, 'UniformOutput', false), cellfun(@(x) round(x, 3), known_degree_av, 'UniformOutput', false)), ...
    [BRAPH2.STR ':DegreeAvEnsemble:' BRAPH2.BUG_ERR], ...
    'DegreeAvEnsemble is not being calculated correctly for MultiplexGraphWU.')