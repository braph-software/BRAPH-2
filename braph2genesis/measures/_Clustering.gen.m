%% ¡header!
Clustering < Triangles (m, clustering) is the graph clustering.

%%% ¡description!
The clustering coefficient of a node is the fraction of triangles present
around a node. The clustering coefficient is calculated as the ratio between
the number of triangles present around a node and the maximum number of 
triangles that could possibly be formed around that node.

%%% ¡shape!
shape = Measure.NODAL;

%%% ¡scope!
scope = Measure.UNILAYER;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
GraphWU
GraphWD
GraphBU
GraphBD
MultiplexGraphWU
MultiplexGraphWD
MultiplexGraphBU
MultiplexGraphBD

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the clustering.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
L = g.layernumber();

clustering = cell(L, 1);
directionality_type =  g.getDirectionalityType(L);

triangles = calculateValue@Triangles(m, prop);

for li = 1:1:L
    Aii = A{li, li};
    if directionality_type == Graph.UNDIRECTED              
        degree = Degree('G', g).get('M');
        clustering_layer = 2 * triangles{li} ./ (degree{li} .* (degree{li} - 1));

    else %% directed graphs    
        in_degree = InDegree('G', g).get('M');
        out_degree = OutDegree('G', g).get('M');
        directed_triangles_rule = Triangles.RULES(m.get('rule'));
        switch lower(directed_triangles_rule{1})
            case {'all'}  % all rule
                clustering_layer = triangles{li} ./ ((out_degree{li} + in_degree{li}) .* (out_degree{li} + in_degree{li} - 1) - 2 * diag(Aii^2));
            case {'middleman'}  % middleman rule
                clustering_layer = triangles{li} ./ ((out_degree{li} .* in_degree{li}) - diag(Aii^2));
            case {'in'}  % in rule
                clustering_layer = triangles{li} ./ (in_degree{li} .* (in_degree{li} - 1));
            case {'out'}  % out rule
                clustering_layer = triangles{li} ./ (out_degree{li} .* (out_degree{li} - 1));
            otherwise  % {'cycle'}  % cycle rule
                clustering_layer = triangles{li} ./ ((out_degree{li} .* in_degree{li}) - diag(Aii^2));
        end
    end
    clustering_layer(isnan(clustering_layer)) = 0;  % Should return zeros, not NaN
    clustering(li) = {clustering_layer};
end

value = clustering;

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
clustering_BU = {[2/3 1 2/3 1]'};
g = GraphBU('B', B_BU);
clustering_1 = Clustering('G', g).get('M');
assert(isequal(clustering_1, clustering_BU), ...
    [BRAPH2.STR ':Clustering:' BRAPH2.BUG_ERR], ...
    'Clustering is not being calculated correctly for GraphBU')

%%% ¡test!
%%%% ¡name!
GraphBD
%%%% ¡code!
B_BD = [
    0 0 1; 
    1 0 0; 
    0 1 0 
    ];
clustering_BD_out = {[0 0 0]'};  % out rule
g = GraphBD('B', B_BD);
clustering_1 = Clustering('G', g, 'rule', 'out').get('M');
clustering_2 = clustering_BD_out;
assert(isequal(clustering_1, clustering_2), ...
    [BRAPH2.STR ':Clustering:' BRAPH2.BUG_ERR], ...
    'Clustering(''DirectedTrianglesRule'', ''out'') is not being calculated correctly for GraphBD')

%%% ¡test!
%%%% ¡name!
MultiplexGraphBU
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
                 [2/3 1 2/3 1]'
                 [2/3 1 2/3 1]'
                 };      

g = MultiplexGraphBU('B', B);
clustering = Clustering('G', g);

assert(isequal(clustering.get('M'), known_clustering), ...
    [BRAPH2.STR ':Clustering:' BRAPH2.BUG_ERR], ...
    'Clustering is not being calculated correctly for MultiplexGraphBU.')

%%% ¡test!
%%%% ¡name!
MultiplexGraphBD
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
                 [1 1 1]'
                 [1 1 1]'
                 }; 

g = MultiplexGraphBD('B', B);
clustering = Clustering('G', g, 'rule', 'cycle');

assert(isequal(clustering.get('M'), known_clustering), ...
    [BRAPH2.STR ':Clustering:' BRAPH2.BUG_ERR], ...
    'Clustering is not being calculated correctly for MultiplexGraphBD.')