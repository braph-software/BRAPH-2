%% ¡header!
InPathLengthEnsemble < InPathLength (m, in-path length of a graph ensemble) is the in-path length of a graph ensemble.

%%% ¡description!
The in-path length is the average shortest in-path length of one
node to all other nodes within a layer.

%%% ¡compatible_graphs!
GraphWDEnsemble
GraphBDEnsemble
MultiplexWDEnsemble
MultiplexBDEnsemble

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the ensemble-averaged in-path length .
%%%% ¡calculate!
ge = m.get('G'); % graph ensemble from measure class

in_path_length_ensemble = cell(ge.layernumber(), 1);

in_path_length_list = cellfun(@(x) x.getMeasure('InPathLength', 'rule', m.get('rule')).get('M'), ge.get('G_DICT').getItems, 'UniformOutput', false);
for li = 1:1:ge.layernumber()
    in_path_length_li_list = cellfun(@(x) x{li}, in_path_length_list, 'UniformOutput', false);
    in_path_length_ensemble{li} = mean(cat(3, in_path_length_li_list{:}), 3);
end

value = in_path_length_ensemble;

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

known_in_path_length = {[Inf Inf Inf Inf Inf]'};

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

in_path_length = InPathLengthEnsemble('G', ge).get('M');
assert(isequal(round(cell2mat(in_path_length), 5), round(cell2mat(known_in_path_length), 5)), ...
    [BRAPH2.STR ':InPathLengthEnsemble:' BRAPH2.BUG_ERR], ...
    'InPathLengthEnsemble is not being calculated correctly for GraphBDEnsemble.')

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

known_in_path_length = {
                    [Inf Inf Inf Inf Inf]'
                    [Inf Inf Inf Inf Inf]'
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

in_path_length = InPathLengthEnsemble('G', ge).get('M');
assert(isequal(round(cell2mat(in_path_length), 5), round(cell2mat(known_in_path_length), 5)), ...
    [BRAPH2.STR ':InPathLengthEnsemble:' BRAPH2.BUG_ERR], ...
    'InPathLengthEnsemble is not being calculated correctly for MultiplexBDEnsemble.')