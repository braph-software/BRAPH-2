%% ¡header!
KCoreEnsemble < KCore (m, k-core of a graph ensemble) is the k-core of a graph ensemble.

%%% ¡description!
The k-core of a graph is the largest subnetwork comprising nodes of degree k or higher. 
k is set by the user; the default value is equal to 1.

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
M (result, cell) is the ensemble-averaged k-core.
%%%% ¡calculate!
ge = m.get('G'); % graph ensemble from measure class

k_core_ensemble = cell(ge.layernumber(), 1);
kcore_threshold = m.get('KCoreThreshold');
k_core_list = cellfun(@(x) x.getMeasure('KCore', 'KCoreThreshold', kcore_threshold).get('M'), ge.get('G_DICT').getItems, 'UniformOutput', false);
for li = 1:1:ge.layernumber()
    k_core_li_list = cellfun(@(x) x{li}, k_core_list, 'UniformOutput', false);
    k_core_ensemble{li} = mean(cat(3, k_core_li_list{:}), 3);
end

value = k_core_ensemble;

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

known_k_core = {[
                0  1  1  0;
                1  0  1  0;
                1  1  0  0;
                0  0  0  0
                ]};

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

k_core_ensemble = KCoreEnsemble('G', ge, 'KCoreThreshold', 2);
assert(isequal(k_core_ensemble.get('M'), known_k_core), ...
    [BRAPH2.STR ':KCoreEnsemble:' BRAPH2.BUG_ERR], ...
    'KCoreEnsemble is not being calculated correctly for GraphBUEnsemble.')

%%% ¡test!
%%%% ¡name!
GraphBDEnsemble
%%%% ¡code!
B = [
    0  1  1  1; 
    1  0  1  1; 
    1  1  0  0;
    0  1  0  0
    ];

known_k_core = {[
                0  1  1  0;
                1  0  1  0;
                1  1  0  0;
                0  0  0  0
                ]};

ge = GraphBDEnsemble();
dict = ge.get('G_DICT');
for i = 1:1:10
    g = GraphBD( ...
        'ID', ['g ' int2str(i)], ...
        'B', B ...
        );
    dict.add(g)
end
ge.set('g_dict', dict);

k_core_ensemble = KCoreEnsemble('G', ge, 'KCoreThreshold', 4);
assert(isequal(k_core_ensemble.get('M'), known_k_core), ...
    [BRAPH2.STR ':KCoreEnsemble:' BRAPH2.BUG_ERR], ...
    'KCoreEnsemble is not being calculated correctly for GraphBDEnsemble.')

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

known_k_core(1) = {[
                0  1  1  0;
                1  0  1  0;
                1  1  0  0;
                0  0  0  0
                ]};
known_k_core(2, 1) = {[
                0  1  1  1;
                1  0  1  1;
                1  1  0  0;
                1  1  0  0
                ]};     

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
k_core_ensemble = KCoreEnsemble('G', ge, 'KCoreThreshold', 2);

assert(isequal(k_core_ensemble.get('M'), known_k_core), ...
    [BRAPH2.STR ':KCoreEnsemble:' BRAPH2.BUG_ERR], ...
    'KCoreEnsemble is not being calculated correctly for MultiplexWUEnsemble.')

%%% ¡test!
%%%% ¡name!
MultiplexWDEnsemble
%%%% ¡code!
B11 = [
    0   1   1  .1; 
    .2  0   1  1; 
    1   1   0  0;
    0   .3  0  0
    ];
B22 = [
    0   1   1   .1; 
    .2  0   1   1; 
    1   1   0   0;
    0   .3  .7  0
    ];
B = {B11 B22};

known_k_core(1) = {[
                0  1  1  0;
                1  0  1  0;
                1  1  0  0;
                0  0  0  0
                ]};
known_k_core(2, 1) = {[
                0  1  1  1;
                1  0  1  1;
                1  1  0  0;
                0  1  1  0
                ]};              

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
k_core_ensemble = KCoreEnsemble('G', ge, 'KCoreThreshold', 4);

assert(isequal(k_core_ensemble.get('M'), known_k_core), ...
    [BRAPH2.STR ':KCoreEnsemble:' BRAPH2.BUG_ERR], ...
    'KCoreEnsemble is not being calculated correctly for MultiplexWDEnsemble.')