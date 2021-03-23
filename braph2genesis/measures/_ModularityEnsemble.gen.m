%% ¡header!
ModularityEnsemble < Modularity (m, modularity of a graph ensemble) is the modularity of a graph ensemble.

%%% ¡description!
The modularity of a graph is the quality of the resulting partition of the network. 

%%% ¡compatible_graphs!
GraphWUEnsemble
GraphBUEnsemble
GraphWDEnsemble
GraphBDEnsemble

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the ensemble-averaged modularity.
%%%% ¡calculate!
ge = m.get('G'); % graph ensemble from measure class

modularity_ensemble = cell(ge.layernumber(), 1);
modularity_list = cellfun(@(x) x.getMeasure('Modularity').get('M'), ge.get('G_DICT').getItems, 'UniformOutput', false);
for li = 1:1:ge.layernumber()
    modularity_li_list = cellfun(@(x) x{li}, modularity_list, 'UniformOutput', false);
    modularity_ensemble{li} = mean(cat(3, modularity_li_list{:}), 3);
end

value = modularity_ensemble;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBUEnsemble
%%%% ¡code!
B = [
    1 0 1 1
    0 0 0 0
    1 0 1 0
    1 0 0 1
    ];

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

modularity_ensemble = ModularityEnsemble('G', g).get('M');

assert(~isempty(modularity_ensemble), ...
    [BRAPH2.STR ':ModularityEnsemble:' BRAPH2.BUG_ERR], ...
    'ModularityEnsemble is not being calculated correctly for GraphBUEnsemble.');