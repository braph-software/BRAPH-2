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

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the clustering.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)

clustering = cell(g.layernumber(), 1);

triangles = cell2mat(calculateValue@Triangles(m, prop));

if isa(g, 'GraphBU') || isa(g, 'GraphWU')                
    degree = cell2mat(Degree('G', g).get('M'));
    
    clustering = 2 * triangles ./ (degree .* (degree - 1));
    
elseif isa(g, 'GraphBD') || isa(g, 'GraphWD')    
    
    in_degree = cell2mat(InDegree('G', g).get('M'));
    out_degree = cell2mat(OutDegree('G', g).get('M'));
    directed_triangles_rule = Triangles.RULES(m.get('rule'));
    switch lower(directed_triangles_rule{1})
        case {'all'}  % all rule
            clustering = triangles ./ ((out_degree + in_degree) .* (out_degree + in_degree - 1) - 2 * diag(A^2));
        case {'middleman'}  % middleman rule
            clustering = triangles ./ ((out_degree .* in_degree) - diag(A^2));
        case {'in'}  % in rule
            clustering = triangles ./ (in_degree .* (in_degree - 1));
        case {'out'}  % out rule
            clustering = triangles ./ (out_degree .* (out_degree - 1));
        otherwise  % {'cycle'}  % cycle rule
            clustering = triangles ./ ((out_degree .* in_degree) - diag(A^2));
    end
    clustering(isnan(clustering)) = 0;  % Should return zeros, not NaN  
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
clustering_BU = [2/3 1 2/3 1]';
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
clustering_BD_out = [0 0 0]';  % out rule
g = GraphBD('B', B_BD);
clustering_1 = Clustering('G', g, 'rule', find(contains(Triangles.RULES, 'out'))).get('M');
clustering_2 = clustering_BD_out;
assert(isequal(clustering_1, clustering_2), ...
    [BRAPH2.STR ':Clustering:' BRAPH2.BUG_ERR], ...
    'Clustering(''DirectedTrianglesRule'', ''out'') is not being calculated correctly for GraphBD')
