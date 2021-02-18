%% ¡header!
MultiplexGraphWUEnsemble < MultiplexGraphWU (ge, ensemble of multiplex weighted undirected graph) is a multiplex binary directed graph.

%%% ¡description!
In an ensemble of multiplex weighted undirected (WU) graph, 
the edges can be either 0 (absence of connection) 
or 1 (existence of connection), 
and they are directed.

%%% ¡ensemble!
true

%% ¡props_update!

%%% ¡prop!
G_DICT (data, idict) contains the ensemble of multiplex weighted undirected graph.
%%%% ¡settings!
'MultiplexGraphWU'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'MultiplexGraphWU', 'IT_KEY', 1)

%%% ¡prop!
A (result, cell) is the cell containing the multiplex weighted adjacency matrices of the multiplex weighted undirected graph.
%%%% ¡calculate!
A_list = cellfun(@(x) cell2mat(x.get('A')), ge.get('G_DICT').getItems, 'UniformOutput', false);
A = mean(cat(3, A_list{:}), 3);
value = {A};

%% ¡methods!
function n = layernumber(g)
    %LAYERNUMBER returns the number of layers in the graph.
    %
    % N = LAYERNUMBER(G) returns the number of layers in graph G.
    %
    % See also nodenumber.

    n = length(g.get('B'));
end


%% ¡tests!

%%% ¡test!
%%%% ¡name!
Constructor
%%%% ¡code!
ge = MultiplexGraphWUEnsemble();

dict = ge.get('G_DICT');
for i = 1:1:10
    g = MultiplexGraphWU( ...
        'ID', ['g ' int2str(i)], ...
        'B', {rand(10), rand(10)} ...
        );
    dict.add(g);   
end
ge.set('g_dict', dict);

assert(ge.get('G_DICT').length == 10, ...
    [BRAPH2.STR ':MultiplexGraphWUEnsemble:' BRAPH2.BUG_ERR], ...
    'MultiplexGraphWUEnsemble is not constructing well.')