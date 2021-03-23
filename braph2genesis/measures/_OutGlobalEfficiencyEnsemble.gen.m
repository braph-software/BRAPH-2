%% ¡header!
OutGlobalEfficiencyEnsemble < OutGlobalEfficiency (m, out-global efficiency of a graph ensemble) is the out-global efficiency of a graph ensemble.

%%% ¡description!
The out-global efficiency is the average outverse shortest out-path length without each layer. 
It is outversely related to the characteristic out-path length.

%%% ¡compatible_graphs!
GraphWDEnsemble
GraphBDEnsemble
MultiplexWDEnsemble
MultiplexBDEnsemble

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the ensemble-averaged out-global efficiency.
%%%% ¡calculate!
ge = m.get('G'); % graph ensemble from measure class

out_global_efficiency_ensemble = cell(ge.layernumber(), 1);

out_global_efficiency_list = cellfun(@(x) x.getMeasure('OutGlobalEfficiency').get('M'), ge.get('G_DICT').getItems, 'UniformOutput', false);
for li = 1:1:ge.layernumber()
    out_global_efficiency_li_list = cellfun(@(x) x{li}, out_global_efficiency_list, 'UniformOutput', false);
    out_global_efficiency_ensemble{li} = mean(cat(3, out_global_efficiency_li_list{:}), 3);
end

value = out_global_efficiency_ensemble;

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

known_out_global_efficiency = {[1/4 1/4 1/4 1/4 0]'};

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

out_global_efficiency = OutGlobalEfficiencyEnsemble('G', ge);
assert(isequal(out_global_efficiency.get('M'), known_out_global_efficiency), ...
    [BRAPH2.STR ':OutGlobalEfficiencyEnsemble:' BRAPH2.BUG_ERR], ...
    'OutGlobalEfficiencyEnsemble is not being calculated correctly for GraphBDEnsemble.')

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


known_out_global_efficiency = {
                        [1/4 1/4 1/4 1/4 0]'
                        [1/4 1/4 1/4 1/4 0]'
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
out_global_efficiency = OutGlobalEfficiencyEnsemble('G', ge);

assert(isequal(out_global_efficiency.get('M'), known_out_global_efficiency), ...
    [BRAPH2.STR ':OutGlobalEfficiencyEnsemble:' BRAPH2.BUG_ERR], ...
    'OutGlobalEfficiencyEnsemble is not being calculated correctly for MultiplexBDEnsemble.')