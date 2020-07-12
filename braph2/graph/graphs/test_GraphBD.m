% test GraphBD

%% Test 1: Constructor
A = rand(randi(10));
g = GraphBD(A);

A = dediagonalize(A);
A = semipositivize(A);
A = binarize(A);

assert(isequal(g.getA(), A), ...
    [BRAPH2.STR ':GraphBD:' BRAPH2.BUG_ERR], ...
    'GraphBD is not constructing well')

%% Test 2: Randomize Degree preservation
A = [ 0 1 0 1 0;
      1 0 0 0 1;
      0 0 0 1 0;
      1 0 0 0 1;
      0 1 1 0 0;
    ];

g = GraphBD(A);
r_g = g.randomize();

in_d_g = InDegree(g).getValue();
in_d_rg = InDegree(r_g).getValue();

assert(isequal(in_d_g, in_d_rg), ...
    [BRAPH2.STR ':GraphBD:' BRAPH2.BUG_ERR], ...
    'GraphBD is not constructing well')

%% Test 3: Randomize Strength preservation
A = [ 0 1 0 1 0;
      1 0 0 0 1;
      0 0 0 1 0;
      1 0 0 0 1;
      0 1 1 0 0;
    ];

g = GraphBD(A);
r_g = g.randomize();

in_s_g = {sum(A, 1)'};
r_A = r_g.getA();
in_s_rg = {sum(r_A, 1)'};

assert(isequal(in_s_g, in_s_rg), ...
    [BRAPH2.STR ':GraphBD:' BRAPH2.BUG_ERR], ...
    'GraphBD is not constructing well')

%% Test 4: Static randomize function strength preservation
A = [ 0 1 0 1 0;
      1 0 0 0 1;
      0 0 0 1 0;
      1 0 0 0 1;
      0 1 1 0 0;
    ];

r_A = GraphBD.randomize_A(A);
in_s_g = {sum(A, 1)'};
in_s_rg = {sum(r_A, 1)'};

assert(isequal(in_s_g, in_s_rg), ...
    [BRAPH2.STR ':GraphBD:' BRAPH2.BUG_ERR], ...
    'GraphBD is not constructing well')