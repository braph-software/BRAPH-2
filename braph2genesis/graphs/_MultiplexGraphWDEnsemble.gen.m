%% ¡header!
MultiplexGraphWDEnsemble < MultiplexGraphWD (ge, ensemble of multiplex weighted directed graph) is a multiplex weighted directed graph.

%%% ¡description!
In an ensemble of multiplex weighted directed (WD) graph, 
the edges are associated with a real number between 0 and 1 
indicating the strength of the connection, and are directed.

%%% ¡ensemble!
true

%% ¡props_update!

%%% ¡prop!
G_DICT (data, idict) contains the ensemble of multiplex weighted directed graph.
%%%% ¡settings!
'MultiplexGraphWD'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'MultiplexGraphWD', 'IT_KEY', 1)

%%% ¡prop!
A (result, cell) is the cell containing the multiplex weighted adjacency matrices of the multiplex weighted directed graph.
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
ge = MultiplexGraphWDEnsemble();

dict = ge.get('G_DICT');
for i = 1:1:10
    g = MultiplexGraphWD( ...
        'ID', ['g ' int2str(i)], ...
        'B', {rand(10), rand(10)} ...
        );
    dict.add(g);   
end
ge.set('g_dict', dict);

assert(ge.get('G_DICT').length == 10, ...
    [BRAPH2.STR ':MultiplexGraphWDEnsemble:' BRAPH2.BUG_ERR], ...
    'MultiplexGraphWDEnsemble is not constructing well.')