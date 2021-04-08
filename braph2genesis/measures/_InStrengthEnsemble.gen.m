%% ¡header!
InStrengthEnsemble < InStrength (m, in-strength of a graph ensemble) is the in-strength of a graph ensemble.

%%% ¡description!
The in-strength of a graph is the sum of all weights of the inward edges 
connected to a node within a layer, i.e., it is the sum of the columns of 
the adjacency matrix. 

%%% ¡compatible_graphs!
GraphWDEnsemble
MultiplexWDEnsemble

%% ¡props_update!

%%% ¡prop!
M (result, measure) is the ensemble-averaged in-strength.
%%%% ¡calculate!
ge = m.get('G'); % graph ensemble from measure class

in_strength_ensemble = cell(ge.layernumber(), 1);

in_strength_list = cellfun(@(x) x.getMeasure('InStrength').get('M'), ge.get('G_DICT').getItems, 'UniformOutput', false);
for li = 1:1:ge.layernumber()
    strength_li_list = cellfun(@(x) x{li}, in_strength_list, 'UniformOutput', false);
    in_strength_ensemble{li} = mean(cat(3, strength_li_list{:}), 3);
end

value = in_strength_ensemble;

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

known_in_strength = {[1 0.2 1.8]'};

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

m_outside_g = InStrengthEnsemble('G', ge).get('M');
assert(isequal(round(m_outside_g{1}, 3), round(known_in_strength{1}, 3)), ...
    [BRAPH2.STR ':InStrengthEnsemble:' BRAPH2.BUG_ERR], ...
    'InStrengthEnsemble is not being calculated correctly for GraphWDEnsemble.')

m_inside_g = ge.getMeasure('InStrengthEnsemble').get('M');
assert(isequal(round(m_inside_g{1}, 3), round(known_in_strength{1}, 3)), ...
    [BRAPH2.STR ':InStrengthEnsemble:' BRAPH2.BUG_ERR], ...
    'InStrengthEnsemble is not being calculated correctly for GraphWDEnsemble.')

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

known_in_strength = {
                 [1 .2  1.8]'
                 [1 1.4 1]'
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

m_outside_g = InStrengthEnsemble('G', ge).get('M');
assert(isequal(cellfun(@(x) round(x, 3), m_outside_g, 'UniformOutput', false), known_in_strength), ...
    [BRAPH2.STR ':InStrengthEnsemble:' BRAPH2.BUG_ERR], ...
    'InStrengthEnsemble is not being calculated correctly for MultiplexWDEnsemble.')

m_inside_g = ge.getMeasure('InStrengthEnsemble').get('M');
assert(isequal(cellfun(@(x) round(x, 3), m_inside_g, 'UniformOutput', false), known_in_strength), ...
    [BRAPH2.STR ':InStrengthEnsemble:' BRAPH2.BUG_ERR], ...
    'InStrengthEnsemble is not being calculated correctly for MultiplexWDEnsemble.')