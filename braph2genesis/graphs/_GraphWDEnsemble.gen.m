%% ¡header!
GraphWDEnsemble < GraphWD (ge, ensemble of weighted directed graphs) is an ensemble of weighted directed graphs.

%%% ¡description!
In an ensemble of weighted directed (WU) graphs, 
the edges are associated with a real number between 0 and 1 
indicating the strength of the connection, and are directed.

%%% ¡ensemble!
true

%% ¡props_update!

%%% ¡prop!
G_DICT (data, idict) contains the ensemble of weighted directed graphs.
%%%% ¡settings!
'GraphWD'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'GraphWD', 'IT_KEY', 1)

%%% ¡prop!
A (result, adjacency) is the non-negative average adjacency matrix of the ensemble of weighted directed graphs.
%%%% ¡calculate!
A_list = cellfun(@(x) x.get('A'), ge.get('G_DICT').getItems, 'UniformOutput', false);
A = mean(cat(3, A_list{:}), 3);

value = A;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Constructor
%%%% ¡code!
ge = GraphWDEnsemble();

for i = 1:1:10
    g = GraphWD( ...
        'ID', ['g ' int2str(i)], ...
        'B', rand(10) ...
        );
    ge.get('G_DICT').add(g)
end

assert(ge.get('G_DICT').length == 10, ...
    [BRAPH2.STR ':GraphWDEnsemble:' BRAPH2.BUG_ERR], ...
    'GraphWDEnsemble is not constructing well.')
