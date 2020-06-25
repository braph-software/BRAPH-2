% test PathLengthAv

%% Test 1: GraphBU
A = [
    0   .1  0   0
    .2  0   .1  0
    0   .1  0   .2
    0   0   .1  0
    ];

known_path_length_av = {mean([2 4/3 4/3 2])};

g = GraphBU(A);
path_length_av = PathLengthAv(g);

assert(isequal(path_length_av.getValue(), known_path_length_av), ...
    [BRAPH2.STR ':PathLengthAv:' BRAPH2.BUG_ERR], ...
    'PathLengthAv is not being calculated correctly for GraphBU.')

%% Test 2: GraphWU
A = [
    0   .1  0   0
    .2  0   .1  0
    0   .1  0   .2
    0   0   .1  0
    ];

% Default
known_path_length_av = {mean([40/3 10 10 40/3])};

g = GraphWU(A);
path_length_av = PathLengthAv(g);

assert(isequal(path_length_av.getValue(), known_path_length_av), ...
    [BRAPH2.STR ':PathLengthAv:' BRAPH2.BUG_ERR], ...
    'PathLengthAv is not being calculated correctly for GraphWU.')

% Harmonic
known_path_length_av = {mean([9.4737 8.1818 8.1818 9.4737])};

g = GraphWU(A);
path_length_av = PathLengthAv(g, 'PathLengthRule', 'harmonic');
path_length_value = path_length_av.getValue();

assert(isequal({round(path_length_value{1}, 5)}, known_path_length_av), ...
    [BRAPH2.STR ':PathLengthAv:' BRAPH2.BUG_ERR], ...
    'PathLengthAv is not being calculated correctly for GraphWU.')

% Subgraphs
known_path_length_av = {mean([40/3 10 10 40/3])};

g = GraphWU(A);
path_length_av = PathLengthAv(g, 'PathLengthRule', 'subgraphs');

assert(isequal(path_length_av.getValue(), known_path_length_av), ...
    [BRAPH2.STR ':PathLengthAv:' BRAPH2.BUG_ERR], ...
    'PathLengthAv is not being calculated correctly for GraphWU.')

%% Test 3: MultiplexGraphBU
A11 = [
      0   .1  0   0
      .2  0   .1  0
      0   .1  0   .2
      0   0   .1  0
      ];
A12 = eye(4);
A21 = eye(4);
A22 = [
      0   .1  0   0
      .2  0   .1  0
      0   .1  0   .2
      0   0   .1  0
      ];
A = {
    A11     A12
    A21     A22
    };

known_path_length_av = {
                       mean([2 4/3 4/3 2])
                       mean([2 4/3 4/3 2])
                       };

g = MultiplexGraphBU(A);
path_length_av = PathLengthAv(g);

assert(isequal(path_length_av.getValue(), known_path_length_av), ...
    [BRAPH2.STR ':PathLengthAv:' BRAPH2.BUG_ERR], ...
    'PathLengthAv is not being calculated correctly for MultiplexGraphBU.')

%% Test 4: MultiplexGraphWU
A11 = [
      0   .1  0   0
      .2  0   .1  0
      0   .1  0   .2
      0   0   .1  0
      ];
A12 = eye(4);
A21 = eye(4);
A22 = [
      0   .1  0   0
      .2  0   .1  0
      0   .1  0   .2
      0   0   .1  0
      ];
A = {
    A11     A12
    A21     A22
    };

known_path_length_av = {
                       mean([40/3 10 10 40/3])
                       mean([40/3 10 10 40/3])
                       };

g = MultiplexGraphWU(A);
path_length_av = PathLengthAv(g, 'PathLengthRule', 'subgraphs');

assert(isequal(path_length_av.getValue(), known_path_length_av), ...
    [BRAPH2.STR ':PathLengthAv:' BRAPH2.BUG_ERR], ...
    'PathLengthAv is not being calculated correctly for MultiplexGraphWU.')