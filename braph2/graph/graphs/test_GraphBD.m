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

%% Test 2: Randomize Degree distribution preservation
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
hist_g = histcounts(in_d_g{1}, 1:5);
hist_rg = histcounts(in_d_rg{1}, 1:5);

assert(isequal(hist_g, hist_rg), ...
    [BRAPH2.STR ':GraphBD:' BRAPH2.BUG_FUNC], ...
    'GraphBD randomize is not working.')


%% Test 3: Static randomize function degree distribution preservation
A = [ 0 1 0 1 0;
      1 0 0 0 1;
      0 0 0 1 0;
      1 0 0 0 1;
      0 1 1 0 0;
    ];

B = max(A, transpose(A));

r_A = GraphBD.randomize_A(B);
g = GraphBD(B);
r_g = GraphBD(r_A);
in_d_g = InDegree(g).getValue();
in_d_rg = InDegree(r_g).getValue();
hist_g = histcounts(in_d_g{1}, 1:5);
hist_rg = histcounts(in_d_rg{1}, 1:5);

assert(isequal(hist_g, hist_rg), ...
    [BRAPH2.STR ':GraphBD:' BRAPH2.BUG_FUNC], ...
    'GraphBD randomize_A is not working.')