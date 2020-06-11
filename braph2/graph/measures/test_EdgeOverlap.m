% test EdgeOverlap

A = {
    [0, 1, 1; 1, 0, 0; 1, 0, 0]         eye(3)
    eye(3)                              [0, 1, 0; 1, 0, 1; 0, 1, 0]
};

A_weighted = {
    [0, 0.2, 1; 0.2, 0, 0; 1, 0, 0]     eye(3)
    eye(3)                              [0, 1, 0; 1, 0, 0.3; 0, 0.3, 0]
    };

%% Test 1: Calculation MultiplexGraphBU
known_edge_overlap = {[
                     0   1   0.5
                     1   0   0.5
                     0.5 0.5 0]};
                 
g = MultiplexGraphBU(A);
edge_overlap = EdgeOverlap(g);

assert(isequal(edge_overlap.getValue(), known_edge_overlap), ...
    [BRAPH2.STR ':EdgeOverlap:' BRAPH2.BUG_ERR], ...
    'EdgeOverlap is not being calculated correctly for MultiplexGraphBU')

%% Test 2: Calculation MultiplexGraphBD
known_edge_overlap = {[
                     0   1   0.5
                     1   0   0.5
                     0.5 0.5 0]}; 

g = MultiplexGraphBD(A);
edge_overlap = EdgeOverlap(g);

assert(isequal(edge_overlap.getValue(), known_edge_overlap), ...
    [BRAPH2.STR ':EdgeOverlap:' BRAPH2.BUG_ERR], ...
    'EdgeOverlap is not being calculated correctly for MultiplexGraphBD')

%% Test 3: Calculation MultiplexGraphWU
known_edge_overlap = {[
                     0   1   0.5
                     1   0   0.5
                     0.5 0.5 0]};

g = MultiplexGraphWU(A_weighted);
edge_overlap = EdgeOverlap(g);

assert(isequal(edge_overlap.getValue(), known_edge_overlap), ...
    [BRAPH2.STR ':EdgeOverlap:' BRAPH2.BUG_ERR], ...
    'EdgeOverlap is not being calculated correctly for MultiplexGraphWU')

%% Test 4: Calculation MultiplexGraphWD
known_edge_overlap = {[
                     0   1   0.5
                     1   0   0.5
                     0.5 0.5 0]};
                 
g = MultiplexGraphWD(A_weighted);
edge_overlap = EdgeOverlap(g);

assert(isequal(edge_overlap.getValue(), known_edge_overlap), ...
    [BRAPH2.STR ':EdgeOverlap:' BRAPH2.BUG_ERR], ...
    'EdgeOverlap is not being calculated correctly for MultiplexGraphWD')
