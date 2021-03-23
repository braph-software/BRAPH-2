%% ¡header!
BetweennessCentralityEnsemble < BetweennessCentrality (m, betweennesscentrality of a graph ensemble) is the betweennesscentrality of a graph ensemble.

%%% ¡description!
The betweenness centrality of a graph is the fraction of all shortest paths in the 
graph that pass through a given node. Nodes with high values of betweenness
centrality participate in a large number of shortest paths.

%%% ¡compatible_graphs!
GraphBUEnsemble
GraphWUEnsemble
GraphBDEnsemble
GraphWDEnsemble
MultiplexBUEnsemble
MultiplexWUEnsemble
MultiplexBDEnsemble
MultiplexWDEnsemble

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the ensemble-averaged betweennesscentrality.
%%%% ¡calculate!
ge = m.get('G'); % graph ensemble from measure class

betweennesscentrality_ensemble = cell(ge.layernumber(), 1);

betweennesscentrality_list = cellfun(@(x) x.getMeasure('BetweennessCentrality').get('M'), ge.get('G_DICT').getItems, 'UniformOutput', false);
for li = 1:1:ge.layernumber()
    betweennesscentrality_li_list = cellfun(@(x) x{li}, betweennesscentrality_list, 'UniformOutput', false);
    betweennesscentrality_ensemble{li} = mean(cat(3, betweennesscentrality_li_list{:}), 3);
end

value = betweennesscentrality_ensemble;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBUEnsemble
%%%% ¡code!
B = [
    0 1 1;
    1 0 0;
    1 0 0;
    ];

known_betweennesscentrality = {[1, 0, 0]'};

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

m_outside_g = BetweennessCentralityEnsemble('G', ge);
assert(isequal(m_outside_g.get('M'), known_betweennesscentrality), ...
    [BRAPH2.STR ':BetweennessCentralityEnsemble:' BRAPH2.BUG_ERR], ...
    'BetweennessCentralityEnsemble is not being calculated correctly for GraphBUEnsemble.')

m_inside_g = ge.getMeasure('BetweennessCentralityEnsemble');
assert(isequal(m_inside_g.get('M'), known_betweennesscentrality), ...
    [BRAPH2.STR ':BetweennessCentralityEnsemble:' BRAPH2.BUG_ERR], ...
    'BetweennessCentralityEnsemble is not being calculated correctly for GraphBUEnsemble.')

%%% ¡test!
%%%% ¡name!
GraphWUEnsemble
%%%% ¡code!
B = [
    0 1 4; 
    1 0 0; 
    4 0 0; 
    ];

known_betweennesscentrality = {[1, 0, 0]'};

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

m_outside_g = BetweennessCentralityEnsemble('G', ge);
assert(isequal(m_outside_g.get('M'), known_betweennesscentrality), ...
    [BRAPH2.STR ':BetweennessCentralityEnsemble:' BRAPH2.BUG_ERR], ...
    'BetweennessCentralityEnsemble is not being calculated correctly for GraphWUEnsemble.')

m_inside_g = ge.getMeasure('BetweennessCentralityEnsemble');
assert(isequal(m_inside_g.get('M'), known_betweennesscentrality), ...
    [BRAPH2.STR ':BetweennessCentralityEnsemble:' BRAPH2.BUG_ERR], ...
    'BetweennessCentralityEnsemble is not being calculated correctly for GraphWUEnsemble.')

%%% ¡test!
%%%% ¡name!
MultiplexWDEnsemble
B11 = [
    0   1   0
    1   0   0
    4   0   0
    ];
B22 = [
    0   1   0
    1   0   0
    0   4   0
    ];

B = {B11 B22};

known_betweennesscentrality = {
    [1/2 0   0]'
    [0   1/2 0]'
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
betweennesscentrality = BetweennessCentralityEnsemble('G', ge);

assert(isequal(betweennesscentrality.get('M'), known_betweennesscentrality), ...
    [BRAPH2.STR ':BetweennessCentralityEnsemble:' BRAPH2.BUG_ERR], ...
    'BetweennessCentralityEnsemble is not being calculated correctly for MultiplexWUEnsemble.')