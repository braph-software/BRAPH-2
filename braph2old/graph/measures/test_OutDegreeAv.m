% test OutDegreeAv

%% Test 1: Graph BD
A = [
    0   .2  1
    0   0   .8
    1   0   0
    ];
known_outdegree_av = {mean([1 1 2])};
g = GraphBD(A);
out_degree_av = OutDegreeAv(g);


assert(isequal(out_degree_av.getValue(), known_outdegree_av), ...
    [BRAPH2.STR ':OutDegreeAv:' BRAPH2.BUG_ERR], ...
    'OutDegreeAv is not being calculated correctly for GraphBD.')

%% Test 2: GraphWD
A = [
    0   .2  1
    0   0   .8
    1   0   0
    ];

known_outdegree_av = {mean([1 1 2])};
g = GraphWD(A);
out_degree_av = OutDegreeAv(g);

assert(isequal(out_degree_av.getValue(), known_outdegree_av), ...
    [BRAPH2.STR ':OutDegreeAv:' BRAPH2.BUG_ERR], ...
    'OutDegreeAv is not being calculated correctly for GraphWD.')

%% Test 3: MultiplexGraphBD
A11 = [
    0   .2  1
    0   0   .8
    1   0   0];
A12 = eye(3);
A21 = eye(3);
A22 = [
    0  1   .6
    1  0   .4
    0  .4  0];
A = {
    A11     A12  
    A21     A22
    };
 
known_outdegree_av = {
    mean([1 1 2])
    mean([1 2 2])
    };

g = MultiplexGraphBD(A);
out_degree_av = OutDegreeAv(g);

assert(isequal(out_degree_av.getValue(), known_outdegree_av), ...
    [BRAPH2.STR ':OutDegreeAv:' BRAPH2.BUG_ERR], ...
    'OutDegreeAv is not being calculated correctly for MultiplexGraphBD.')

%% Test 4: MultiplexGraphWD
A11 = [
    0   .2  1
    0   0   .8
    1   0   0];
A12 = eye(3);
A21 = eye(3);
A22 = [
    0  1   .6
    1  0   .4
    0  .4  0];
A = {
    A11     A12  
    A21     A22
    };
 
known_outdegree_av = {
    mean([1 1 2])
    mean([1 2 2])
    };

g = MultiplexGraphWD(A);
out_degree_av = OutDegreeAv(g);

assert(isequal(out_degree_av.getValue(), known_outdegree_av), ...
    [BRAPH2.STR ':OutDegreeAv:' BRAPH2.BUG_ERR], ...
    'OutDegreeAv is not being calculated correctly for MultiplexGraphWD.')
