%% ¡header!
RichnessEnsemble < Richness (m, richness of a graph ensemble) is the richness of a graph ensemble.

%%% ¡description!
The richness of a node is the sum of the edges that connect nodes
of higher degree within a layer.

%%% ¡compatible_graphs!
GraphBDEnsemble
GraphBUEnsemble
MultigraphBUDEnsemble
MultigraphBUTEnsemble
GraphWDEnsemble
GraphWUEnsemble
MultiplexBDEnsemble
MultiplexBUEnsemble
MultiplexWDEnsemble
MultiplexWUEnsemble

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the ensemble-averaged richness.
%%%% ¡calculate!
ge = m.get('G'); % graph ensemble from measure class

richness_ensemble = cell(ge.layernumber(), 1);

richness_list = cellfun(@(x) x.getMeasure('Richness').get('M'), ge.get('G_DICT').getItems, 'UniformOutput', false);
for li = 1:1:ge.layernumber()
    richness_li_list = cellfun(@(x) x{li}, richness_list, 'UniformOutput', false);
    richness_ensemble{li} = mean(cat(3, richness_li_list{:}), 3);
end

value = richness_ensemble;

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

known_richness = {[1 0 1 1]'};

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

richness = RichnessEnsemble('G', ge).get('M');

assert(isequal(richness, known_richness), ...
    [BRAPH2.STR ':RichnessEnsemble:' BRAPH2.BUG_ERR], ...
    'RichnessEnsemble is not being calculated correctly for GraphBUEnsemble.')

%%% ¡test!
%%%% ¡name!
GraphBDEnsemble
%%%% ¡code!
B = [
    0  1  1  0; 
    1  0  1  1; 
    1  1  0  0;
    0  1  0  0
    ];

known_richness = {[1 0 1 1]'};

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

richness = RichnessEnsemble('G', ge).get('M');

assert(isequal(richness, known_richness), ...
    [BRAPH2.STR ':RichnessEnsemble:' BRAPH2.BUG_ERR], ...
    'RichnessEnsemble is not being calculated correctly for GraphBDEnsemble.')


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
             
known_richness = {
                 [1 0 2 3/2]'
                 [1 0 1 2]'
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

richness = RichnessEnsemble('G', ge).get('M');

assert(isequal(richness, known_richness), ...
    [BRAPH2.STR ':RichnessEnsemble:' BRAPH2.BUG_ERR], ...
    'RichnessEnsemble is not being calculated correctly for MultiplexBDEnsemble.')