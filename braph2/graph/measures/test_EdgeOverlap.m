% test EdgeOverlap
L1 = [
    0 1 1
    1 0 0
    1 0 0];

L2 = [
    0 1 0
    1 0 1
    0 1 0];

A = {
    L1      eye(3)
    eye(3)  L2
    };

L1_weighted = [
    0   0.2 1
    0.2 0   0
    1   0   0];

L2_weighted = [
    0 1   0
    1 0   0.3
    0 0.3 0];

A_weighted = {
    L1_weighted    eye(3)
    eye(3)          L2_weighted
    };

%% Test 1: Calculation MultiplexGraphBU
g = MultiplexGraphBU(A);
edge_overlap = EdgeOverlap(g);

known_edge_overlap = [
                     0   1   0.5
                     1   0   0.5
                     0.5 0.5 0];
                 
edge_overlap_test = {known_edge_overlap};  

assert(isequal(edge_overlap.getValue(), edge_overlap_test), ...
    [BRAPH2.STR ':EdgeOverlap:' BRAPH2.BUG_ERR], ...
    'EdgeOverlap is not being calculated correctly for MultiplexGraphBU')

%% Test 2: Calculation MultiplexGraphBD
g = MultiplexGraphBD(A);
edge_overlap = EdgeOverlap(g);

known_edge_overlap = [
                     0   1   0.5
                     1   0   0.5
                     0.5 0.5 0];
                 
edge_overlap_test = {known_edge_overlap};  

assert(isequal(edge_overlap.getValue(), edge_overlap_test), ...
    [BRAPH2.STR ':EdgeOverlap:' BRAPH2.BUG_ERR], ...
    'EdgeOverlap is not being calculated correctly for MultiplexGraphBD')

%% Test 3: Calculation MultiplexGraphWU
g = MultiplexGraphWU(A_weighted);
edge_overlap = EdgeOverlap(g);

known_edge_overlap = [
                     0   1   0.5
                     1   0   0.5
                     0.5 0.5 0];
                 
edge_overlap_test = {known_edge_overlap};  

assert(isequal(edge_overlap.getValue(), edge_overlap_test), ...
    [BRAPH2.STR ':EdgeOverlap:' BRAPH2.BUG_ERR], ...
    'EdgeOverlap is not being calculated correctly for MultiplexGraphWU')

%% Test 4: Calculation MultiplexGraphWD
g = MultiplexGraphWD(A_weighted);
edge_overlap = EdgeOverlap(g);

known_edge_overlap = [
                     0   1   0.5
                     1   0   0.5
                     0.5 0.5 0];
                 
edge_overlap_test = {known_edge_overlap};  

assert(isequal(edge_overlap.getValue(), edge_overlap_test), ...
    [BRAPH2.STR ':EdgeOverlap:' BRAPH2.BUG_ERR], ...
    'EdgeOverlap is not being calculated correctly for MultiplexGraphWD')
