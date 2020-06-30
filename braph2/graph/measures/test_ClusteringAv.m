% test ClusteringAv

%% Test 1: GraphBU
A = [
    0 1 1 1; 
    1 0 1 0; 
    1 1 0 1; 
    1 0 1 0
    ];

known_clustering_av = {mean([2/3 1 2/3 1])};

g = GraphBU(A);
clustering_av = ClusteringAv(g);

assert(isequal(clustering_av.getValue(), known_clustering_av), ...
    [BRAPH2.STR ':ClusteringAv:' BRAPH2.BUG_ERR], ...
    'ClusteringAv is not being calculated correctly for GraphBU.')

%% Test 2: GraphBD
A = [
    0 0 1; 
    1 0 0; 
    0 1 0 
    ];

% cycle rule - default
known_clustering_av_cycle = {1};

g = GraphBD(A);
clustering_av = ClusteringAv(g);

assert(isequal(clustering_av.getValue(), known_clustering_default_cycle), ...
    [BRAPH2.STR ':ClusteringAv:' BRAPH2.BUG_ERR], ...
    'ClusteringAv is not being calculated correctly for GraphBD.')

% in rule 
known_clustering_av_in = {0};

g = GraphBD(A);
clustering_av = ClusteringAv(g, 'DirectedTrianglesRule', 'in');

assert(isequal(clustering_av.getValue(), known_clustering_av_in), ...
    [BRAPH2.STR ':ClusteringAv:' BRAPH2.BUG_ERR], ...
    'ClusteringAv is not being calculated correctly for GraphBD.')

% out rule 
known_clustering_av_out = {0};

g = GraphBD(A);
clustering_av = ClusteringAv(g, 'DirectedTrianglesRule', 'out');

assert(isequal(clustering_av.getValue(), known_clustering_av_out), ...
    [BRAPH2.STR ':ClusteringAv:' BRAPH2.BUG_ERR], ...
    'ClusteringAv is not being calculated correctly for GraphBD.')

% middleman rule
known_clustering_av_middleman = {0};

g = GraphBD(A);
clustering_av = ClusteringAv(g, 'DirectedTrianglesRule', 'middleman');

assert(isequal(clustering_av.getValue(), known_clustering_av_middleman), ...
    [BRAPH2.STR ':ClusteringAv:' BRAPH2.BUG_ERR], ...
    'ClusteringAv is not being calculated correctly for GraphBD.')

% all rule 
known_clustering_av_all = {1/2};

g = GraphBD(A);
clustering_av = ClusteringAv(g, 'DirectedTrianglesRule', 'all');

assert(isequal(clustering_av.getValue(), known_clustering_av_all), ...
    [BRAPH2.STR ':ClusteringAv:' BRAPH2.BUG_ERR], ...
    'ClusteringAv is not being calculated correctly for GraphBD.')

%% Test 3: MultiplexGraphBU
A11 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];
A12 = eye(4);
A21 = eye(4);
A22 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];
A = {
    A11     A12
    A21     A22
    };

known_clustering_av = {
                 mean([2/3 1 2/3 1])
                 mean([2/3 1 2/3 1])
                 };      

g = MultiplexGraphBU(A);
clustering_av = ClusteringAv(g);

assert(isequal(clustering_av.getValue(), known_clustering_av), ...
    [BRAPH2.STR ':ClusteringAv:' BRAPH2.BUG_ERR], ...
    'ClusteringAv is not being calculated correctly for MultiplexGraphBU.')

%% Test 4: MultiplexGraphBD
A11 = [
      0 0 1; 
      1 0 0; 
      0 1 0 
      ];
A12 = eye(3);
A21 = eye(3);
A22 = [
      0 0 1; 
      1 0 0; 
      0 1 0 
      ];
A = {
    A11     A12
    A21     A22
    };

% cycle rule - default
known_clustering_av = {
                 1
                 1
                 }; 

g = MultiplexGraphBD(A);
clustering_av = ClusteringAv(g, 'DirectedTrianglesRule', 'cycle');

assert(isequal(clustering_av.getValue(), known_clustering_av), ...
    [BRAPH2.STR ':ClusteringAv:' BRAPH2.BUG_ERR], ...
    'ClusteringAv is not being calculated correctly for MultiplexGraphBD.')
