% test EdgeOverlap
L1 = [
    0   0.2 1
    0.2 0   0
    1   0   0];

L2 = [
    0 1   0
    1 0   0.4
    0 0.4 0];

A = {
    L1      eye(3)
    eye(3)  L2
    };

%% Test 1: Calculation MultiplexGraphWD
g = MultiplexGraphWD(A);
weighted_edge_overlap = WeightedEdgeOverlap(g);

known_weighted_edge_overlap = [
                     0    0.6  0.5
                     0.6  0    0.2
                     0.5  0.2  0];
                 
weighted_edge_overlap_test = {known_weighted_edge_overlap};  

assert(isequal(weighted_edge_overlap.getValue(), weighted_edge_overlap_test), ...
    [BRAPH2.STR ':WeightedEdgeOverlap:' BRAPH2.BUG_ERR], ...
    'WeightedEdgeOverlap is not being calculated correctly for MultiplexGraphWD')

%% Test 2: Calculation MultiplexGraphWU
g = MultiplexGraphWU(A);
weighted_edge_overlap = WeightedEdgeOverlap(g);

known_weighted_edge_overlap = [
                     0    0.6  0.5
                     0.6  0    0.2
                     0.5  0.2  0];
                 
weighted_edge_overlap_test = {known_weighted_edge_overlap};  

assert(isequal(weighted_edge_overlap.getValue(), weighted_edge_overlap_test), ...
    [BRAPH2.STR ':WeightedEdgeOverlap:' BRAPH2.BUG_ERR], ...
    'WeightedEdgeOverlap is not being calculated correctly for MultiplexGraphWU')
