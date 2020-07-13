% test GraphWD

%% Test 1: Constructor
A = rand(randi(10));
g = GraphWD(A);

A = dediagonalize(A);
A = semipositivize(A);
A = standardize(A);

assert(isequal(g.getA(), A), ...
    [BRAPH2.STR ':GraphWD:' BRAPH2.BUG_ERR], ...
    'GraphWD is not constructing well')

%% Test 2: Randomize Degree distribution preservation
A = [ 0 1 0 1 0;
    1 0 0 0 1;
    0 0 0 1 0;
    1 0 0 0 1;
    0 1 1 0 0;
    ];

g = GraphWD(A);
r_g = g.randomize();

d_g = InDegree(g).getValue();
d_rg = InDegree(r_g).getValue();
hist_g = histcounts(d_g{1}, 1:5);
hist_rg = histcounts(d_rg{1}, 1:5);
assert(isequal(hist_g, hist_rg), ...
    [BRAPH2.STR ':GraphWD:' BRAPH2.BUG_FUNC], ...
    'GraphWD is not constructing well')


%% Test 3: Static randomize function degree distribution preservation
A = [ 0 1 0 1 0;
    1 0 0 0 1;
    0 0 0 1 0;
    1 0 0 0 1;
    0 1 1 0 0;
    ];

B = max(A, transpose(A));

r_A = GraphWD.randomize_A(B);
g = GraphWD(B);
r_g = GraphWD(r_A);
d_g = InDegree(g).getValue();
d_rg = InDegree(r_g).getValue();
hist_g = histcounts(d_g{1}, 1:5);
hist_rg = histcounts(d_rg{1}, 1:5);

assert(isequal(hist_g, hist_rg), ...
    [BRAPH2.STR ':GraphWD:' BRAPH2.BUG_FUNC], ...
    'GraphWD randomize_A is not working.')