%% ¡header!
OutGlobalEfficiencyAvEnsemble < OutGlobalEfficiencyAv (m, average out-global efficiency of a graph ensemble) is the graph average out-global efficiency of a graph ensemble.

%%% ¡description!
The average out-global efficiency is the average of the out-global efficiency
without each layer.

%%% ¡compatible_graphs!
GraphWDEnsemble
GraphBDEnsemble
MultiplexWDEnsemble
MultiplexBDEnsemble

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the ensemble-averaged out-global efficiency average.
%%%% ¡calculate!
ge = m.get('G'); % graph ensemble from measure class

out_global_efficiency_av_ensemble = cell(ge.layernumber(), 1);

out_global_efficiency_av_list = cellfun(@(x) x.getMeasure('OutGlobalEfficiencyAv').get('M'), ge.get('G_DICT').getItems, 'UniformOutput', false);
for li = 1:1:ge.layernumber()
    out_global_efficiency_av_li_list = cellfun(@(x) x{li}, out_global_efficiency_av_list, 'UniformOutput', false);
    out_global_efficiency_av_ensemble{li} = mean(cat(3, out_global_efficiency_av_li_list{:}), 3);
end

value = out_global_efficiency_av_ensemble;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBDEnsemble
%%%% ¡code!
B = [
    0   .1  0   0   0
    .2  0   0   0   0
    0   0   0   .2  0
    0   0   .1  0   0
    0   0   0   0   0
    ];

known_out_global_efficiency_av = {mean([1/4 1/4 1/4 1/4 0])};

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

out_global_efficiency_av = OutGlobalEfficiencyAvEnsemble('G', ge).get('M');
assert(isequal(round(cell2mat(out_global_efficiency_av), 5), round(cell2mat(known_out_global_efficiency_av), 5)), ...
    [BRAPH2.STR ':OutGlobalEfficiencyAvEnsemble:' BRAPH2.BUG_ERR], ...
    'OutGlobalEfficiencyAvEnsemble is not being calculated correctly for GraphBDEnsemble.')

%%% ¡test!
%%%% ¡name!
MultiplexBDEnsemble
%%%% ¡code!
B11 = [
      0   .1  0   0   0
      .2  0   0   0   0
      0   0   0   .2  0
      0   0   .1  0   0
      0   0   0   0   0
      ];

B22 = [
      0   .1  0   0   0
      .2  0   0   0   0
      0   0   0   .2  0
      0   0   .1  0   0
      0   0   0   0   0
       ];
B = {B11 B22};


known_out_global_efficiency_av = {
                        mean([1/4 1/4 1/4 1/4 0])
                        mean([1/4 1/4 1/4 1/4 0])
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

out_global_efficiency_av = OutGlobalEfficiencyAvEnsemble('G', ge).get('M');
assert(isequal(round(cell2mat(out_global_efficiency_av), 5), round(cell2mat(known_out_global_efficiency_av), 5)), ...
    [BRAPH2.STR ':OutGlobalEfficiencyAvEnsemble:' BRAPH2.BUG_ERR], ...
    'OutGlobalEfficiencyAvEnsemble is not being calculated correctly for MultiplexBDEnsemble.')