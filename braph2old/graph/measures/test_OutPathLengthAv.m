% test OutPathLengthAv

%% Test 1: GraphBD
A = [
    0   .1  0   0   0
    .2  0   0   0   0
    0   0   0   .2  0
    0   0   .1  0   0
    0   0   0   0   0
    ];

known_out_path_length_av = {Inf};

g = GraphBD(A);
out_path_length_av = OutPathLengthAv(g);

assert(isequal(out_path_length_av.getValue(), known_out_path_length_av), ...
    [BRAPH2.STR ':OutPathLengthAv:' BRAPH2.BUG_ERR], ...
    'OutPathLengthAv is not being calculated correctly for GraphBD.')

%% Test 2: GraphWD
A = [
    0   .1  0   0   0
    .2  0   0   0   0
    0   0   0   .2  0
    0   0   .1  0   0
    0   0   0   0   0
    ];

% Default
known_out_path_length_av = {Inf};

g = GraphWD(A);
out_path_length_av = OutPathLengthAv(g);

assert(isequal(out_path_length_av.getValue(), known_out_path_length_av), ...
    [BRAPH2.STR ':OutPathLengthAv:' BRAPH2.BUG_ERR], ...
    'OutPathLengthAv is not being calculated correctly for GraphWD.')

% Harmonic
known_out_path_length_av = {mean([40 20 20 40 Inf])};

g = GraphWD(A);
out_path_length_av = OutPathLengthAv(g, 'OutPathLengthRule', 'harmonic');

assert(isequal(out_path_length_av.getValue(), known_out_path_length_av), ...
    [BRAPH2.STR ':OutPathLengthAv:' BRAPH2.BUG_ERR], ...
    'OutPathLengthAv is not being calculated correctly for GraphWD.')

% Subgraphs
known_out_path_length_av = {mean([10 5 5 10 0])};

g = GraphWD(A);
out_path_length_av = OutPathLengthAv(g, 'OutPathLengthRule', 'subgraphs');

assert(isequal(out_path_length_av.getValue(), known_out_path_length_av), ...
    [BRAPH2.STR ':OutPathLengthAv:' BRAPH2.BUG_ERR], ...
    'OutPathLengthAv is not being calculated correctly for GraphWD.')

%% Test 3: MultiplexGraphBD
A11 = [
      0   .1  0   0   0
      .2  0   0   0   0
      0   0   0   .2  0
      0   0   .1  0   0
      0   0   0   0   0
      ];
A12 = eye(5);
A21 = eye(5);
A22 = [
      0   .1  0   0   0
      .2  0   0   0   0
      0   0   0   .2  0
      0   0   .1  0   0
      0   0   0   0   0
      ];
A = {
    A11     A12
    A21     A22
    };

known_out_path_length_av = {
                          Inf
                          Inf
                          };

g = MultiplexGraphBD(A);
out_path_length_av = OutPathLengthAv(g);

assert(isequal(out_path_length_av.getValue(), known_out_path_length_av), ...
    [BRAPH2.STR ':OutPathLengthAv:' BRAPH2.BUG_ERR], ...
    'OutPathLengthAv is not being calculated correctly for MultiplexGraphBD.')

%% Test 4: MultiplexGraphWD
A11 = [
      0   .1  0   0   0
      .2  0   0   0   0
      0   0   0   .2  0
      0   0   .1  0   0
      0   0   0   0   0
      ];
A12 = eye(5);
A21 = eye(5);
A22 = [
      0   .1  0   0   0
      .2  0   0   0   0
      0   0   0   .2  0
      0   0   .1  0   0
      0   0   0   0   0
      ];
A = {
    A11     A12
    A21     A22
    };

known_out_path_length_av = {
                        mean([10 5 5 10 0])
                        mean([10 5 5 10 0])
                        };

g = MultiplexGraphWD(A);
out_path_length_av = OutPathLengthAv(g, 'OutPathLengthRule', 'subgraphs');

assert(isequal(out_path_length_av.getValue(), known_out_path_length_av), ...
    [BRAPH2.STR ':OutPathLengthAv:' BRAPH2.BUG_ERR], ...
    'OutPathLengthAv is not being calculated correctly for MultiplexGraphWD.')
