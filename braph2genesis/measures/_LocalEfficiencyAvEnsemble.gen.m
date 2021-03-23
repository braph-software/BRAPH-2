%% ¡header!
LocalEfficiencyAvEnsemble < LocalEfficiencyAv (m, average local efficiency of a graph ensemble) is the average local efficiency of a graph ensemble.

%%% ¡description!
The average local efficiency is the average of all the local efficiencies
within each layer.
%%% ¡compatible_graphs!
GraphWUEnsemble
MultigraphBUDEnsemble
MultigraphBUTEnsemble
MultiplexBUEnsemble
MultiplexWUEnsemble

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the ensemble-averaged local efficiency average.
%%%% ¡calculate!
ge = m.get('G'); % graph ensemble from measure class

local_efficiency_av_ensemble = cell(ge.layernumber(), 1);

local_efficiency_av_list = cellfun(@(x) x.getMeasure('LocalEfficiencyAv').get('M'), ge.get('G_DICT').getItems, 'UniformOutput', false);
for li = 1:1:ge.layernumber()
    local_efficiency_av_li_list = cellfun(@(x) x{li}, local_efficiency_av_list, 'UniformOutput', false);
    local_efficiency_av_ensemble{li} = mean(cat(3, local_efficiency_av_li_list{:}), 3);
end

value = local_efficiency_av_ensemble;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBUEnsemble
%%%% ¡code!
B = [
    0  1  1  1
    1  0  1  0
    1  1  0  1
    1  0  1  0
    ];

known_local_efficiency_av = {mean([5/6 1 5/6 1])};

ge = GraphBUEnsemble();
dict = ge.get('G_DICT');
for i = 1:1:10
    g = GraphBU( ...
        'ID', ['g ' int2str(i)], ...
        'B', B ...
        );
    dict.add(g)
end
ge.set('g_dict', dict);

local_efficiency_av = LocalEfficiencyAvEnsemble('G', ge).get('M');
assert(isequal(round(cell2mat(local_efficiency_av), 5), round(cell2mat(known_local_efficiency_av), 5)), ...
    [BRAPH2.STR ':LocalEfficiencyAvEnsemble:' BRAPH2.BUG_ERR], ...
    'LocalEfficiencyAvEnsemble is not being calculated correctly for GraphBUEnsemble.')

%%% ¡test!
%%%% ¡name!
GraphWUEnsemble
%%%% ¡code!
B = [
    0   .2  .2  .1
    .2  0   .3  0
    .2  .3  0   .3
    .1  0   .3  0
    ];

known_local_efficiency_av = {mean([1/4 1/5 .1222 1/5])};

ge = GraphWUEnsemble();
dict = ge.get('G_DICT');
for i = 1:1:10
    g = GraphWU( ...
        'ID', ['g ' int2str(i)], ...
        'B', B ...
        );
    dict.add(g)
end
ge.set('g_dict', dict);

local_efficiency_av = LocalEfficiencyAvEnsemble('G', ge).get('M');
assert(isequal(round(cell2mat(local_efficiency_av), 4), round(cell2mat(known_local_efficiency_av), 4)), ...
    [BRAPH2.STR ':LocalEfficiencyAvEnsemble:' BRAPH2.BUG_ERR], ...
    'LocalEfficiencyAvEnsemble is not being calculated correctly for GraphWUEnsemble.')

%%% ¡test!
%%%% ¡name!
MultiplexBUEnsemble
%%%% ¡code!
B11 = [
       0  1  1  1
       1  0  1  0
       1  1  0  1
       1  0  1  0
      ];

B22 = [
       0  1  1  1
       1  0  1  0
       1  1  0  1
       1  0  1  0
      ];
B = {B11 B22};

known_local_efficiency_av = {
                         mean([5/6 1 5/6 1])
                         mean([5/6 1 5/6 1])
                         };

ge = MultiplexBUEnsemble();
dict = ge.get('G_DICT');
for i = 1:1:10
    g = MultiplexBU( ...
        'ID', ['g ' int2str(i)], ...
        'B', B ...
        );
    dict.add(g)
end
ge.set('g_dict', dict);

local_efficiency_av = LocalEfficiencyAvEnsemble('G', ge).get('M');
assert(isequal(round(cell2mat(local_efficiency_av), 5), round(cell2mat(known_local_efficiency_av), 5)), ...
    [BRAPH2.STR ':LocalEfficiencyAvEnsemble:' BRAPH2.BUG_ERR], ...
    'LocalEfficiencyAvEnsemble is not being calculated correctly for MultiplexBUEnsemble.')