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

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the average clustering.
%%%% ¡calculate!

clustering  = calculateValue@Clustering(m, prop);
if iscell(clustering)
    clustering = cell2mat(clustering);
end
clustering_av = mean(clustering);
value = {clustering_av};

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
clustering_BU = [2/3 1 2/3 1]';
g = GraphBU('B', B_BU);
clustering_1 = ClusteringAv('G', g).get('M');
assert(isequal(clustering_1{1}, mean(clustering_BU)), ...
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
clustering_BD_out = [0 0 0]';  % out rule
g = GraphBD('B', B_BD);
clustering_1 = ClusteringAv('G', g, 'rule', find(contains(Triangles.RULES, 'out'))).get('M');
clustering_2 = mean(clustering_BD_out);
assert(isequal(clustering_1{1}, clustering_2), ...
    [BRAPH2.STR ':ClusteringAv:' BRAPH2.BUG_ERR], ...
    'ClusteringAv(''Rule'', ''out'') is not being calculated correctly for GraphBD')
