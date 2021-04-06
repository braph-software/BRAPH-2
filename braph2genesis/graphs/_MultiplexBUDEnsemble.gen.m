%% ¡header!
MultiplexBUDEnsemble < MultiplexBUD (ge, ensemble of binary undirected multiplexes with fixed densities) is an ensemble of binary undirected multiplexes with fixed densities.

%%% ¡description!
In an ensemble of binary undirected multiplexes with fixed densities (BUD), 
all the layers consist of binary undirected (BU) multiplexes derived from 
the same weighted supra-connectivity matrices binarized at different densities.
There are no connections between layers.

%%% ¡ensemble!
true

%% ¡props_update!

%%% ¡prop!
G_DICT (data, idict) contains the ensemble of binary undirected multiplexes with fixed densities.
%%%% ¡settings!
'MultiplexBUD'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'MultiplexBUD', 'IT_KEY', 1)

%%% ¡prop!
A (result, cell) is the cell containing the multiplex binary adjacency matrices of the binary undirected multiplexes with fixed densities.
%%%% ¡calculate!
A_list = cellfun(@(x) cell2mat(x.get('A')), ge.get('G_DICT').getItems, 'UniformOutput', false);
A = mean(cat(3, A_list{:}), 3);
if isempty(A)
    A = {A};
else
    L = length(ge.get('G_DICT').getItems{1}.get('B'));
    num_densities = length(ge.get('G_DICT').getItems{1}.get('DENSITIES'));
    A = mat2cell(A, size(A)/(L*num_densities), size(A)/(L*num_densities));
end
value = A;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Constructor
%%%% ¡code!
ge = MultiplexBUDEnsemble();

dict = ge.get('G_DICT');
for i = 1:1:10
    g = MultiplexBUD( ...
        'ID', ['g ' int2str(i)], ...
        'B', {rand(10), rand(10)}, ...
        'DENSITIES', [0 55 100] ...
        );
    dict.add(g);   
end
ge.set('g_dict', dict);

assert(ge.get('G_DICT').length == 10, ...
    [BRAPH2.STR ':MultiplexBUDEnsemble:' BRAPH2.BUG_ERR], ...
    'MultiplexBUDEnsemble is not constructing well.')