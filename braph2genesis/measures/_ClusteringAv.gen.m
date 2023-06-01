%% ¡header!
ClusteringAv < Clustering (m, clusteringav) is the graph clusteringav.

%%% ¡description!
The average clustering of a graph is the average of the clustering 
coefficients of all nodes. Connection weights are ignored in calculations.

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the clusteringav.
%%%% ¡default!
'ClusteringAv'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the clusteringav.
%%%% ¡default!
'The average clustering of a graph is the average of the clustering coefficients of all nodes. Connection weights are ignored in calculations.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the clusteringav.

%%% ¡prop!
ID (data, string) is a few-letter code of the clusteringav.
%%%% ¡default!
'ClusteringAv ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the clusteringav.
%%%% ¡default!
'ClusteringAv label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the clusteringav.
%%%% ¡default!
'ClusteringAv notes'

%%% ¡prop!
SHAPE (constant, scalar) is the measure shape __Measure.GLOBAL__.
%%%% ¡default!
Measure.GLOBAL

%%% ¡prop!
SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.
%%%% ¡default!
Measure.UNILAYER

%%% ¡prop!
PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.
%%%% ¡default!
Measure.NONPARAMETRIC

%%% ¡prop!
COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
%%%% ¡default!
{'GraphWU' 'GraphWD' 'GraphBU' 'GraphBD' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexWU' 'MultiplexWD' 'MultiplexBU' 'MultiplexBUD' 'MultiplexBUT' 'MultiplexBD'}

%%% ¡prop!
M (result, cell) is the clusteringav.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
clustering  = calculateValue@Clustering(m, prop);
layerNumber = g.get('LAYERNUMBER');
clustering_av = cell(layerNumber, 1);
parfor li = 1:1:length(clustering)
    clustering_av(li) = {mean(clustering{li})};
end

value = clustering_av;

%% ¡tests!

%%% ¡excluded_props!
[ClusteringAv.PFM]

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
clustering_BU = {mean([2/3 1 2/3 1]')};
g = GraphBU('B', B_BU);
m_outside_g = ClusteringAv('G', g);
assert(isequal(m_outside_g.get('M'), clustering_BU), ...
    [BRAPH2.STR ':ClusteringAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'ClusteringAv');
assert(isequal(m_inside_g.get('M'), clustering_BU), ...
    [BRAPH2.STR ':ClusteringAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])


%%% ¡test!
%%%% ¡name!
GraphBD
%%%% ¡code!
B_BD = [
    0 0 1; 
    1 0 0; 
    0 1 0 
    ];
clustering_BD_out = {mean([0 0 0]')};  % out rule

g = GraphBD('B', B_BD);
m_outside_g = ClusteringAv('G', g, 'RULE', 'out');
assert(isequal(m_outside_g.get('M'), clustering_BD_out), ...
    [BRAPH2.STR ':ClusteringAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'ClusteringAv');
m_inside_g.set('RULE', 'out');
assert(isequal(m_inside_g.get('M'), clustering_BD_out), ...
    [BRAPH2.STR ':ClusteringAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

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

known_clustering = {
     mean([2/3 1 2/3 1])
    0
    };

g = MultigraphBUT('B', B, 'THRESHOLDS', thresholds);

m_outside_g = ClusteringAv('G', g);
assert(isequal(m_outside_g.get('M'), known_clustering), ...
    [BRAPH2.STR ':ClusteringAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'ClusteringAv');
assert(isequal(m_inside_g.get('M'), known_clustering), ...
    [BRAPH2.STR ':ClusteringAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

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
B  = {B11 B22};

known_clustering = {
                 mean([2/3 1 2/3 1])
                 mean([2/3 1 2/3 1])
                 };      

g = MultiplexBU('B', B);
m_outside_g = ClusteringAv('G', g);
assert(isequal(m_outside_g.get('M'), known_clustering), ...
    [BRAPH2.STR ':ClusteringAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'ClusteringAv');
assert(isequal(m_inside_g.get('M'), known_clustering), ...
    [BRAPH2.STR ':ClusteringAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

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
known_clustering = {
                 mean([2/3 1 2/3 1])
                 mean([2/3 1 2/3 1])
                 0 
                 0
                 };      

g = MultiplexBUT('B', B, 'THRESHOLDS', thresholds);
m_outside_g = ClusteringAv('G', g);
assert(isequal(m_outside_g.get('M'), known_clustering), ...
    [BRAPH2.STR ':ClusteringAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'ClusteringAv');
assert(isequal(m_inside_g.get('M'), known_clustering), ...
    [BRAPH2.STR ':ClusteringAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBD
%%%% ¡code!
B11 = [
      0 0 1; 
      1 0 0; 
      0 1 0 
      ];
B22 = [
      0 0 1; 
      1 0 0; 
      0 1 0 
      ];
B = {B11 B22};

% cycle rule - default
known_clustering = {
                 mean([1 1 1])
                 mean([1 1 1])
                 }; 

g = MultiplexBD('B', B);
m_outside_g = ClusteringAv('G', g, 'RULE', 'cycle');
assert(isequal(m_outside_g.get('M'), known_clustering), ...
    [BRAPH2.STR ':ClusteringAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'ClusteringAv');
m_inside_g.set('RULE', 'cycle');
assert(isequal(m_inside_g.get('M'), known_clustering), ...
    [BRAPH2.STR ':ClusteringAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
