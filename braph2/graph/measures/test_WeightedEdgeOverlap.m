% test EdgeOverlap

A = {
    [0, 0.2, 1; 0.2, 0, 0; 1, 0, 0]     eye(3)
    eye(3)                              [0, 1, 0; 1, 0, 0.4; 0, 0.4, 0]
    };

%% Test 1: Calculation MultiplexGraphWD
known_weighted_edge_overlap = {[
                     0    0.6  0.5
                     0.6  0    0.2
                     0.5  0.2  0]};
                 
g = MultiplexGraphWD(A);
weighted_edge_overlap = WeightedEdgeOverlap(g);

assert(isequal(weighted_edge_overlap.getValue(), known_weighted_edge_overlap), ...
    [BRAPH2.STR ':WeightedEdgeOverlap:' BRAPH2.BUG_ERR], ...
    'WeightedEdgeOverlap is not being calculated correctly for MultiplexGraphWD')

%% Test 2: Calculation MultiplexGraphWU
known_weighted_edge_overlap = {[
                     0    0.6  0.5
                     0.6  0    0.2
                     0.5  0.2  0]};
                 
g = MultiplexGraphWU(A);
weighted_edge_overlap = WeightedEdgeOverlap(g);

assert(isequal(weighted_edge_overlap.getValue(), known_weighted_edge_overlap), ...
    [BRAPH2.STR ':WeightedEdgeOverlap:' BRAPH2.BUG_ERR], ...
    'WeightedEdgeOverlap is not being calculated correctly for MultiplexGraphWU')
