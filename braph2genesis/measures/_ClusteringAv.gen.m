%% ¡header!
ClusteringAv < Clustering (m, average clustering) is the graph average clustering.

%%% ¡description!
The average clustering of a graph is the average of the clustering 
coefficients of all nodes. Connection weights are ignored in calculations.

%%% ¡shape!
shape = Measure.GLOBAL;

%%% ¡scope!
scope = Measure.UNILAYER;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
GraphWU
GraphWD
GraphBU
GraphBD
MultigraphBUD
MultigraphBUT
MultiplexWU
MultiplexWD
MultiplexBU
MultiplexBUD
MultiplexBUT
MultiplexBD

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the average clustering.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
clustering  = calculateValue@Clustering(m, prop);

clustering_av = cell(g.layernumber(), 1);
for li = 1:1:length(clustering)
    clustering_av(li) = {mean(clustering{li})};
end

value = clustering_av;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBU
%%%% ¡code!
B_BU = [
    0 1 1 1; 
    1 0 1 0; 
    1 1 0 1; 
    1 0 1 0
    ];
clustering_BU = [2/3 1 2/3 1];
g = GraphBU('B', B_BU);
clustering_1 = ClusteringAv('G', g).get('M');
assert(isequal(clustering_1, {mean(clustering_BU)}), ...
    [BRAPH2.STR ':ClusteringAv:' BRAPH2.BUG_ERR], ...
    'ClusteringAv is not being calculated correctly for GraphBU')

%%% ¡test!
%%%% ¡name!
GraphBD
%%%% ¡code!
B_BD = [
    0 0 1; 
    1 0 0; 
    0 1 0 
    ];
clustering_BD_out = [0 0 0];  % out rule
g = GraphBD('B', B_BD);
clustering_1 = ClusteringAv('G', g, 'rule', 'out').get('M');
clustering_2 = {mean(clustering_BD_out)};
assert(isequal(clustering_1, clustering_2), ...
    [BRAPH2.STR ':ClusteringAv:' BRAPH2.BUG_ERR], ...
    'ClusteringAv(''Rule'', ''out'') is not being calculated correctly for GraphBD')

%%% ¡test!
%%%% ¡name!
MultigraphBUT
%%%% ¡code!
B = [
    0 1 1 1; 
    1 0 1 0; 
    1 1 0 1; 
    1 0 1 0
    ];

thresholds = [0 1];

known_clustering_av = {
    mean([2/3 1 2/3 1])
    0   
    };

g = MultigraphBUT('B', B, 'THRESHOLDS', thresholds);

clustering_av = ClusteringAv('G', g).get('M');
assert(isequal(clustering_av, known_clustering_av), ...
    [BRAPH2.STR ':ClusteringAv:' BRAPH2.BUG_ERR], ...
    'ClusteringAv is not being calculated correctly for MultigraphBUT')

%%% ¡test!
%%%% ¡name!
MultiplexBU
%%%% ¡code!
B11 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];
B22 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];
B = {B11 B22};

known_clustering_av = {
                 mean([2/3 1 2/3 1])
                 mean([2/3 1 2/3 1])
                 };      

g = MultiplexBU('B', B);
clustering_av = ClusteringAv('G', g);

assert(isequal(clustering_av.get('M'), known_clustering_av), ...
    [BRAPH2.STR ':ClusteringAv:' BRAPH2.BUG_ERR], ...
    'ClusteringAv is not being calculated correctly for MultiplexBU.')

%%% ¡test!
%%%% ¡name!
MultiplexBUT
%%%% ¡code!
B11 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];
B22 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];
B  = {B11 B22};

thresholds = [0 1];
known_clustering_av = {
                 mean([2/3 1 2/3 1])
                 mean([2/3 1 2/3 1])
                 0 
                 0 
                 };      

g = MultiplexBUT('B', B, 'THRESHOLDS', thresholds);
clustering_av = ClusteringAv('G', g);

assert(isequal(clustering_av.get('M'), known_clustering_av), ...
    [BRAPH2.STR ':ClusteringAv:' BRAPH2.BUG_ERR], ...
    'ClusteringAv is not being calculated correctly for MultiplexBUT.')