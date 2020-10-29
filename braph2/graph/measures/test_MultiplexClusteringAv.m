% test MultiplexClusteringAv

%% Test 1: MultiplexGraphBU
A11 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 0;
      1 0 0 0
      ];
A12 = eye(4);
A21 = eye(4);
A22 = [
      0 1 1 1;
      1 0 0 0;
      1 0 0 0;
      1 0 0 0
      ];
A = {
    A11     A12
    A21     A22
    };

known_multiplex_clustering = [2 2 2 0]./ [12, 2, 2, 0];
known_multiplex_clustering(isnan(known_multiplex_clustering)) = 0;
known_multiplex_clustering_av = {
                 mean(known_multiplex_clustering)
                 };      

g = MultiplexGraphBU(A);
multiplex_clustering_av = MultiplexClusteringAv(g);

assert(isequal(multiplex_clustering_av.getValue(), known_multiplex_clustering_av), ...
    [BRAPH2.STR ':MultiplexClusteringAv:' BRAPH2.BUG_ERR], ...
    'MultiplexClusteringAv is not being calculated correctly for MultiplexGraphBU.')

%% Test 2: MultiplexGraphWU
A11 = [
      0   .2  1   1;
      .2  0   1  0;
      1   1  0   0;
      1   0   0   0
      ];
A12 = eye(4);
A21 = eye(4);
A22 = [
      0   .2  1  .7;
      .2  0   0  0;
      1   0   0  0;
      .7  0   0  0
      ];
A = {
    A11     A12
    A21     A22
    };

known_multiplex_clustering = diag(A11.^(1/3)*A22.^(1/3)*A11.^(1/3) + A22.^(1/3)*A11.^(1/3)*A22.^(1/3)) ./ ([12, 2, 2, 0]');
known_multiplex_clustering(isnan(known_multiplex_clustering)) = 0;
known_multiplex_clustering_av = {
                 mean(known_multiplex_clustering)
                 };  

g = MultiplexGraphWU(A);
multiplex_clustering_av = MultiplexClusteringAv(g);

assert(isequal(multiplex_clustering_av.getValue(), known_multiplex_clustering_av), ...
    [BRAPH2.STR ':MultiplexClusteringAv:' BRAPH2.BUG_ERR], ...
    'MultiplexClusteringAv is not being calculated correctly for MultiplexGraphWU.')