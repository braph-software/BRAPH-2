%% ¡header!
RadiusEnsemble < Radius (m, radius of a graph ensemble) is the radius of a graph ensemble.

%%% ¡description!
The radius is the minimum eccentricity among the vertice within a layer.
%%% ¡compatible_graphs!
GraphBUEnsemble
GraphWUEnsemble
MultigraphBUDEnsemble
MultigraphBUTEnsemble
MultiplexBUEnsemble
MultiplexWUEnsemble

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the ensemble-averaged radius.
%%%% ¡calculate!
ge = m.get('G'); % graph ensemble from measure class

radius_ensemble = cell(ge.layernumber(), 1);
eccentricity_rule = m.get('rule');
radius_list = cellfun(@(x) x.getMeasure('Radius', 'RULE', eccentricity_rule).get('M'), ge.get('G_DICT').getItems, 'UniformOutput', false);
for li = 1:1:ge.layernumber()
    radius_li_list = cellfun(@(x) x{li}, radius_list, 'UniformOutput', false);
    radius_ensemble{li} = mean(cat(3, radius_li_list{:}), 3);
end

value = radius_ensemble;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphWUEnsemble
%%%% ¡code!
B = [
    0     .1  .2  .25  0;
    .125  0   0   0    0;
    .2    .5  0   .25  0;
    .125  10  0   0    0;
    0     0   0   0    0
    ];

known_radius_subgraphs = {0};

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

radius = RadiusEnsemble('G', ge, 'rule', 'subgraphs');
assert(isequal(radius.get('M'), known_radius_subgraphs), ...
    [BRAPH2.STR ':RadiusEnsemble:' BRAPH2.BUG_ERR], ...
    'RadiusEnsemble is not being calculated correctly for GraphWUEnsemble.')

%%% ¡test!
%%%% ¡name!
MultigraphBUTEnsemble
%%%% ¡code!
B = [
    0  1  1  1  0;
    1  0  0  0  0;
    1  1  0  1  0;
    1  1  0  0  0;
    0  0  0  0  0
    ];

thresholds = [0 1];

known_radius_subgraphs = {
                          0
                          0};

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

radius = RadiusEnsemble('G', ge, 'rule', 'subgraphs');
assert(isequal(radius.get('M'), known_radius_subgraphs), ...
    [BRAPH2.STR ':RadiusEnsemble:' BRAPH2.BUG_ERR], ...
    'RadiusEnsemble is not being calculated correctly for MultigraphBUTEnsemble.')

%%% ¡test!
%%%% ¡name!
MultiplexBUEnsemble
%%%% ¡code!
B11 = [
      0  1  1  1  0;
      1  0  0  0  0;
      1  1  0  1  0;
      1  1  0  0  0;
      0  0  0  0  0
      ];
B22 = [
      0  1  1  1  0;
      1  0  0  0  0;
      1  1  0  1  0;
      1  1  0  0  0;
      0  0  0  0  0
      ];
B = {B11 B22};

known_radius_default = {
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
radius = RadiusEnsemble('G', ge);

assert(isequal(radius.get('M'), known_radius_default), ...
    [BRAPH2.STR ':RadiusEnsemble:' BRAPH2.BUG_ERR], ...
    'RadiusEnsemble is not being calculated correctly for MultiplexBUEnsemble.')