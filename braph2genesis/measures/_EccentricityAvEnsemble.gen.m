%% ¡header!
EccentricityAvEnsemble < EccentricityAv (m, average eccentricity of a graph ensemble) is the average eccentricity of a graph ensemble.

%%% ¡description!
The average eccentricity of a graph is the sum of the nodal eccentricities divided by their number within a layer.

%%% ¡compatible_graphs!
GraphWUEnsemble
GraphBUEnsemble
MultigraphBUTEnsemble
MultigraphBUDEnsemble
MultiplexBUEnsemble
MultiplexWUEnsemble

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the ensemble-averaged  average eccentricity.
%%%% ¡calculate!
ge = m.get('G'); % graph ensemble from measure class

eccentricity_av_ensemble = cell(ge.layernumber(), 1);
eccentricity_rule = m.get('RULE');
eccentricity_av_list = cellfun(@(x) x.getMeasure('EccentricityAv', 'rule', eccentricity_rule).get('M'), ge.get('G_DICT').getItems, 'UniformOutput', false);
for li = 1:1:ge.layernumber()
    eccentricity_av_li_list = cellfun(@(x) x{li}, eccentricity_av_list, 'UniformOutput', false);
    eccentricity_av_ensemble{li} = mean(cat(3, eccentricity_av_li_list{:}), 3);
end

value = eccentricity_av_ensemble;

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

known_eccentricity_av_subgraphs = {mean([1 1 1 1 0]')};

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

m_outside_g = EccentricityAvEnsemble('G', ge, 'rule', 'subgraphs');
tol = 5 * eps(cell2mat(m_outside_g.get('M'))); % A very small value for comparing two floating-point numbers if they are close enough
assert(ismembertol(cell2mat(m_outside_g.get('M')), cell2mat(known_eccentricity_av_subgraphs), tol), ...
    [BRAPH2.STR ':EccentricityAvEnsemble:' BRAPH2.BUG_ERR], ...
    'EccentricityAvEnsemble is not being calculated correctly for GraphBUEnsemble.')

m_inside_g = ge.getMeasure('EccentricityAvEnsemble', 'rule', 'subgraphs');
tol = 5 * eps(cell2mat(m_outside_g.get('M'))); % A very small value for comparing two floating-point numbers if they are close enough
assert(ismembertol(cell2mat(m_inside_g.get('M')), cell2mat(known_eccentricity_av_subgraphs), tol), ...
    [BRAPH2.STR ':EccentricityAvEnsemble:' BRAPH2.BUG_ERR], ...
    'EccentricityAvEnsemble is not being calculated correctly for GraphBUEnsemble.')


%%% ¡test!
%%%% ¡name!
MultigraphBUTEnsemble
%%%% ¡code!
B = [
    0     .1  .2  .25  0;
    .125  0   0   0    0;
    .2    .5  0   .25  0;
    .125  10  0   0    0;
    0     0   0   0    0
    ];

thresholds = [0 1];
known_eccentricity_av_subgraphs = {
                                  mean([0 0 0 0 0]')
                                  mean([1 1 1 1 0]')
                                  };

ge = MultigraphBUTEnsemble('THRESHOLDS', thresholds);
dict = ge.get('G_DICT');
for i = 1:1:10
    g = MultigraphBUT( ...
        'ID', ['g ' int2str(i)], ...
        'THRESHOLDS', ge.get('THRESHOLDS'), ...
        'B', B ...
        );
    dict.add(g)
end
ge.set('g_dict', dict);


m_outside_g = EccentricityAvEnsemble('G', ge, 'rule', 'subgraphs');
tol = 5 * eps(cell2mat(m_outside_g.get('M'))); % A very small value for comparing two floating-point numbers if they are close enough
assert(all(ismembertol(cell2mat(m_outside_g.get('M')), cell2mat(known_eccentricity_av_subgraphs), tol(1))), ...
    [BRAPH2.STR ':EccentricityAvEnsemble:' BRAPH2.BUG_ERR], ...
    'EccentricityAvEnsemble is not being calculated correctly for MultigraphBUTEnsemble.')

m_inside_g = ge.getMeasure('EccentricityAvEnsemble', 'rule', 'subgraphs');
tol = 5 * eps(cell2mat(m_outside_g.get('M'))); % A very small value for comparing two floating-point numbers if they are close enough
assert(all(ismembertol(cell2mat(m_inside_g.get('M')), cell2mat(known_eccentricity_av_subgraphs), tol(1))), ...
    [BRAPH2.STR ':EccentricityAvEnsemble:' BRAPH2.BUG_ERR], ...
    'EccentricityAvEnsemble is not being calculated correctly for MultigraphBUTEnsemble.')


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
                             mean([Inf Inf Inf Inf Inf]')
                             mean([Inf Inf Inf Inf Inf]')
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

m_outside_g = EccentricityAvEnsemble('G', ge, 'rule', 'all');
assert(isequal(m_outside_g.get('M'), known_eccentricity_default), ...
    [BRAPH2.STR ':EccentricityAvEnsemble:' BRAPH2.BUG_ERR], ...
    'EccentricityAvEnsemble is not being calculated correctly for MultiplexWUEnsemble.')

m_inside_g = ge.getMeasure('EccentricityAvEnsemble', 'rule', 'all');
assert(isequal(m_inside_g.get('M'), known_eccentricity_default), ...
    [BRAPH2.STR ':EccentricityAvEnsemble:' BRAPH2.BUG_ERR], ...
    'EccentricityAvEnsemble is not being calculated correctly for MultiplexWUEnsemble.')
