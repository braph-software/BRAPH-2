%% ¡header!
MultigraphBUDEnsemble < MultigraphBUD (ge, ensemble of binary undirected multigraph with fixed thresholds) is a binary undirected multigraph with fixed thresholds.

%%% ¡description!
In an ensemble of binary undirected multigraph with fixed densities, 
all the layers consist of binary undirected (BU) graphs 
derived from the same weighted connectivity matrix 
binarized at different densities.
There are no connections between layers.

%%% ¡ensemble!
true

%% ¡props_update!

%%% ¡prop!
G_DICT (data, idict) contains the ensemble of multigraph with fixed thresholds.
%%%% ¡settings!
'MultigraphBUD'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'MultigraphBUD', 'IT_KEY', 1)

%%% ¡prop!
A (result, cell) is a cell containing the symmetric non-negative average adjacency matrix of the ensemble of the binary undirected multigraph.
%%%% ¡calculate!
A = cell(length(ge.get('DENSITIES')));
A_list = cellfun(@(x) x.get('A'), ge.get('G_DICT').getItems, 'UniformOutput', false);
for i = 1:length(ge.get('DENSITIES'))
    sub_A_list = cellfun(@(x) x{i,i}, A_list, 'UniformOutput', false);
    sub_A = mean(cat(3, sub_A_list{:}), 3);
    A{i,i} = sub_A;
end
value = A;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Constructor
%%%% ¡code!
ge = MultigraphBUDEnsemble();

dict = ge.get('G_DICT');
for i = 1:1:10
    g = MultigraphBUD( ...
        'ID', ['g ' int2str(i)], ...
        'B', rand(10), ...
        'DENSITIES', [0 55 100] ...
        );
    dict.add(g);   
end
ge.set('g_dict', dict);

assert(ge.get('G_DICT').length == 10, ...
    [BRAPH2.STR ':MultigraphBUDEnsemble:' BRAPH2.BUG_ERR], ...
    'MultigraphBUDEnsemble is not constructing well.')
