% test Clustering

%% Test 1: GraphBU
A = [
    0 1 1 1; 
    1 0 1 0; 
    1 1 0 1; 
    1 0 1 0
    ];

known_clustering = {[2/3 1 2/3 1]'};

g = GraphBU(A);
clustering = Clustering(g);

assert(isequal(clustering.getValue(), known_clustering), ...
    [BRAPH2.STR ':Clustering:' BRAPH2.BUG_ERR], ...
    'Clustering is not being calculated correctly for GraphBU.')

%% Test 2: GraphBD
A = [
    0 0 1; 
    1 0 0; 
    0 1 0 
    ];

% cycle rule - default
known_clustering_default_cycle = {[1 1 1]'};

g = GraphBD(A);
clustering = Clustering(g);

assert(isequal(clustering.getValue(), known_clustering_default_cycle), ...
    [BRAPH2.STR ':Clustering:' BRAPH2.BUG_ERR], ...
    'Clustering is not being calculated correctly for GraphBD.')

% in rule 
known_clustering_in = {[0 0 0]'};

g = GraphBD(A);
clustering = Clustering(g, 'DirectedTrianglesRule', 'in');

assert(isequal(clustering.getValue(), known_clustering_in), ...
    [BRAPH2.STR ':Clustering:' BRAPH2.BUG_ERR], ...
    'Clustering is not being calculated correctly for GraphBD.')

% out rule 
known_clustering_out = {[0 0 0]'};

g = GraphBD(A);
clustering = Clustering(g, 'DirectedTrianglesRule', 'out');

assert(isequal(clustering.getValue(), known_clustering_out), ...
    [BRAPH2.STR ':Clustering:' BRAPH2.BUG_ERR], ...
    'Clustering is not being calculated correctly for GraphBD.')

% middleman rule
known_clustering_middleman = {[0 0 0]'};

g = GraphBD(A);
clustering = Clustering(g, 'DirectedTrianglesRule', 'middleman');

assert(isequal(clustering.getValue(), known_clustering_middleman), ...
    [BRAPH2.STR ':Clustering:' BRAPH2.BUG_ERR], ...
    'Clustering is not being calculated correctly for GraphBD.')

% all rule 
known_clustering_all = {[1/2 1/2 1/2]'};

g = GraphBD(A);
clustering = Clustering(g, 'DirectedTrianglesRule', 'all');

assert(isequal(clustering.getValue(), known_clustering_all), ...
    [BRAPH2.STR ':Clustering:' BRAPH2.BUG_ERR], ...
    'Clustering is not being calculated correctly for GraphBD.')
