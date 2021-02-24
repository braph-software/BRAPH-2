%% ¡header!
DistanceEnsemble < Distance (m, distance of a graph ensemble) is the distance of a graph ensemble.

%%% ¡description!
The distance of a graph is the shortest path 
between all pairs of nodes within a layer of the graph.

%%% ¡compatible_graphs!
GraphBDEnsemble
GraphBUEnsemble
GraphWDEnsemble
GraphWUEnsemble
MultigraphBUTEnsemble
MultigraphBUDEnsemble
MultiplexGraphBDEnsemble
MultiplexGraphBUEnsemble
MultiplexGraphWDEnsemble
MultiplexGraphWUEnsemble

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the ensemble-averaged degree.
%%%% ¡calculate!
ge = m.get('G'); % graph ensemble from measure class

distance_ensemble = cell(ge.layernumber(), 1);

distance_list = cellfun(@(x) x.getMeasure('Distance').get('M'), ge.get('G_DICT').getItems, 'UniformOutput', false);
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

known_distance = {[
    0   5   5   4   Inf
    5   0   2   1   Inf
    5   2   0   3   Inf
    4   1   3   0   Inf
    Inf Inf Inf Inf 0
    ]};

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

m_outside_g = DistanceEnsemble('G', ge);
assert(isequal(m_outside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':DistanceEnsemble:' BRAPH2.BUG_ERR], ...
    'DistanceEnsemble is not being calculated correctly for GraphWUEnsemble.')

m_inside_g = ge.getMeasure('DistanceEnsemble');
assert(isequal(m_inside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':DistanceEnsemble:' BRAPH2.BUG_ERR], ...
    'DistanceEnsemble is not being calculated correctly for GraphWUEnsemble.')

%%% ¡test!
%%%% ¡name!
MultigraphBUTEnsemble
%%%% ¡code!
B = [
    0   .2   .7
    .2   0   0
    .7   0   0
    ];

thresholds = [0 .5 1];

