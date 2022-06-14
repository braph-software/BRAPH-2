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
MultiplexWU
MultiplexWUD
MultiplexBU
MultiplexBUD
MultiplexBUT

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the multiplex clustering.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
A = g.get('A');  % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.) 
[l, ls] = g.layernumber();

if l == 0
    value = {};
else
    N = g.nodenumber();            
    multiplex_triangles = calculateValue@MultiplexTriangles(m, prop);
    degree = Degree('G', g).get('M');
    
    multiplex_clustering = cell(length(ls), 1);
    count = 1;
    for p = 1:1:length(ls)
        multiplex_clustering_degree = zeros(N(1), 1);
        for i = count:1:ls(p) + count - 2
            k1 = degree{i};
            for j=i+1:1:ls(p)
                k2 = degree{j};
                multiplex_clustering_degree = multiplex_clustering_degree + (k1 .* (k1 - 1) + k2 .* (k2 - 1));
            end
        end
        multiplex_clustering_partition = multiplex_triangles{p}./ ((ls(p)-1)*multiplex_clustering_degree);
        multiplex_clustering_partition(isnan(multiplex_clustering_partition)) = 0;  % Should return zeros, not NaN
        count = count + ls(p);
        multiplex_clustering(p) = {multiplex_clustering_partition};
    end
    value = multiplex_clustering; 
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
MultiplexBU
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

g = MultiplexBU('B', B);
multiplex_clustering = MultiplexClustering('G', g);

assert(isequal(multiplex_clustering.get('M'), known_multiplex_clustering), ...
    [BRAPH2.STR ':MultiplexClustering:' BRAPH2.BUG_ERR], ...
    'MultiplexClustering is not being calculated correctly for MultiplexBU.')

%%% ¡test!
%%%% ¡name!
MultiplexBUT
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
                 [0 0 0 0]'
                 };      

g = MultiplexBUT('B', B, 'THRESHOLDS', [0 1]);
multiplex_clustering = MultiplexClustering('G', g);

assert(isequal(multiplex_clustering.get('M'), known_multiplex_clustering), ...
    [BRAPH2.STR ':MultiplexClustering:' BRAPH2.BUG_ERR], ...
    'MultiplexClustering is not being calculated correctly for MultiplexBUT.')

%%% ¡test!
%%%% ¡name!
MultiplexWU
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

known_multiplex_clustering = diag(B11.^(1/3)*B22.^(1/3)*B11.^(1/3) + B22.^(1/3)*B11.^(1/3)*B22.^(1/3)) ./ ([12, 2, 2, 0]');
known_multiplex_clustering(isnan(known_multiplex_clustering)) = 0;
known_multiplex_clustering = {
                 known_multiplex_clustering
                 };      

g = MultiplexWU('B', B);
multiplex_clustering = MultiplexClustering('G', g);

assert(isequal(multiplex_clustering.get('M'), known_multiplex_clustering), ...
    [BRAPH2.STR ':MultiplexClustering:' BRAPH2.BUG_ERR], ...
    'MultiplexClustering is not being calculated correctly for MultiplexWU.')