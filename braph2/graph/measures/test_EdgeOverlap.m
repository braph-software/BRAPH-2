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

%% Test 1: Calculation MultiplexGraphBU
g = MultiplexGraphBU(A);
edge_overlap = EdgeOverlap(g);

edge_overlap_known = [
                     0   1   0.5
                     1   0   0.5
                     0.5 0.5 0];
                 
edge_overlap_test = {edge_overlap_known};  

assert(isequal(edge_overlap.getValue(), edge_overlap_test), ...
    [BRAPH2.STR ':EdgeOverlap:' BRAPH2.BUG_ERR], ...
    'EdgeOverlap is not being calculated correctly for MultiplexGraphBU')

%% Test 2: Calculation GraphBU
g = GraphBU(L1);
edge_overlap = EdgeOverlap(g);

edge_overlap_test = {L1}; 

assert(isequal(edge_overlap.getValue(), edge_overlap_test), ...
    [BRAPH2.STR ':EdgeOverlap:' BRAPH2.BUG_ERR], ...
    'EdgeOverlap is not being calculated correctly for GraphBU')