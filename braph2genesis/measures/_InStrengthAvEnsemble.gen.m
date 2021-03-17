%% ¡header!
InStrengthAvEnsemble < InStrengthAv (m, average in-strength of a graph ensemble) is the average in-strength of a graph ensemble.

%%% ¡description!
The average in-strength of a graph is the average of the sum of all weights of
the inward edges connected to a node within a layer. 

%%% ¡compatible_graphs!
GraphWDEnsemble
MultiplexWDEnsemble

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the ensemble-averaged in-strength av.
%%%% ¡calculate!
ge = m.get('G'); % graph ensemble from measure class

in_strength_av_ensemble = cell(ge.layernumber(), 1);

in_strength_av_list = cellfun(@(x) x.getMeasure('InStrengthAv').get('M'), ge.get('G_DICT').getItems, 'UniformOutput', false);
for li = 1:1:ge.layernumber()
    strength_av_li_list = cellfun(@(x) x{li}, in_strength_av_list, 'UniformOutput', false);
    in_strength_av_ensemble{li} = mean(cat(3, strength_av_li_list{:}), 3);
end

value = in_strength_av_ensemble;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphWDEnsemble
%%%% ¡code!
B = [
    0  .2 1
    0  0  .8
    1  0  0
    ];

known_in_strength_av = {mean([[1 0.2 1.8]])};

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

m_outside_g = InStrengthAvEnsemble('G', ge);
assert(isequal(m_outside_g.get('M'), known_in_strength_av), ...
    [BRAPH2.STR ':InStrengthAvEnsemble:' BRAPH2.BUG_ERR], ...
    'InStrengthAvEnsemble is not being calculated correctly for GraphWDEnsemble.')

m_inside_g = ge.getMeasure('InStrengthAvEnsemble');
assert(isequal(m_inside_g.get('M'), known_in_strength_av), ...
    [BRAPH2.STR ':InStrengthAvEnsemble:' BRAPH2.BUG_ERR], ...
    'InStrengthAvEnsemble is not being calculated correctly for GraphWDEnsemble.')

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

known_in_strength_av = {
                 mean([1 .2  1.8])
                 mean([1 1.4 1])
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

m_outside_g = InStrengthAvEnsemble('G', ge).get('M');
assert(isequal(cellfun(@(x) round(x, 3), m_outside_g, 'UniformOutput', false), cellfun(@(x) round(x, 3), known_in_strength_av, 'UniformOutput', false)), ...
    [BRAPH2.STR ':InStrengthAvEnsemble:' BRAPH2.BUG_ERR], ...
    'InStrengthAvEnsemble is not being calculated correctly for MultiplexWDEnsemble.')

m_inside_g = ge.getMeasure('InStrengthAvEnsemble').get('M');
assert(isequal(cellfun(@(x) round(x, 3), m_inside_g, 'UniformOutput', false), cellfun(@(x) round(x, 3), known_in_strength_av, 'UniformOutput', false)), ...
    [BRAPH2.STR ':InStrengthAvEnsemble:' BRAPH2.BUG_ERR], ...
    'InStrengthAvEnsemble is not being calculated correctly for MultiplexWDEnsemble.')