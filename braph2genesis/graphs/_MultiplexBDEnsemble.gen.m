%% ¡header!
MultiplexBDEnsemble < MultiplexGraphBD (ge, ensemble of multiplex binary directed graph) is a multiplex binary directed graph.

%%% ¡description!
In an ensemble of multiplex binary directed (BD) graph, 
the edges are associated with a real number 0 or 1 
indicating connection, and are directed.

%%% ¡ensemble!
true

%% ¡props_update!

%%% ¡prop!
G_DICT (data, idict) contains the ensemble of multiplex binary directed graph.
%%%% ¡settings!
'MultiplexGraphBD'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'MultiplexGraphBD', 'IT_KEY', 1)

%%% ¡prop!
A (result, cell) is the cell containing the multiplex binary adjacency matrices of the multiplex binary directed graph.
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
ge = MultiplexBDEnsemble();

dict = ge.get('G_DICT');
for i = 1:1:10
    g = MultiplexGraphBD( ...
        'ID', ['g ' int2str(i)], ...
        'B', {rand(10), rand(10)} ...
        );
    dict.add(g);   
end
ge.set('g_dict', dict);

assert(ge.get('G_DICT').length == 10, ...
    [BRAPH2.STR ':MultiplexBDEnsemble:' BRAPH2.BUG_ERR], ...
    'MultiplexBDEnsemble is not constructing well.')