%% ¡header!
DiameterEnsemble < Diameter (m, diameter of a graph ensemble) is the diameter of a graph ensemble.

%%% ¡description!
The diameter is the maximum eccentricity among the vertice within a layer.

%%% ¡compatible_graphs!
GraphBUEnsemble
GraphWUEnsemble
MultigraphBUTEnsemble
MultigraphBUDEnsemble
MultiplexBUEnsemble
MultiplexWUEnsemble

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the ensemble-averaged degree.
%%%% ¡calculate!
ge = m.get('G'); % graph ensemble from measure class

distance_ensemble = cell(ge.layernumber(), 1);
eccentricity_rule =  m.get('rule');
distance_list = cellfun(@(x) x.getMeasure('Diameter', 'rule', eccentricity_rule).get('M'), ge.get('G_DICT').getItems, 'UniformOutput', false);
for li = 1:1:ge.layernumber()
    distance_li_list = cellfun(@(x) x{li}, distance_list, 'UniformOutput', false);
    distance_ensemble{li} = mean(cat(3, distance_li_list{:}), 3);
end

value = distance_ensemble;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphWUEnsemble
%%%% ¡code!
B = [
    0     .1    .2  .25  0
    .125  0     0   0    0
    .2    .5    0   .25  0
    .125  10    0   0    0
    0     0     0   0    0
    ];

known_diameter_subgraphs = {1};

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

m_outside_g = DiameterEnsemble('G', ge, 'rule', 'subgraphs');
assert(isequal(m_outside_g.get('M'), known_diameter_subgraphs), ...
    [BRAPH2.STR ':DiameterEnsemble:' BRAPH2.BUG_ERR], ...
    'DiameterEnsemble is not being calculated correctly for GraphWUEnsemble.')

m_inside_g = ge.getMeasure('DiameterEnsemble', 'rule', 'subgraphs');
assert(isequal(m_inside_g.get('M'), known_diameter_subgraphs), ...
    [BRAPH2.STR ':DiameterEnsemble:' BRAPH2.BUG_ERR], ...
    'DiameterEnsemble is not being calculated correctly for GraphWUEnsemble.')


%%% ¡test!
%%%% ¡name!
MultiplexBUEnsemble
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

known_diameter_default = {
                       inf
                       inf
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
diameter = DiameterEnsemble('G', ge);

assert(isequal(diameter.get('M'), known_diameter_default), ...
    [BRAPH2.STR ':DiameterEnsemble:' BRAPH2.BUG_ERR], ...
    'DiameterEnsemble is not being calculated correctly for MultiplexBUEnsemble.')

m_inside_g = ge.getMeasure('DiameterEnsemble', 'rule', 'all');
assert(isequal(m_inside_g.get('M'), known_diameter_default), ...
    [BRAPH2.STR ':DiameterEnsemble:' BRAPH2.BUG_ERR], ...
    'DiameterEnsemble is not being calculated correctly for MultiplexBUEnsemble.')
