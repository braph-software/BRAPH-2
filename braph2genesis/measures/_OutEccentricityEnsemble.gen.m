%% ¡header!
OutEccentricityEnsemble < OutEccentricity (m, out-eccentricity of a graph ensemble) is the out-eccentricity of a graph ensemble.

%%% ¡description!
The out-eccentricity of a node is the maximal shortest out-path length 
between a node and any other node within a layer.

%%% ¡compatible_graphs!
GraphWDEnsemble
GraphBDEnsemble
MultiplexWDEnsemble
MultiplexBDEnsemble

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the ensemble-averaged out-eccentricity.
%%%% ¡calculate!
ge = m.get('G'); % graph ensemble from measure class

out_eccentricity_ensemble = cell(ge.layernumber(), 1);
out_eccentricity_rule = m.get('RULE');
out_eccentricity_list = cellfun(@(x) x.getMeasure('OutEccentricity', 'rule', out_eccentricity_rule).get('M'), ge.get('G_DICT').getItems, 'UniformOutput', false);
for li = 1:1:ge.layernumber()
    out_eccentricity_li_list = cellfun(@(x) x{li}, out_eccentricity_list, 'UniformOutput', false);
    out_eccentricity_ensemble{li} = mean(cat(3, out_eccentricity_li_list{:}), 3);
end

value = out_eccentricity_ensemble;

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

known_out_eccentricity_subgraphs = {[1 1 1 1 0]'};

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

out_eccentricity_subgraphs = OutEccentricityEnsemble('G', ge, 'rule', 'subgraphs');
assert(isequal(out_eccentricity_subgraphs.get('M'), known_out_eccentricity_subgraphs), ...
    [BRAPH2.STR ':OutEccentricityEnsemble:' BRAPH2.BUG_ERR], ...
    'OutEccentricityEnsemble is not being calculated correctly for GraphBDEnsemble.')

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

known_out_eccentricity_default = {
                             [Inf Inf Inf Inf Inf]'
                             [Inf Inf Inf Inf Inf]'
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

out_eccentricity_default = OutEccentricityEnsemble('G', ge);
assert(isequal(out_eccentricity_default.get('M'), known_out_eccentricity_default), ...
    [BRAPH2.STR ':OutEccentricityEnsemble:' BRAPH2.BUG_ERR], ...
    'OutEccentricityEnsemble is not being calculated correctly for MultiplexWDEnsemble.')