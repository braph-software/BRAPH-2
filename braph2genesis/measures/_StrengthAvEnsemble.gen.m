%% ¡header!
StrengthAvEnsemble < StrengthAv (m, average strength of a graph ensemble) is the average strength of a graph ensemble.

%%% ¡description!
The average strength of a graph is the average of the sum of all weights of
the edges connected to a node within a layer.

%%% ¡compatible_graphs!
GraphWUEnsemble
MultiplexGraphWUEnsemble

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the ensemble-averaged strength av.
%%%% ¡calculate!
ge = m.get('G'); % graph ensemble from measure class

strength_av_ensemble = cell(ge.layernumber(), 1);

strength_av_list = cellfun(@(x) x.getMeasure('StrengthAv').get('M'), ge.get('G_DICT').getItems, 'UniformOutput', false);
for li = 1:1:ge.layernumber()
    strength_av_li_list = cellfun(@(x) x{li}, strength_av_list, 'UniformOutput', false);
    strength_av_ensemble{li} = mean(cat(3, strength_av_li_list{:}), 3);
end

value = strength_av_ensemble;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphWUEnsemble
%%%% ¡code!
B = [
    0  .2 1
    .2 0  0
    1  0  0
    ];

known_strength_av = {mean([1.2 0.2 1])};

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

m_outside_g = StrengthAvEnsemble('G', ge);
assert(isequal(m_outside_g.get('M'), known_strength_av), ...
    [BRAPH2.STR ':StrengthAvEnsemble:' BRAPH2.BUG_ERR], ...
    'StrengthAvEnsemble is not being calculated correctly for GraphWUEnsemble.')

m_inside_g = ge.getMeasure('StrengthAvEnsemble');
assert(isequal(m_inside_g.get('M'), known_strength_av), ...
    [BRAPH2.STR ':StrengthAvEnsemble:' BRAPH2.BUG_ERR], ...
    'StrengthAvEnsemble is not being calculated correctly for GraphWUEnsemble.')

%%% ¡test!
%%%% ¡name!
MultiplexGraphWUEnsemble
%%%% ¡code!
B11 = [
    0  .2 1
    .2 0  0
    1  0  0
    ];
B22 = [
    0 1  0
    1 0  .4
    0 .4 0
    ];
B = {B11 B22};

known_strength_av = {
                 mean([1.2 .2  1])
                 mean([1  1.4 .4])
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

m_outside_g = StrengthAvEnsemble('G', ge).get('M');
assert(isequal(cellfun(@(x) round(x, 3), m_outside_g, 'UniformOutput', false), cellfun(@(x) round(x, 3), known_strength_av, 'UniformOutput', false)), ...
    [BRAPH2.STR ':StrengthAvEnsemble:' BRAPH2.BUG_ERR], ...
    'StrengthAvEnsemble is not being calculated correctly for MultiplexGraphWUEnsemble.')

m_inside_g = ge.getMeasure('StrengthAvEnsemble').get('M');
assert(isequal(cellfun(@(x) round(x, 3), m_inside_g, 'UniformOutput', false), cellfun(@(x) round(x, 3), known_strength_av, 'UniformOutput', false)), ...
    [BRAPH2.STR ':StrengthAvEnsemble:' BRAPH2.BUG_ERR], ...
    'StrengthAvEnsemble is not being calculated correctly for MultiplexGraphWUEnsemble.')