%% ¡header!
OutPathLengthAvEnsemble < OutPathLengthAv (m, average out-path length of a graph ensemble) is the graph average out-path length of a graph ensemble.

%%% ¡description!
The average out-path length of a graph is the average of the sum of the
out-path lengths within each layer. 

%%% ¡compatible_graphs!
GraphWDEnsemble
GraphBDEnsemble
MultiplexWDEnsemble
MultiplexBDEnsemble

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the ensemble-averaged out-path length average.
%%%% ¡calculate!
ge = m.get('G'); % graph ensemble from measure class

out_path_length_av_ensemble = cell(ge.layernumber(), 1);

out_path_length_av_list = cellfun(@(x) x.getMeasure('OutPathLengthAv').get('M'), ge.get('G_DICT').getItems, 'UniformOutput', false);
for li = 1:1:ge.layernumber()
    out_path_length_av_li_list = cellfun(@(x) x{li}, out_path_length_av_list, 'UniformOutput', false);
    out_path_length_av_ensemble{li} = mean(cat(3, out_path_length_av_li_list{:}), 3);
end

value = out_path_length_av_ensemble;

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

known_out_path_length_av = {Inf};

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

out_path_length_av = OutPathLengthAvEnsemble('G', ge).get('M');
assert(isequal(round(cell2mat(out_path_length_av), 5), round(cell2mat(known_out_path_length_av), 5)), ...
    [BRAPH2.STR ':OutPathLengthAvEnsemble:' BRAPH2.BUG_ERR], ...
    'OutPathLengthAvEnsemble is not being calculated correctly for GraphBDEnsemble.')

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

known_out_path_length_av = {
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

out_path_length_av = OutPathLengthAvEnsemble('G', ge).get('M');
assert(isequal(round(cell2mat(out_path_length_av), 5), round(cell2mat(known_out_path_length_av), 5)), ...
    [BRAPH2.STR ':OutPathLengthAvEnsemble:' BRAPH2.BUG_ERR], ...
    'OutPathLengthAvEnsemble is not being calculated correctly for MultiplexBDEnsemble.')
