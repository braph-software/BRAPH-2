%% ¡header!
GraphBDEnsemble < GraphWD (ge, ensemble of binary directed graphs) is an ensemble of binary directed graphs.

%%% ¡description!
In an ensemble of binary directed (BD) graphs, 
the edges are associated with a real number 0 or 1 
indicating connection, and are directed.

%%% ¡ensemble!
true

%% ¡props_update!

%%% ¡prop!
G_DICT (data, idict) contains the ensemble of binary directed graphs.
%%%% ¡settings!
'GraphBD'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'GraphBD', 'IT_KEY', 1)

%%% ¡prop!
A (result, matrix) is the non-negative average adjacency matrix of the ensemble of binary directed graphs.
%%%% ¡calculate!
A_list = cellfun(@(x) x.get('A'), ge.get('G_DICT').getItems, 'UniformOutput', false);
A = mean(cat(3, A_list{:}), 3);

value = A;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Constructor
%%%% ¡code!
ge = GraphBDEnsemble();

dict = ge.get('G_DICT');
for i = 1:1:10
    g = GraphBD( ...
        'ID', ['g ' int2str(i)], ...
        'B', rand(10) ...
        );
    dict.add(g);   
end
ge.set('g_dict', dict);

assert(ge.get('G_DICT').length == 10, ...
    [BRAPH2.STR ':GraphBDEnsemble:' BRAPH2.BUG_ERR], ...
    'GraphBDEnsemble is not constructing well.')
