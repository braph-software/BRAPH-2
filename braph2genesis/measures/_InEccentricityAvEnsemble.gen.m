%% ¡header!
InEccentricityAvEnsemble < InEccentricityAv (m, average in-eccentricity of a graph ensemble) is the average in-eccentricity of a graph ensemble.

%%% ¡description!
The average in-eccentricity of a node is the sum of the nodal 
in-eccentricities divided by their number within a layer.

%%% ¡compatible_graphs!
GraphWDEnsemble
GraphBDEnsemble
MultiplexWDEnsemble
MultiplexBDEnsemble

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the ensemble-averaged in-eccentricity average.
%%%% ¡calculate!
ge = m.get('G'); % graph ensemble from measure class

in_eccentricity_av_ensemble = cell(ge.layernumber(), 1);
in_eccentricity_rule = m.get('RULE');
in_eccentricity_av_list = cellfun(@(x) x.getMeasure('InEccentricityAv', 'rule', in_eccentricity_rule).get('M'), ge.get('G_DICT').getItems, 'UniformOutput', false);
for li = 1:1:ge.layernumber()
    in_eccentricity_av_li_list = cellfun(@(x) x{li}, in_eccentricity_av_list, 'UniformOutput', false);
    in_eccentricity_av_ensemble{li} = mean(cat(3, in_eccentricity_av_li_list{:}), 3);
end

value = in_eccentricity_av_ensemble;

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

known_in_eccentricity_av_subgraphs = {mean([1 1 1 1 0])};

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

in_eccentricity_av_subgraphs = InEccentricityAvEnsemble('G', ge, 'rule', 'subgraphs').get('M');
assert(isequal(round(cell2mat(in_eccentricity_av_subgraphs), 5), round(cell2mat(known_in_eccentricity_av_subgraphs), 5)), ...
    [BRAPH2.STR ':InEccentricityAvEnsemble:' BRAPH2.BUG_ERR], ...
    'InEccentricityAvEnsemble is not being calculated correctly for GraphBDEnsemble.')

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

known_in_eccentricity_av_default = {
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

in_eccentricity_av_default = InEccentricityAvEnsemble('G', ge);
assert(isequal(in_eccentricity_av_default.get('M'), known_in_eccentricity_av_default), ...
    [BRAPH2.STR ':InEccentricityAvEnsemble:' BRAPH2.BUG_ERR], ...
    'InEccentricityAvEnsemble is not being calculated correctly for MultiplexWDEnsemble.')