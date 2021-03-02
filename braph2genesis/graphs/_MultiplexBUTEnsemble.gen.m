%% ¡header!
MultiplexBUTEnsemble < MultiplexBUT (ge, ensemble of binary undirected multiplexes with fixed thresholds) is an ensemble of binary undirected multiplexes with fixed thresholds.

%%% ¡description!
In an ensemble of binary undirected multiplexes with fixed thresholds (BUT), 
all the layers consist of binary undirected (BU) multiplexes derived from 
the same weighted supra-connectivity matrices binarized at different thresholds.
There are no connections between layers.

%%% ¡ensemble!
true

%% ¡props_update!

%%% ¡prop!
G_DICT (data, idict) contains the ensemble of binary undirected multiplexes with fixed thresholds.
%%%% ¡settings!
'MultiplexBUT'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'MultiplexBUT', 'IT_KEY', 1)

%%% ¡prop!
A (result, cell) is the cell containing the multiplex binary adjacency matrices of the binary undirected multiplexes with fixed thresholds.
%%%% ¡calculate!
A_list = cellfun(@(x) cell2mat(x.get('A')), ge.get('G_DICT').getItems, 'UniformOutput', false);
A = mean(cat(3, A_list{:}), 3);
if isempty(A)
    A = {A};
else
    L = length(ge.get('G_DICT').getItems{1}.get('B'));
    num_thresholds = length(ge.get('G_DICT').getItems{1}.get('THRESHOLDS'));
    A = mat2cell(A, size(A)/(L*num_thresholds), size(A)/(L*num_thresholds));
end
value = A;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
Constructor
%%%% ¡code!
ge = MultiplexBUTEnsemble();

dict = ge.get('G_DICT');
for i = 1:1:10
    g = MultiplexBUT( ...
        'ID', ['g ' int2str(i)], ...
        'B', {rand(10), rand(10)}, ...
        'THRESHOLDS', [0 .1 .2 .4] ...
        );
    dict.add(g);   
end
ge.set('g_dict', dict);

assert(ge.get('G_DICT').length == 10, ...
    [BRAPH2.STR ':MultiplexBUTEnsemble:' BRAPH2.BUG_ERR], ...
    'MultiplexBUTEnsemble is not constructing well.')