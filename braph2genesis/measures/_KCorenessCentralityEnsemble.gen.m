%% ¡header!
KCorenessCentralityEnsemble < KCorenessCentrality (m, k-coreness centrality of a graph ensemble) is the k-coreness centrality of a graph ensemble.

%%% ¡description!
The k-coreness centrality of a node is k if the node belongs to the k-core
but not to the (k+1)-core.

%%% ¡compatible_graphs!
GraphWDEnsemble
GraphWUEnsemble
GraphBDEnsemble
GraphBUEnsemble
MultigraphBUDEnsemble
MultigraphBUTEnsemble
MultiplexBDEnsemble
MultiplexBUEnsemble
MultiplexWDEnsemble
MultiplexWUEnsemble

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the ensemble-averaged k-coreness centrality.
%%%% ¡calculate!
ge = m.get('G'); % graph ensemble from measure class

k_coreness_centrality_ensemble = cell(ge.layernumber(), 1);

k_coreness_centrality_list = cellfun(@(x) x.getMeasure('KCorenessCentrality').get('M'), ge.get('G_DICT').getItems, 'UniformOutput', false);
for li = 1:1:ge.layernumber()
    k_coreness_centrality_li_list = cellfun(@(x) x{li}, k_coreness_centrality_list, 'UniformOutput', false);
    k_coreness_centrality_ensemble{li} = mean(cat(3, k_coreness_centrality_li_list{:}), 3);
end

value = k_coreness_centrality_ensemble;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBUEnsemble
%%%% ¡code!
B = [
    0  1  1  0; 
    1  0  1  1; 
    1  1  0  0;
    0  1  0  0
    ];

known_k_coreness_centrality = {[2 2 2 1]'};

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

k_coreness_centrality_ensemble = KCorenessCentralityEnsemble('G', ge);
assert(isequal(k_coreness_centrality_ensemble.get('M'), known_k_coreness_centrality), ...
    [BRAPH2.STR ':KCorenessCentralityEnsemble:' BRAPH2.BUG_ERR], ...
    'KCorenessCentralityEnsemble is not being calculated correctly for GraphBUEnsemble.')

%%% ¡test!
%%%% ¡name!
GraphWDEnsemble
%%%% ¡code!
B = [
    0   1   1  .1; 
    .2  0   1  1; 
    1   1   0  0;
    0   .3  0  0
    ];

known_k_coreness_centrality = {[4 4 4 3]'};

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

k_coreness_centrality_ensemble = KCorenessCentralityEnsemble('G', ge);
assert(isequal(k_coreness_centrality_ensemble.get('M'), known_k_coreness_centrality), ...
    [BRAPH2.STR ':KCorenessCentralityEnsemble:' BRAPH2.BUG_ERR], ...
    'KCorenessCentralityEnsemble is not being calculated correctly for GraphWDEnsemble.')

%%% ¡test!
%%%% ¡name!
MultiplexBDEnsemble
%%%% ¡code!
B11 = [
    0  1  1  1; 
    1  0  1  1; 
    1  1  0  0;
    0  1  0  0
    ];
B22 = [
    0  1  1  1; 
    1  0  1  1; 
    1  1  0  0;
    0  1  1  0
    ];
B = {B11 B22};

known_k_coreness_centrality = {
                        [4 4 4 3]'
                        [4 4 4 4]'
                        };          

ge = MultiplexBDEnsemble();
dict = ge.get('G_DICT');
for i = 1:1:10
    g = MultiplexBD( ...
        'ID', ['g ' int2str(i)], ...
        'B', B ...
        );
    dict.add(g)
end
ge.set('g_dict', dict);
k_coreness_centrality_ensemble = KCorenessCentralityEnsemble('G', ge);

assert(isequal(k_coreness_centrality_ensemble.get('M'), known_k_coreness_centrality), ...
    [BRAPH2.STR ':KCorenessCentralityEnsemble:' BRAPH2.BUG_ERR], ...
    'KCorenessCentralityEnsemble is not being calculated correctly for MultiplexBDEnsemble.')

%%% ¡test!
%%%% ¡name!
MultiplexWUEnsemble
%%%% ¡code!
B11 = [
    0   .1  1  0; 
    .1  0   1  .8; 
    1   1   0  0;
    0   .8  0  0
    ];
B22 = [
    0   .1  1  1; 
    .1  0   1  .8; 
    1   1   0  0;
    1   .8  0  0
    ];
B = {B11 B22};

known_k_coreness_centrality = {
                        [2 2 2 1]'
                        [2 2 2 2]'
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
k_coreness_centrality_ensemble = KCorenessCentralityEnsemble('G', ge);

assert(isequal(k_coreness_centrality_ensemble.get('M'), known_k_coreness_centrality), ...
    [BRAPH2.STR ':KCorenessCentralityEnsemble:' BRAPH2.BUG_ERR], ...
    'KCorenessCentralityEnsemble is not being calculated correctly for MultiplexWUEnsemble.')