%% ¡header!
TransitivityEnsemble < Triangles (m, transitivity of a graph ensemble) is the transitivity of a graph ensemble.

%%% ¡description!
The transitivity are calculated as the fraction of triangles to the number 
of (unordered) triplets within a layer.

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
M (result, cell) is the ensemble-averaged transitivity.
%%%% ¡calculate!
ge = m.get('G'); % graph ensemble from measure class

transitivity_ensemble = cell(ge.layernumber(), 1);

transitivity_list = cellfun(@(x) x.getMeasure('Transitivity').get('M'), ge.get('G_DICT').getItems, 'UniformOutput', false);
for li = 1:1:ge.layernumber()
    transitivity_li_list = cellfun(@(x) x{li}, transitivity_list, 'UniformOutput', false);
    transitivity_ensemble{li} = mean(cat(3, transitivity_li_list{:}), 3);
end

value = transitivity_ensemble;

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

known_transitivity = {3/4};

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

m_outside_g = TransitivityEnsemble('G', ge);
assert(isequal(m_outside_g.get('M'), known_transitivity), ...
    [BRAPH2.STR ':TransitivityEnsemble:' BRAPH2.BUG_ERR], ...
    'TransitivityEnsemble is not being calculated correctly for GraphBUEnsemble.')

m_inside_g = ge.getMeasure('TransitivityEnsemble');
assert(isequal(m_inside_g.get('M'), known_transitivity), ...
    [BRAPH2.STR ':TransitivityEnsemble:' BRAPH2.BUG_ERR], ...
    'TransitivityEnsemble is not being calculated correctly for GraphBUEnsemble.')

%%% ¡test!
%%%% ¡name!
GraphWUEnsemble
%%%% ¡code!
B = [
    0 1 1 1;
    1 0 1 0;
    1 1 0 1;
    1 0 1 0;
    ];

known_transitivity = {3/4};

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

m_outside_g = TransitivityEnsemble('G', ge);
assert(isequal(m_outside_g.get('M'), known_transitivity), ...
    [BRAPH2.STR ':TransitivityEnsemble:' BRAPH2.BUG_ERR], ...
    'TransitivityEnsemble is not being calculated correctly for GraphWUEnsemble.')

m_inside_g = ge.getMeasure('TransitivityEnsemble');
assert(isequal(m_inside_g.get('M'), known_transitivity), ...
    [BRAPH2.STR ':TransitivityEnsemble:' BRAPH2.BUG_ERR], ...
    'TransitivityEnsemble is not being calculated correctly for GraphWUEnsemble.')

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

known_transitivity = {
                     3/4
                     0
                     };

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

m_outside_g = TransitivityEnsemble('G', ge);
assert(isequal(m_outside_g.get('M'), known_transitivity), ...
    [BRAPH2.STR ':TransitivityEnsemble:' BRAPH2.BUG_ERR], ...
    'TransitivityEnsemble is not being calculated correctly for MultigraphBUTEnsemble.')

m_inside_g = ge.getMeasure('TransitivityEnsemble');
assert(isequal(m_inside_g.get('M'), known_transitivity), ...
    [BRAPH2.STR ':TransitivityEnsemble:' BRAPH2.BUG_ERR], ...
    'TransitivityEnsemble is not being calculated correctly for MultigraphBUTEnsemble.')

%%% ¡test!
%%%% ¡name!
MultiplexBUEnsemble
B11 = [
    0 1 1 1;
    1 0 1 0;
    1 1 0 1;
    1 0 1 0
    ];
B22 = [
    0 1 1 1;
    1 0 1 0;
    1 1 0 1;
    1 0 1 0
    ];

B = {B11 B22};

known_transitivity = {
    3/4
    3/4
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
transitivity = TransitivityEnsemble('G', ge);

assert(isequal(transitivity.get('M'), known_transitivity), ...
    [BRAPH2.STR ':TransitivityEnsemble:' BRAPH2.BUG_ERR], ...
    'TransitivityEnsemble is not being calculated correctly for MultiplexBUEnsemble.')