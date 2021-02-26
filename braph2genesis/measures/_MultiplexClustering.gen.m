%% ¡header!
MultiplexClustering < MultiplexTriangles (m, multiplex clustering) is the graph multiplex clustering.

%%% ¡description!
The two-multiplex clustering coefficient of a node i is the fraction
of two-multiplex triangles (triangles which use edges from two different 
layers) with a vertex in node i and the number of one-triads centered in i.
      
%%% ¡seealso!
Measure

%%% ¡shape!
shape = Measure.NODAL;

%%% ¡scope!
scope = Measure.SUPERGLOBAL;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
MultiplexGraphWU
MultiplexGraphBU

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the multiplex clustering.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
A = g.get('A');  % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.) 
L = g.layernumber();

if L == 0
    value = {};
else
    N = g.nodenumber();            
    multiplex_triangles = calculateValue@MultiplexTriangles(m, prop);
    degree = Degree('G', g).get('M');

    multiplex_clustering_degree = zeros(N(1), 1);
    for i=1:1:L-1
        k1 = degree{i};
        for j=i+1:1:L
            k2 = degree{j};
            multiplex_clustering_degree = multiplex_clustering_degree + (k1 .* (k1 - 1) + k2 .* (k2 - 1));
        end
    end
    multiplex_clustering = multiplex_triangles{1}./ ((L-1)*multiplex_clustering_degree);
    multiplex_clustering(isnan(multiplex_clustering)) = 0;  % Should return zeros, not NaN
    value = {multiplex_clustering}; 
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
MultiplexGraphBU
%%%% ¡code!
B11 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 0;
      1 0 0 0
      ];
B22 = [
      0 1 1 1;
      1 0 0 0;
      1 0 0 0;
      1 0 0 0
      ];
B = {B11 B22};

known_multiplex_clustering = [2 2 2 0]'./ [12, 2, 2, 0]';
known_multiplex_clustering(isnan(known_multiplex_clustering)) = 0;
known_multiplex_clustering = {
                 known_multiplex_clustering
                 };      

g = MultiplexGraphBU('B', B);
multiplex_clustering = MultiplexClustering('G', g);

assert(isequal(multiplex_clustering.get('M'), known_multiplex_clustering), ...
    [BRAPH2.STR ':MultiplexClustering:' BRAPH2.BUG_ERR], ...
    'MultiplexClustering is not being calculated correctly for MultiplexGraphBU.')

%%% ¡test!
%%%% ¡name!
MultiplexGraphWU
%%%% ¡code!
B11 = [
      0   .2  1   1;
      .2  0   1  0;
      1   1  0   0;
      1   0   0   0
      ];
B22 = [
      0   .2  1  .7;
      .2  0   0  0;
      1   0   0  0;
      .7  0   0  0
      ];
B = {B11 B22};

known_multiplex_clustering = diag(A11.^(1/3)*A22.^(1/3)*A11.^(1/3) + A22.^(1/3)*A11.^(1/3)*A22.^(1/3)) ./ ([12, 2, 2, 0]');
known_multiplex_clustering(isnan(known_multiplex_clustering)) = 0;
known_multiplex_clustering = {
                 known_multiplex_clustering
                 };      

g = MultiplexGraphWU('B', B);
multiplex_clustering = MultiplexClustering('G', g);

assert(isequal(multiplex_clustering.getValue(), known_multiplex_clustering), ...
    [BRAPH2.STR ':MultiplexClustering:' BRAPH2.BUG_ERR], ...
    'MultiplexClustering is not being calculated correctly for MultiplexGraphWU.')