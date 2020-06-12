% test WeightedEdgeOverlap

%% Test 1: Calculation MultiplexGraphWD
A11 = [
    0   .2  0
    .2  0   0
    1   0   0
    ];
A12 = eye(3);
A21 = eye(3);
A22 = [
    0   1   0
    1   0   .4
    0   .4  0
    ];
A = {
    A11     A12
    A21     A22
    };

known_weighted_edge_overlap = {[
                     0   .6  0
                     .6  0   .2
                     .5  .2  0]};
                 
g = MultiplexGraphWD(A);
weighted_edge_overlap = WeightedEdgeOverlap(g);

assert(isequal(weighted_edge_overlap.getValue(), known_weighted_edge_overlap), ...
    [BRAPH2.STR ':WeightedEdgeOverlap:' BRAPH2.BUG_ERR], ...
    'WeightedEdgeOverlap is not being calculated correctly for MultiplexGraphWD')

%% Test 2: Calculation MultiplexGraphWU
A11 = [
    0   .2  1
    .2  0   0
    1   0   0
    ];
A12 = eye(3);
A21 = eye(3);
A22 = [
    0   1   0
    1   0   .4
    0   .4  0
    ];
A = {
    A11     A12
    A21     A22
    };

known_weighted_edge_overlap = {[
                     0   .6  .5
                     .6  0   .2
                     .5  .2  0]};
                 
g = MultiplexGraphWU(A);
weighted_edge_overlap = WeightedEdgeOverlap(g);

assert(isequal(weighted_edge_overlap.getValue(), known_weighted_edge_overlap), ...
    [BRAPH2.STR ':WeightedEdgeOverlap:' BRAPH2.BUG_ERR], ...
    'WeightedEdgeOverlap is not being calculated correctly for MultiplexGraphWU')
