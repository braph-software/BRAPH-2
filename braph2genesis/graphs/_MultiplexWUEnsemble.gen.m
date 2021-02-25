%% ¡header!
MultiplexWUEnsemble < MultiplexWU (ge, ensemble of multiplex weighted undirected graph) is a multiplex weighted undirected graph.

%%% ¡description!
In an ensemble of multiplex weighted undirected (WU) graph, 
the edges are associated with a real number between 0 and 1 
indicating the strength of the connection, and are undirected.

%%% ¡ensemble!
true

%% ¡props_update!

%%% ¡prop!
G_DICT (data, idict) contains the ensemble of multiplex weighted undirected graph.
%%%% ¡settings!
'MultiplexWU'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'MultiplexWU', 'IT_KEY', 1)

%%% ¡prop!
A (result, cell) is the cell containing the multiplex weighted adjacency matrices of the multiplex weighted undirected graph.
%%%% ¡calculate!
A_list = cellfun(@(x) cell2mat(x.get('A')), ge.get('G_DICT').getItems, 'UniformOutput', false);
A = mean(cat(3, A_list{:}), 3);
if isempty(A)
    A = {A};
else
    L = length(ge.get('G_DICT').getItems{1}.get('B'));
    A = mat2cell(A, size(A)/L, size(A)/L);
end
value = A;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Constructor
%%%% ¡code!
ge = MultiplexWUEnsemble();

dict = ge.get('G_DICT');
for i = 1:1:10
    g = MultiplexWU( ...
        'ID', ['g ' int2str(i)], ...
        'B', {rand(10), rand(10)} ...
        );
    dict.add(g);   
end
ge.set('g_dict', dict);

assert(ge.get('G_DICT').length == 10, ...
    [BRAPH2.STR ':MultiplexWUEnsemble:' BRAPH2.BUG_ERR], ...
    'MultiplexWUEnsemble is not constructing well.')