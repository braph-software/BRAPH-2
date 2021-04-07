%% ¡header!
InGlobalEfficiencyAvEnsemble < InGlobalEfficiencyAv (m, average in-global efficiency of a graph ensemble) is the graph average in-global efficiency of a graph ensemble.

%%% ¡description!
The average in-global efficiency is the average of the in-global efficiency
within each layer.

%%% ¡compatible_graphs!
GraphWDEnsemble
GraphBDEnsemble
MultiplexWDEnsemble
MultiplexBDEnsemble

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the ensemble-averaged in-global efficiency average.
%%%% ¡calculate!
ge = m.get('G'); % graph ensemble from measure class

in_global_efficiency_av_ensemble = cell(ge.layernumber(), 1);

in_global_efficiency_av_list = cellfun(@(x) x.getMeasure('InGlobalEfficiencyAv').get('M'), ge.get('G_DICT').getItems, 'UniformOutput', false);
for li = 1:1:ge.layernumber()
    in_global_efficiency_av_li_list = cellfun(@(x) x{li}, in_global_efficiency_av_list, 'UniformOutput', false);
    in_global_efficiency_av_ensemble{li} = mean(cat(3, in_global_efficiency_av_li_list{:}), 3);
end

value = in_global_efficiency_av_ensemble;

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

known_in_global_efficiency_av = {mean([1/4 1/4 1/4 1/4 0])};

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

in_global_efficiency_av = InGlobalEfficiencyAvEnsemble('G', ge).get('M');
assert(isequal(round(cell2mat(in_global_efficiency_av), 5), round(cell2mat(known_in_global_efficiency_av), 5)), ...
    [BRAPH2.STR ':InGlobalEfficiencyAvEnsemble:' BRAPH2.BUG_ERR], ...
    'InGlobalEfficiencyAvEnsemble is not being calculated correctly for GraphBDEnsemble.')

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


known_in_global_efficiency_av = {
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

in_global_efficiency_av = InGlobalEfficiencyAvEnsemble('G', ge).get('M');
assert(isequal(round(cell2mat(in_global_efficiency_av), 5), round(cell2mat(known_in_global_efficiency_av), 5)), ...
    [BRAPH2.STR ':InGlobalEfficiencyAvEnsemble:' BRAPH2.BUG_ERR], ...
    'InGlobalEfficiencyAvEnsemble is not being calculated correctly for MultiplexBDEnsemble.')