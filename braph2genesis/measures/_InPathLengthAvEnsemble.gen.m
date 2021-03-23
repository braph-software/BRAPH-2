%% ¡header!
InPathLengthAvEnsemble < InPathLengthAv (m, average in-path length of a graph ensemble) is the graph average in-path length of a graph ensemble.

%%% ¡description!
The average in-path length of a graph is 
the average of the sum of the in-path lengths within each layer. 

%%% ¡compatible_graphs!
GraphWDEnsemble
GraphBDEnsemble
MultiplexWDEnsemble
MultiplexBDEnsemble

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the ensemble-averaged in-path length average.
%%%% ¡calculate!
ge = m.get('G'); % graph ensemble from measure class

in_path_length_av_ensemble = cell(ge.layernumber(), 1);

in_path_length_av_list = cellfun(@(x) x.getMeasure('InPathLengthAv').get('M'), ge.get('G_DICT').getItems, 'UniformOutput', false);
for li = 1:1:ge.layernumber()
    in_path_length_av_li_list = cellfun(@(x) x{li}, in_path_length_av_list, 'UniformOutput', false);
    in_path_length_av_ensemble{li} = mean(cat(3, in_path_length_av_li_list{:}), 3);
end

value = in_path_length_av_ensemble;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBDEnsemble
%%%% ¡code!
B = [
    0  1  1  1  0;
    1  0  0  0  0;
    1  1  0  1  0;
    1  1  0  0  0;
    0  0  0  0  0
    ];

known_in_path_length_av = {Inf};

ge = GraphBDEnsemble();
dict = ge.get('G_DICT');
for i = 1:1:10
    g = GraphBD( ...
        'ID', ['g ' int2str(i)], ...
        'B', B ...
        );
    dict.add(g)
end
ge.set('g_dict', dict);

in_path_length_av = InPathLengthAvEnsemble('G', ge).get('M');
assert(isequal(round(cell2mat(in_path_length_av), 5), round(cell2mat(known_in_path_length_av), 5)), ...
    [BRAPH2.STR ':InPathLengthAvEnsemble:' BRAPH2.BUG_ERR], ...
    'InPathLengthAvEnsemble is not being calculated correctly for GraphBDEnsemble.')

%%% ¡test!
%%%% ¡name!
MultiplexBDEnsemble
%%%% ¡code!
B11 = [
      0  1  1  1  0;
      1  0  0  0  0;
      1  1  0  1  0;
      1  1  0  0  0;
      0  0  0  0  0
      ];

B22 = [
      0  1  1  1  0;
      1  0  0  0  0;
      1  1  0  1  0;
      1  1  0  0  0;
      0  0  0  0  0
       ];
B = {B11 B22};

known_in_path_length_av = {
                    Inf
                    Inf
                    };
                
ge = MultiplexBDEnsemble();
dict = ge.get('G_DICT');
for i = 1:1:10
    g = MultiplexBD( ...
        'ID', ['g ' int2str(i)], ...
        'B', B ...
        );
    dict.add(g)
end
ge.set('g_dict', dict);

in_path_length_av = InPathLengthAvEnsemble('G', ge).get('M');
assert(isequal(round(cell2mat(in_path_length_av), 5), round(cell2mat(known_in_path_length_av), 5)), ...
    [BRAPH2.STR ':InPathLengthAvEnsemble:' BRAPH2.BUG_ERR], ...
    'InPathLengthAvEnsemble is not being calculated correctly for MultiplexBDEnsemble.')
