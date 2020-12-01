% test Distance

%% Test 1: GraphWU
A = [
    0 .1 .2 .25 0;
    .125 0 0 0  0;
    .2 .5 0 .25 0;
    .125 10 0 0 0;
    0  0  0  0  0
    ];

known_value = {[
                0 2 1 1 0;
                2 0 1 1 0;
                1 1 0 2 0;
                1 1 2 0 0;
                0 0 0 0 0;
                ]};

g = GraphWU(A);
edge_number_distance = EdgeNumberDistance(g);;

assert(isequal(edge_number_distance.getValue(), known_value), ...
    [BRAPH2.STR ':EdgeNumberDistance:' BRAPH2.BUG_ERR], ...
    'EdgeNumberDistance is not being calculated correctly for GraphWU.')

%% Test 2: GraphWD
A = [
    0 .1 .2 .25 0;
    .125 0 0 0  0;
    .2 .5 0 .25 0;
    .125 10 0 0 0;
    0  0  0  0  0
    ];

known_value = {[
                0 2 1 1 0;
                1 0 2 2 0;
                1 1 0 1 0;
                1 1 2 0 0;
                0 0 0 0 0;
                ]};

g = GraphWD(A);
edge_number_distance = EdgeNumberDistance(g);;

assert(isequal(edge_number_distance.getValue(), known_value), ...
    [BRAPH2.STR ':EdgeNumberDistance:' BRAPH2.BUG_ERR], ...
    'EdgeNumberDistance is not being calculated correctly for GraphWD.')

%% Test 3: MultiplexGraphWU
A11 = [
        0 .1 .2 .25 0;
        .125 0 0 0  0;
        .2 .5 0 .25 0;
        .125 10 0 0 0;
        0  0  0  0  0
       ];
A12 = eye(5);
A21 = eye(5);
A22 = [
        0 .1 .2 .25 0;
        .125 0 0 0  0;
        .2 .5 0 .25 0;
        .125 10 0 0 0;
        0  0  0  0  0
       ];
A = {
        A11 A12
        A21 A22
    };

known_value = {[
                0 2 1 1 0;
                2 0 1 1 0;
                1 1 0 2 0;
                1 1 2 0 0;
                0 0 0 0 0;
               ]
               [
                0 2 1 1 0;
                2 0 1 1 0;
                1 1 0 2 0;
                1 1 2 0 0;
                0 0 0 0 0;
               ]};

g = MultiplexGraphWU(A);
edge_number_distance = EdgeNumberDistance(g);;

assert(isequal(edge_number_distance.getValue(), known_value), ...
    [BRAPH2.STR ':EdgeNumberDistance:' BRAPH2.BUG_ERR], ...
    'EdgeNumberDistance is not being calculated correctly for MultiplexGraphWU.')

%% Test 8: MultiplexGraphWD
A11 = [
        0 .1 .2 .25 0;
        .125 0 0 0  0;
        .2 .5 0 .25 0;
        .125 10 0 0 0;
        0  0  0  0  0
       ];
A12 = eye(5);
A21 = eye(5);
A22 = [
        0 .1 .2 .25 0;
        .125 0 0 0  0;
        .2 .5 0 .25 0;
        .125 10 0 0 0;
        0  0  0  0  0
       ];
A = {
        A11 A12
        A21 A22
    };

known_value = {[
                0 2 1 1 0;
                1 0 2 2 0;
                1 1 0 1 0;
                1 1 2 0 0;
                0 0 0 0 0;
               ]
               [
                0 2 1 1 0;
                1 0 2 2 0;
                1 1 0 1 0;
                1 1 2 0 0;
                0 0 0 0 0;
               ]};

g = MultiplexGraphWD(A);
edge_number_distance = EdgeNumberDistance(g);;

assert(isequal(edge_number_distance.getValue(), known_value), ...
    [BRAPH2.STR ':EdgeNumberDistance:' BRAPH2.BUG_ERR], ...
    'EdgeNumberDistance is not being calculated correctly for MultiplexGraphWD.')
