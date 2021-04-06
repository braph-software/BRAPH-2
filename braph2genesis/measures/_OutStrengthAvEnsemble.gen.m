%% ¡header!
OutStrengthAvEnsemble < OutStrengthAv (m, average out-strength of a graph ensemble) is the average out-strength of a graph ensemble.

%%% ¡description!
The average out-strength of a graph is the average of the sum of all weights of
the outward edges connected to a node within a layer. 

%%% ¡compatible_graphs!
GraphWDEnsemble
MultiplexWDEnsemble

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the ensemble-averaged out-strength av.
%%%% ¡calculate!
ge = m.get('G'); % graph ensemble from measure class

out_strength_av_ensemble = cell(ge.layernumber(), 1);

out_strength_av_list = cellfun(@(x) x.getMeasure('OutStrengthAv').get('M'), ge.get('G_DICT').getItems, 'UniformOutput', false);
for li = 1:1:ge.layernumber()
    strength_av_li_list = cellfun(@(x) x{li}, out_strength_av_list, 'UniformOutput', false);
    out_strength_av_ensemble{li} = mean(cat(3, strength_av_li_list{:}), 3);
end

value = out_strength_av_ensemble;

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

known_out_strength_av = {mean([1.2 0.8 1])};

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

m_outside_g = OutStrengthAvEnsemble('G', ge);
assert(isequal(m_outside_g.get('M'), known_out_strength_av), ...
    [BRAPH2.STR ':OutStrengthAvEnsemble:' BRAPH2.BUG_ERR], ...
    'OutStrengthAvEnsemble is not being calculated correctly for GraphWDEnsemble.')

m_inside_g = ge.getMeasure('OutStrengthAvEnsemble');
assert(isequal(m_inside_g.get('M'), known_out_strength_av), ...
    [BRAPH2.STR ':OutStrengthAvEnsemble:' BRAPH2.BUG_ERR], ...
    'OutStrengthAvEnsemble is not being calculated correctly for GraphWDEnsemble.')

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

known_out_strength_av = {
                 mean([1.2 .8  1])
                 mean([1.6 1.4 .4])
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

m_outside_g = OutStrengthAvEnsemble('G', ge).get('M');
assert(isequal(cellfun(@(x) round(x, 3), m_outside_g, 'UniformOutput', false), cellfun(@(x) round(x, 3), known_out_strength_av, 'UniformOutput', false)), ...
    [BRAPH2.STR ':OutStrengthAvEnsemble:' BRAPH2.BUG_ERR], ...
    'OutStrengthAvEnsemble is not being calculated correctly for MultiplexWDEnsemble.')

m_inside_g = ge.getMeasure('OutStrengthAvEnsemble').get('M');
assert(isequal(cellfun(@(x) round(x, 3), m_inside_g, 'UniformOutput', false), cellfun(@(x) round(x, 3), known_out_strength_av, 'UniformOutput', false)), ...
    [BRAPH2.STR ':OutStrengthAvEnsemble:' BRAPH2.BUG_ERR], ...
    'OutStrengthAvEnsemble is not being calculated correctly for MultiplexWDEnsemble.')