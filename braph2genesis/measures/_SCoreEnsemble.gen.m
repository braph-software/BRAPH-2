%% ¡header!
SCoreEnsemble < SCore (m, s-core of a graph ensemble) is the s-core of a graph ensemble.

The s-core of a graph is the largest subnetwork comprising nodes of strength
s or higher. s is set by the user; the default value is equal to 1.


%%% ¡compatible_graphs!
GraphWDEnsemble
GraphWUEnsemble
MultiplexWDEnsemble
MultiplexWUEnsemble

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the ensemble-averaged s-core.
%%%% ¡calculate!
ge = m.get('G'); % graph ensemble from measure class

s_core_ensemble = cell(ge.layernumber(), 1);
score_threshold = m.get('SCoreThreshold');
s_core_list = cellfun(@(x) x.getMeasure('SCore', 'SCoreThreshold', score_threshold).get('M'), ge.get('G_DICT').getItems, 'UniformOutput', false);
for li = 1:1:ge.layernumber()
    s_core_li_list = cellfun(@(x) x{li}, s_core_list, 'UniformOutput', false);
    s_core_ensemble{li} = mean(cat(3, s_core_li_list{:}), 3);
end

value = s_core_ensemble;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphWUEnsemble
%%%% ¡code!
B = [
    0   .5  1  0; 
    .5  0   1  .8; 
    1   1   0  0;
    0   .8  0  0
    ];

known_s_core = {[
                0   .5  1  0;
                .5  0   1  0;
                1   1   0  0;
                0   0   0  0
                ]};

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

s_core_ensemble = SCoreEnsemble('G', ge, 'SCoreThreshold', 1.5);
assert(isequal(s_core_ensemble.get('M'), known_s_core), ...
    [BRAPH2.STR ':SCoreEnsemble:' BRAPH2.BUG_ERR], ...
    'SCoreEnsemble is not being calculated correctly for GraphWUEnsemble.')

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

known_s_core = {[
                0   1  1  0; 
                .2  0  1  0; 
                1   1  0  0;
                0   0  0  0
                ]};

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

s_core_ensemble = SCoreEnsemble('G', ge, 'SCoreThreshold', 3).get('M');
assert(isequal(round(cell2mat(s_core_ensemble), 5), round(cell2mat(known_s_core), 5)), ...
    [BRAPH2.STR ':SCoreEnsemble:' BRAPH2.BUG_ERR], ...
    'SCoreEnsemble is not being calculated correctly for GraphWDEnsemble.')

%%% ¡test!
%%%% ¡name!
MultiplexWUEnsemble
%%%% ¡code!
B11 = [
    0   .5  1  0; 
    .5  0   1  .8; 
    1   1   0  0;
    0   .8  0  0
    ];
B22 = [
    0   .5  1  0; 
    .5  0   1  .8; 
    1   1   0  0;
    0   .8  0  0
    ];
B = {B11 B22};

known_s_core(1) = {[
                0   .5  1  0;
                .5  0   1  0;
                1   1   0  0;
                0   0   0  0
                ]};
known_s_core(2, 1) = {[
                0   .5  1  0;
                .5  0   1  0;
                1   1   0  0;
                0   0   0  0
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
s_core_ensemble = SCoreEnsemble('G', ge, 'SCoreThreshold', 1.5);

assert(isequal(s_core_ensemble.get('M'), known_s_core), ...
    [BRAPH2.STR ':SCoreEnsemble:' BRAPH2.BUG_ERR], ...
    'SCoreEnsemble is not being calculated correctly for MultiplexWUEnsemble.')