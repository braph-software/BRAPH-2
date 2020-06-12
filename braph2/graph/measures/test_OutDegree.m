% test OutDegree

%% Test 1: Calculation GraphBD
A = [
    0  1  1
    0  0  0
    1  0  0];

known_out_degree = {[2, 0, 1]'};

g = GraphBD(A);
out_degree = OutDegree(g);

assert(isequal(out_degree.getValue(), known_out_degree), ...
    [BRAPH2.STR ':OutDegree:' BRAPH2.BUG_ERR], ...
    'OutDegree is not being calculated correctly for GraphBD')

%% Test 2: Calculation MultiplexGraphBD
A11 = [
    0  1  1
    0  0  0
    1  0  0];
A12 = eye(3);
A21 = eye(3);
A22 = [
    0 1   0
    1 0   1
    1 1  0];
A = {
    A11     A12  
    A21     A22
    };

known_out_degree = {
                     [2, 0, 1]'
                     [1, 2, 2]'};
                                
g = MultiplexGraphBD(A);
out_degree = OutDegree(g);

assert(isequal(out_degree.getValue(), known_out_degree), ...
    [BRAPH2.STR ':OutDegree:' BRAPH2.BUG_ERR], ...
    'OutDegree is not being calculated correctly for MultiplexGraphBD')

%% Test 3: Calculation GraphWD
A = [
    0   .2  1
    0   0   .8
    1   0   0];

known_out_degree = {[2, 1, 1]'};

g = GraphWD(A);
out_degree = OutDegree(g);

assert(isequal(out_degree.getValue(), known_out_degree), ...
    [BRAPH2.STR ':OutDegree:' BRAPH2.BUG_ERR], ...
    'OutDegree is not being calculated correctly for GraphWD')

%% Test 4: Calculation MultiplexGraphWD
A11 = [
    0   .2  1
    0   0   .8
    1   0   0];
A12 = eye(3);
A21 = eye(3);
A22 = [
    0 1   .6
    1 0   .4
    0 .4  0];
A = {
    A11     A12  
    A21     A22
    };

known_out_degree = {
                     [2, 1, 1]'
                     [2, 2, 1]'};
                                
g = MultiplexGraphWD(A);
out_degree = OutDegree(g);

assert(isequal(out_degree.getValue(), known_out_degree), ...
    [BRAPH2.STR ':OutDegree:' BRAPH2.BUG_ERR], ...
    'OutDegree is not being calculated correctly for MultiplexGraphWD')