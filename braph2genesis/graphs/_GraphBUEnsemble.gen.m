%% ¡header!
GraphBUEnsemble < GraphBU (ge, ensemble of binary undirected graphs) is an ensemble of binary undirected graphs.

%%% ¡description!
In an ensemble of binary undirected (BU) graphs, 
the edges are associated with a real number 0 or 1 
indicating connection, and are undirected.
The connectivity matrix is symmetric.

%%% ¡ensemble!
true

%% ¡props_update!

%%% ¡prop!
G_DICT (data, idict) contains the ensemble of binary undirected graphs.
%%%% ¡settings!
'GraphBU'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'GraphBU', 'IT_KEY', 1)

%%% ¡prop!
A (result, adjacency) is the symmetric non-negative average adjacency matrix of the ensemble of binary undirected graphs.
%%%% ¡calculate!
A_list = cellfun(@(x) x.get('A'), ge.get('G_DICT').getItems, 'UniformOutput', false);
A = mean(cat(3, A_list{:}), 3);

value = A;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Constructor
%%%% ¡code!
ge = GraphBUEnsemble();

for i = 1:1:10
    g = GraphBU( ...
        'ID', ['g ' int2str(i)], ...
        'B', rand(10) ...
        );
    ge.get('G_DICT').add(g)
end

assert(ge.get('G_DICT').length == 10, ...
    [BRAPH2.STR ':GraphBUEnsemble:' BRAPH2.BUG_ERR], ...
    'GraphBUEnsemble is not constructing well.')
