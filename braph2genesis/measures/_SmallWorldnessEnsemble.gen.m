%% ¡header!
SmallWorldnessEnsemble < SmallWorldness (m, small worldness of a graph ensemble) is the small worldness of a graph ensemble.

%%% ¡description!
The small-worldness coefficient is the fraction of the clustering coefficient 
and average path length of each layer and the clustering coefficient and
average path length of 100 random graphs.

%%% ¡compatible_graphs!
GraphWUEnsemble
GraphBUEnsemble
MultiplexWUEnsemble
MultiplexBUEnsemble

%% ¡props_update!

%%% ¡prop!
M (result, measure) is the ensemble-averaged smallworldness.
%%%% ¡calculate!
ge = m.get('G'); % graph ensemble from measure class

smallworldness_ensemble = cell(ge.layernumber(), 1);

smallworldness_list = cellfun(@(x) x.getMeasure('SmallWorldness').get('M'), ge.get('G_DICT').getItems, 'UniformOutput', false);
for li = 1:1:ge.layernumber()
    smallworldness_li_list = cellfun(@(x) x{li}, smallworldness_list, 'UniformOutput', false);
    smallworldness_ensemble{li} = mean(cat(3, smallworldness_li_list{:}), 3);
end

value = smallworldness_ensemble;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBUEnsemble
%%%% ¡code!
A = rand(20);

known_smallworldnessness = {1};

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

m_outside_g = SmallWorldnessEnsemble('G', ge).get('M');
assert(isequal(m_outside_g{1}, known_smallworldness{1}), ...
    [BRAPH2.STR ':SmallWorldnessEnsemble:' BRAPH2.BUG_ERR], ...
    'SmallWorldnessEnsemble is not being calculated correctly for GraphWUEnsemble.')

m_inside_g = ge.getMeasure('SmallWorldnessEnsemble').get('M');
assert(isequal(m_inside_g{1}, known_smallworldness{1}), ...
    [BRAPH2.STR ':SmallWorldnessEnsemble:' BRAPH2.BUG_ERR], ...
    'SmallWorldnessEnsemble is not being calculated correctly for GraphWUEnsemble.')

%%% ¡test!
%%%% ¡name!
MultiplexWUEnsemble
%%%% ¡code!
A11 = rand(20);

A22 = rand(20);
A = {A11 A22};

known_smallworldnessness = {
                       1
                       1
                       };

             
ge = MultiplexWUEnsemble();
dict = ge.get('G_DICT');
for i = 1:1:10
    g = MultiplexWU( ...
        'ID', ['g ' int2str(i)], ...        
        'B', B ...
        );
    dict.add(g)
end
ge.set('g_dict', dict);

m_outside_g = SmallWorldnessEnsemble('G', ge).get('M');
assert(isequal(m_outside_g, known_smallworldness), ...
    [BRAPH2.STR ':SmallWorldnessEnsemble:' BRAPH2.BUG_ERR], ...
    'SmallWorldnessEnsemble is not being calculated correctly for MultiplexWUEnsemble.')

m_inside_g = ge.getMeasure('SmallWorldnessEnsemble').get('M');
assert(isequal( m_inside_g, known_smallworldness), ...
    [BRAPH2.STR ':SmallWorldnessEnsemble:' BRAPH2.BUG_ERR], ...
    'SmallWorldnessEnsemble is not being calculated correctly for MultiplexWUEnsemble.')