known_distance = {
    [
    0   1   1
    1   0   2
    1   2   0
    ]
    [
    0   Inf 1
    Inf 0   Inf
    1 Inf 0
    ]
    [
    0   Inf Inf
    Inf 0   Inf
    Inf Inf 0
    ]
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

m_outside_g = DistanceEnsemble('G', ge);
assert(isequal(m_outside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':DistanceEnsemble:' BRAPH2.BUG_ERR], ...
    'DistanceEnsemble is not being calculated correctly for MultigraphBUTEnsemble.')

m_inside_g = ge.getMeasure('DistanceEnsemble');
assert(isequal(m_inside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':DistanceEnsemble:' BRAPH2.BUG_ERR], ...
    'DistanceEnsemble is not being calculated correctly for MultigraphBUTEnsemble.')

%%% ¡test!
%%%% ¡name!
MultigraphBUDEnsemble
%%%% ¡code!
B = [
    0   .2   .7
    .2   0   .1
    .7  .1   0
    ];

densities = [0 33 67 100];

known_distance = {
    [
    0   Inf Inf
    Inf 0   Inf
    Inf Inf 0    
    ]
    [
    0   Inf 1
    Inf 0   Inf
    1   Inf 0
    ]
    [
    0   1   1
    1   0   2
    1   2   0
    ]
    [
    0   1   1
    1   0   1
    1   1   0
    ]
    };

ge = MultigraphBUDEnsemble('DENSITIES', densities);
dict = ge.get('G_DICT');
for i = 1:1:10
    g = MultigraphBUD( ...
        'ID', ['g ' int2str(i)], ...
        'DENSITIES', ge.get('DENSITIES'), ...
        'B', B ...
        );
    dict.add(g)
end
ge.set('g_dict', dict);

m_outside_g = DistanceEnsemble('G', ge);
assert(isequal(m_outside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':DistanceEnsemble:' BRAPH2.BUG_ERR], ...
    'DistanceEnsemble is not being calculated correctly for MultigraphBUDEnsemble.')

m_inside_g = ge.getMeasure('DistanceEnsemble');
assert(isequal(m_inside_g.get('M'), known_distance), ...
    [BRAPH2.STR ':DistanceEnsemble:' BRAPH2.BUG_ERR], ...
    'DistanceEnsemble is not being calculated correctly for MultigraphBUDEnsemble.')

%%% ¡test!
%%%% ¡name!
MultiplexGraphBUEnsemble
B11 = [
    0	1   1  0    0;
    1   0   0  0	0; 
    1   1   0   1   0;
    1	1   0   0   0;
    0   0   0   0   0;
    ];
B22 = [
    0   1   1   1   0; 
    1   0   0   0   0;
    1   1   0   1   0;
    1   1   0   0   0;
    0   0   0   0   0;
    ];
B = {B11 B22};

known_distance = {
    [
    0   1   1   1   Inf;
    1   0   1   1   Inf;
    1   1   0   1   Inf;
    1   1   1   0   Inf;
    Inf Inf Inf Inf 0;
    ]
    [
    0   1   1   1   Inf;
    1   0   1   1   Inf;
    1   1   0   1   Inf;
    1   1   1   0   Inf;
    Inf Inf Inf Inf 0;
    ]
    };

ge = MultiplexGraphBUEnsemble();
dict = ge.get('G_DICT');
for i = 1:1:10
    g = MultiplexBU( ...
        'ID', ['g ' int2str(i)], ...
        'B', B ...
        );
    dict.add(g)
end
ge.set('g_dict', dict);
distance = DistanceEnsemble('G', ge);

assert(isequal(distance.get('M'), known_distance), ...
    [BRAPH2.STR ':DistanceEnsemble:' BRAPH2.BUG_ERR], ...
    'DistanceEnsemble is not being calculated correctly for MultiplexGraphBUEnsemble.')

%%% ¡test!
%%%% ¡name!
MultiplexGraphBDEnsemble
B11 = [
    0	1   1   1   0;
    1   0   0   0	0; 
    1   1   0   1   0;
    1	1   0   0   0;
    0   0   0   0   0;
    ];
B22 = [
    0	1   1   1   0;
    1   0   0   0	0; 
    1   1   0   1   0;
    1	1   0   0   0;
    0   0   0   0   0;
    ];
B = {B11 B22};
known_distance = {
    [
    0   1   1   1   Inf;
    1   0   2   2   Inf;
    1   1   0   1   Inf;
    1   1   2   0   Inf;
    Inf Inf Inf Inf 0;
    ]
    [
    0   1   1   1   Inf;
    1   0   2   2   Inf;
    1   1   0   1   Inf;
    1   1   2   0   Inf;
    Inf Inf Inf Inf 0;
    ]
    };

ge = MultiplexGraphBDEnsemble();
dict = ge.get('G_DICT');
for i = 1:1:10
    g = MultiplexBD( ...
        'ID', ['g ' int2str(i)], ...
        'B', B ...
        );
    dict.add(g)
end
ge.set('g_dict', dict);
distance = DistanceEnsemble('G', ge);

assert(isequal(distance.get('M'), known_distance), ...
    [BRAPH2.STR ':DistanceEnsemble:' BRAPH2.BUG_ERR], ...
    'DistanceEnsemble is not being calculated correctly for MultiplexGraphBDEnsemble.')

%%% ¡test!
%%%% ¡name!
MultiplexGraphWUEnsemble
B11 = [
    0       .1  .2  .25  0;
    .125    0   0   0    0;
    .2      .5  0   .25  0;
    .125    10  0   0    0;
    0       0   0   0    0;
    ];
B22 = [
    0       .1  .2  .25  0;
    .125    0   0   0    0;
    .2      .5  0   .25  0;
    .125    10  0   0    0;
    0       0   0   0    0;
    ];
B = {B11 B22};

known_distance = {
    [
    0   5   5   4   Inf;
    5   0   2   1   Inf;
    5   2   0   3   Inf;
    4   1   3   0   Inf;
    Inf Inf Inf Inf 0;
	]
    [
    0   5   5   4   Inf;
    5   0   2   1   Inf;
    5   2   0   3   Inf;
    4   1   3   0   Inf;
    Inf Inf Inf Inf 0;
	]
    };

ge = MultiplexGraphWUEnsemble();
dict = ge.get('G_DICT');
for i = 1:1:10
    g = MultiplexWU( ...
        'ID', ['g ' int2str(i)], ...
        'B', B ...
        );
    dict.add(g)
end
ge.set('g_dict', dict);
distance = DistanceEnsemble('G', ge);

assert(isequal(distance.get('M'), known_distance), ...
    [BRAPH2.STR ':DistanceEnsemble:' BRAPH2.BUG_ERR], ...
    'DistanceEnsemble is not being calculated correctly for MultiplexGraphWUEnsemble.')

%%% ¡test!
%%%% ¡name!
MultiplexGraphWDEnsemble
B11 = [
    0       .1  .2  .25  0;
    .125    0   0   0    0;
    .2      .5  0   .25  0;
    .125    10  0   0    0;
    0       0   0   0    0;
    ];
B22 = [
    0       .1  .2  .25  0;
    .125    0   0   0    0;
    .2      .5  0   .25  0;
    .125    10  0   0    0;
    0       0   0   0    0;
    ];
B = {B11 B22};

known_distance = {
    [
    0   5   5   4   Inf;
    8   0   13  12  Inf;
    5   2   0   4   Inf;
    8   1   13  0   Inf;
    Inf Inf Inf Inf 0;
    ]
    [
    0   5   5   4   Inf;
    8   0   13  12  Inf;
    5   2   0   4   Inf;
    8   1   13  0   Inf;
    Inf Inf Inf Inf 0;
    ]
    };

ge = MultiplexGraphWDEnsemble();
dict = ge.get('G_DICT');
for i = 1:1:10
    g = MultiplexGraphWD( ...
        'ID', ['g ' int2str(i)], ...
        'B', B ...
        );
    dict.add(g)
end
ge.set('g_dict', dict);
distance = DistanceEnsemble('G', ge);

assert(isequal(distance.get('M'), known_distance), ...
    [BRAPH2.STR ':DistanceEnsemble:' BRAPH2.BUG_ERR], ...
    'DistanceEnsemble is not being calculated correctly for MultiplexGraphWDEnsemble.')