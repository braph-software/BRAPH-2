% test InPathLengthAv

%% Test 1: GraphBD
A = [
    0     .1  .2  .25  0;
    .125  0   0   0    0;
    .2    .5  0   .25  0;
    .125  10  0   0    0;
    0     0   0   0    0 
    ];

known_in_path_length_av = {Inf};

g = GraphBD(A);
in_path_length_av = InPathLengthAv(g);

assert(isequal(in_path_length_av.getValue(), known_in_path_length_av), ...
    [BRAPH2.STR ':InPathLengthAv:' BRAPH2.BUG_ERR], ...
    'InPathLengthAv is not being calculated correctly for GraphBD.')

%% Test 2: GraphWD
A = [
    0     .1  .2  .25  0;
    .125  0   0   0    0;
    .2    .5  0   .25  0;
    .125  10  0   0    0;
    0     0   0   0    0 
    ];

% Default
known_in_path_length_av = {Inf};

g = GraphWD(A);
in_path_length_av = InPathLengthAv(g);

assert(isequal(in_path_length_av.getValue(), known_in_path_length_av), ...
    [BRAPH2.STR ':InPathLengthAv:' BRAPH2.BUG_ERR], ...
    'InPathLengthAv is not being calculated correctly for GraphWD.')

% Harmonic
known_in_path_length_av = {mean([8.8889 2.3529 11.3043 6.8571 Inf])};

g = GraphWD(A);
in_path_length_av = InPathLengthAv(g, 'InPathLengthRule', 'harmonic');
path_length_value = in_path_length_av.getValue();

assert(isequal({round(path_length_value{1}, 4)}, known_in_path_length_av), ...
    [BRAPH2.STR ':InPathLengthAv:' BRAPH2.BUG_ERR], ...
    'InPathLengthAv is not being calculated correctly for GraphWD.')

% Subgraphs
known_in_path_length_av = {mean([7 8/3 31/3 20/3 0])};

g = GraphWD(A);
in_path_length_av = InPathLengthAv(g, 'InPathLengthRule', 'subgraphs');

assert(isequal(in_path_length_av.getValue(), known_in_path_length_av), ...
    [BRAPH2.STR ':InPathLengthAv:' BRAPH2.BUG_ERR], ...
    'InPathLengthAv is not being calculated correctly for GraphWD.')

%% Test 3: MultiplexGraphBD
A11 = [
      0     .1  .2  .25  0;
      .125  0   0   0    0;
      .2    .5  0   .25  0;
      .125  10  0   0    0;
      0     0   0   0    0 
      ];
A12 = eye(5);
A21 = eye(5);
A22 = [
      0     .1  .2  .25  0;
      .125  0   0   0    0;
      .2    .5  0   .25  0;
      .125  10  0   0    0;
      0     0   0   0    0 
      ];
A = {
    A11     A12
    A21     A22
    };

known_in_path_length_av = {
                          Inf
                          Inf
                          };

g = MultiplexGraphBD(A);
in_path_length_av = InPathLengthAv(g);

assert(isequal(in_path_length_av.getValue(), known_in_path_length_av), ...
    [BRAPH2.STR ':InPathLengthAv:' BRAPH2.BUG_ERR], ...
    'InPathLengthAv is not being calculated correctly for MultiplexGraphBD.')

%% Test 4: MultiplexGraphWD
A11 = [
      0     .1  .2  .25  0;
      .125  0   0   0    0;
      .2    .5  0   .25  0;
      .125  10  0   0    0;
      0     0   0   0    0 
      ];
A12 = eye(5);
A21 = eye(5);
A22 = [
      0     .1  .2  .25  0;
      .125  0   0   0    0;
      .2    .5  0   .25  0;
      .125  10  0   0    0;
      0     0   0   0    0 
      ];
A = {
    A11     A12
    A21     A22
    };

known_in_path_length_av = {
                        mean([7 8/3 31/3 20/3 0])
                        mean([7 8/3 31/3 20/3 0])
                        };

g = MultiplexGraphWD(A);
in_path_length_av = InPathLengthAv(g, 'InPathLengthRule', 'subgraphs');

assert(isequal(in_path_length_av.getValue(), known_in_path_length_av), ...
    [BRAPH2.STR ':InPathLengthAv:' BRAPH2.BUG_ERR], ...
    'InPathLengthAv is not being calculated correctly for MultiplexGraphWD.')
