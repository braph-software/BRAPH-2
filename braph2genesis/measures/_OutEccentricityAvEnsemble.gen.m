%% ¡header!
OutEccentricityAvEnsemble < OutEccentricityAv (m, average out-eccentricity of a graph ensemble) is the average out-eccentricity of a graph ensemble.

%%% ¡description!
The average out-eccentricity of a node is the sum of the nodal 
out-eccentricities divided by their number within a layer.

%%% ¡compatible_graphs!
GraphWDEnsemble
GraphBDEnsemble
MultiplexWDEnsemble
MultiplexBDEnsemble

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the ensemble-averaged out-eccentricity average.
%%%% ¡calculate!
ge = m.get('G'); % graph ensemble from measure class

out_eccentricity_av_ensemble = cell(ge.layernumber(), 1);
out_eccentricity_rule = m.get('RULE');
out_eccentricity_av_list = cellfun(@(x) x.getMeasure('OutEccentricityAv', 'rule', out_eccentricity_rule).get('M'), ge.get('G_DICT').getItems, 'UniformOutput', false);
for li = 1:1:ge.layernumber()
    out_eccentricity_av_li_list = cellfun(@(x) x{li}, out_eccentricity_av_list, 'UniformOutput', false);
    out_eccentricity_av_ensemble{li} = mean(cat(3, out_eccentricity_av_li_list{:}), 3);
end

value = out_eccentricity_av_ensemble;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBDEnsemble
%%%% ¡code!
B = [
    0   .1  0   0   0
    .2   0  0   0   0
    0    0  0  .2   0
    0    0 .1   0   0
    0    0  0   0   0
    ];

known_out_eccentricity_subgraphs = {mean([1 1 1 1 0])};

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

out_eccentricity_subgraphs = OutEccentricityAvEnsemble('G', ge, 'rule', 'subgraphs').get('M');
assert(isequal(round(cell2mat(out_eccentricity_subgraphs), 5), round(cell2mat(known_out_eccentricity_subgraphs), 5)), ...
    [BRAPH2.STR ':OutEccentricityAvEnsemble:' BRAPH2.BUG_ERR], ...
    'OutEccentricityAvEnsemble is not being calculated correctly for GraphBDEnsemble.')

%%% ¡test!
%%%% ¡name!
MultiplexWDEnsemble
%%%% ¡code!
B11 = [
    0   .1  0   0   0
    .2   0  0   0   0
    0    0  0  .2   0
    0    0 .1   0   0
    0    0  0   0   0
      ];
B22 = [
    0   .1  0   0   0
    .2   0  0   0   0
    0    0  0  .2   0
    0    0 .1   0   0
    0    0  0   0   0
      ];
B = {B11 B22};

known_out_eccentricity_av_default = {
                             Inf
                             Inf
                             };

ge = MultiplexWDEnsemble();
dict = ge.get('G_DICT');
for i = 1:1:10
    g = MultiplexWD( ...
        'ID', ['g ' int2str(i)], ...
        'B', B ...
        );
    dict.add(g)
end
ge.set('g_dict', dict);

out_eccentricity_av_default = OutEccentricityAvEnsemble('G', ge);
assert(isequal(out_eccentricity_av_default.get('M'), known_out_eccentricity_av_default), ...
    [BRAPH2.STR ':OutEccentricityAvEnsemble:' BRAPH2.BUG_ERR], ...
    'OutEccentricityAvEnsemble is not being calculated correctly for MultiplexWDEnsemble.')