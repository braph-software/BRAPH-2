%% ¡header!
EccentricityEnsemble < Eccentricity (m, eccentricity of a graph ensemble) is the eccentricity of a graph ensemble.

%%% ¡description!
The eccentricity of a node is the number of edges connected to the node within a layer. 
Connection weights are ignored in calculations.

%%% ¡compatible_graphs!
GraphWUEnsemble
GraphBUEnsemble
MultigraphBUTEnsemble
MultigraphBUDEnsemble
MultiplexBUEnsemble
MultiplexWUEnsemble

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the ensemble-averaged eccentricity.
%%%% ¡calculate!
ge = m.get('G'); % graph ensemble from measure class

eccentricity_ensemble = cell(ge.layernumber(), 1);
eccentricity_rule = m.get('RULE');
eccentricity_list = cellfun(@(x) x.getMeasure('Eccentricity', 'rule', eccentricity_rule).get('M'), ge.get('G_DICT').getItems, 'UniformOutput', false);
for li = 1:1:ge.layernumber()
    eccentricity_li_list = cellfun(@(x) x{li}, eccentricity_list, 'UniformOutput', false);
    eccentricity_ensemble{li} = mean(cat(3, eccentricity_li_list{:}), 3);
end

value = eccentricity_ensemble;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBUEnsemble
%%%% ¡code!
B = [
    0     .1  .2  .25  0;
    .125  0   0   0    0;
    .2    .5  0   .25  0;
    .125  10  0   0    0;
    0     0   0   0    0
    ];

known_eccentricity_subgraphs = {[1 1 1 1 0]'};

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

m_outside_g = EccentricityEnsemble('G', ge, 'rule', 'subgraphs');
assert(isequal(m_outside_g.get('M'), known_eccentricity_subgraphs), ...
    [BRAPH2.STR ':EccentricityEnsemble:' BRAPH2.BUG_ERR], ...
    'EccentricityEnsemble is not being calculated correctly for GraphWUEnsemble.')

m_inside_g = ge.getMeasure('EccentricityEnsemble', 'rule', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_eccentricity_subgraphs), ...
    [BRAPH2.STR ':EccentricityEnsemble:' BRAPH2.BUG_ERR], ...
    'EccentricityEnsemble is not being calculated correctly for GraphWUEnsemble.')

%%% ¡test!
%%%% ¡name!
MultiplexWUEnsemble
%%%% ¡code!
B11 = [
      0     .1  .2  .25  0;
      .125  0   0   0    0;
      .2    .5  0   .25  0;
      .125  10  0   0    0;
      0     0   0   0    0
      ];
B22 = [
      0     .1  .2  .25  0;
      .125  0   0   0    0;
      .2    .5  0   .25  0;
      .125  10  0   0    0;
      0     0   0   0    0
      ];
B = {
    B11 B22
    };

known_eccentricity_default = {
                             [Inf Inf Inf Inf Inf]'
                             [Inf Inf Inf Inf Inf]'
                             };

ge = MultiplexWUEnsemble();
dict = ge.get('G_DICT');
for i = 1:1:10
    g = MultiplexWU( ...
        'ID', ['g ' int2str(i)], ...
        'B', B ...
        );
    dict.add(g)
end
ge.set('g_dict', dict);

m_outside_g = EccentricityEnsemble('G', ge, 'rule', 'all');
assert(isequal(m_outside_g.get('M'), known_eccentricity_default), ...
    [BRAPH2.STR ':EccentricityEnsemble:' BRAPH2.BUG_ERR], ...
    'EccentricityEnsemble is not being calculated correctly for GraphWUEnsemble.')

m_inside_g = ge.getMeasure('EccentricityEnsemble', 'rule', 'all');
assert(isequal(m_inside_g.get('M'), known_eccentricity_default), ...
    [BRAPH2.STR ':EccentricityEnsemble:' BRAPH2.BUG_ERR], ...
    'EccentricityEnsemble is not being calculated correctly for GraphWUEnsemble.')
