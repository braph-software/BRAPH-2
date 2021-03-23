%% ¡header!
InGlobalEfficiencyEnsemble < InGlobalEfficiency (m, in-global efficiency of a graph ensemble) is the in-global efficiency of a graph ensemble.

%%% ¡description!
The in-global efficiency is the average inverse shortest in-path length within each layer. 
It is inversely related to the characteristic in-path length.

%%% ¡compatible_graphs!
GraphWDEnsemble
GraphBDEnsemble
MultiplexWDEnsemble
MultiplexBDEnsemble

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the ensemble-averaged in-global efficiency.
%%%% ¡calculate!
ge = m.get('G'); % graph ensemble from measure class

in_global_efficiency_ensemble = cell(ge.layernumber(), 1);

in_global_efficiency_list = cellfun(@(x) x.getMeasure('InGlobalEfficiency').get('M'), ge.get('G_DICT').getItems, 'UniformOutput', false);
for li = 1:1:ge.layernumber()
    in_global_efficiency_li_list = cellfun(@(x) x{li}, in_global_efficiency_list, 'UniformOutput', false);
    in_global_efficiency_ensemble{li} = mean(cat(3, in_global_efficiency_li_list{:}), 3);
end

value = in_global_efficiency_ensemble;

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

known_in_global_efficiency = {[1/4 1/4 1/4 1/4 0]'};

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

in_global_efficiency = InGlobalEfficiencyEnsemble('G', ge);
assert(isequal(in_global_efficiency.get('M'), known_in_global_efficiency), ...
    [BRAPH2.STR ':InGlobalEfficiencyEnsemble:' BRAPH2.BUG_ERR], ...
    'InGlobalEfficiencyEnsemble is not being calculated correctly for GraphBDEnsemble.')

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


known_in_global_efficiency = {
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
in_global_efficiency = InGlobalEfficiencyEnsemble('G', ge);

assert(isequal(in_global_efficiency.get('M'), known_in_global_efficiency), ...
    [BRAPH2.STR ':InGlobalEfficiencyEnsemble:' BRAPH2.BUG_ERR], ...
    'InGlobalEfficiencyEnsemble is not being calculated correctly for MultiplexBDEnsemble.')