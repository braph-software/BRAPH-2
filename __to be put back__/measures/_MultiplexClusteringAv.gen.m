%% ¡header!
MultiplexClusteringAv < MultiplexClustering (m, average multiplex clustering) is the graph average multiplex clustering.

%%% ¡description!
The two-multiplex clustering coefficient of a node i is the fraction
of two-multiplex triangles (triangles which use edges from two different 
layers) with a vertex in node i and the number of one-triads centered in i.
      
%%% ¡seealso!
Measure

%%% ¡shape!
shape = Measure.GLOBAL;

%%% ¡scope!
scope = Measure.SUPERGLOBAL;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
MultiplexWU
MultiplexBU
MultiplexBUD
MultiplexBUT

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the average multiplex clustering.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
[l, ls] = g.layernumber();

if l == 0
    value = {};
else
    multiplex_clustering = calculateValue@MultiplexClustering(m, prop);
    multiplex_clustering_av = cell(length(ls), 1);

    for i=1:length(ls)
        multiplex_clustering_av(i) = {mean(multiplex_clustering{i})};
    end
    value = multiplex_clustering_av;
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

known_multiplex_clustering = [2 2 2 0]./ [12, 2, 2, 0];
known_multiplex_clustering(isnan(known_multiplex_clustering)) = 0;
known_multiplex_clustering_av = {
                 mean(known_multiplex_clustering)
                 };      

g = MultiplexBU('B', B);
multiplex_clustering_av = MultiplexClusteringAv('G', g);

assert(isequal(multiplex_clustering_av.get('M'), known_multiplex_clustering_av), ...
    [BRAPH2.STR ':MultiplexClusteringAv:' BRAPH2.BUG_ERR], ...
    'MultiplexClusteringAv is not being calculated correctly for MultiplexBU.')

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
known_multiplex_clustering_av = {
                 mean(known_multiplex_clustering)
                 0
                 };      

g = MultiplexBUT('B', B, 'THRESHOLDS', [0 1]);
multiplex_clustering_av = MultiplexClusteringAv('G', g);

assert(isequal(multiplex_clustering_av.get('M'), known_multiplex_clustering_av), ...
    [BRAPH2.STR ':MultiplexClusteringAv:' BRAPH2.BUG_ERR], ...
    'MultiplexClusteringAv is not being calculated correctly for MultiplexBUT.')

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
known_multiplex_clustering_av = {
                 mean(known_multiplex_clustering)
                 };  

g = MultiplexWU('B', B);
multiplex_clustering_av = MultiplexClusteringAv('G', g);

assert(isequal(multiplex_clustering_av.get('M'), known_multiplex_clustering_av), ...
    [BRAPH2.STR ':MultiplexClusteringAv:' BRAPH2.BUG_ERR], ...
    'MultiplexClusteringAv is not being calculated correctly for MultiplexWU.')