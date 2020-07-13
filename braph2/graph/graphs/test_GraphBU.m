% test GraphBU

%% Test 1: Constructor
A = rand(randi(10));
g = GraphBU(A);

A = dediagonalize(A); 
A = semipositivize(A); 
A = binarize(A);
A = symmetrize(A); 

assert(isequal(g.getA(), A), ...
       [BRAPH2.STR ':GraphBU:' BRAPH2.BUG_ERR], ...
       'GraphBU is not constructing well')

%% Test 2: Randomize Degree distribution preservation
A = [ 0 1 0 1 0;
      1 0 0 0 1;
      0 0 0 1 0;
      1 0 0 0 1;
      0 1 1 0 0;
    ];

g = GraphBU(A);
r_g = g.randomize();

d_g = Degree(g).getValue();
d_rg = Degree(r_g).getValue();
d_g = sort(d_g{1});
d_rg = sort(d_rg{1});
hist_g = histcounts(d_g, 1:5);
hist_rg = histcounts(d_rg, 1:5);

assert(isequal(d_g, d_rg), ...
    [BRAPH2.STR ':GraphBU:' BRAPH2.BUG_FUNC], ...
    'GraphBU randomize is not working.')

assert(isequal(hist_g, hist_rg), ...
    [BRAPH2.STR ':GraphBU:' BRAPH2.BUG_FUNC], ...
    'GraphBU randomize is not working.')


%% Test 3: Static randomize function degree distribution preservation
A = [ 0 1 0 1 0;
      1 0 0 0 1;
      0 0 0 1 0;
      1 0 0 0 1;
      0 1 1 0 0;
    ];

B = max(A, transpose(A));

r_A = GraphBU.randomize_A(B);
g = GraphBU(B);
r_g = GraphBU(r_A);
d_g = Degree(g).getValue();
d_rg = Degree(r_g).getValue();
d_g = sort(d_g{1});
d_rg = sort(d_rg{1});
hist_g = histcounts(d_g, 1:5);
hist_rg = histcounts(d_rg, 1:5);

assert(isequal(d_g, d_rg), ...
    [BRAPH2.STR ':GraphBU:' BRAPH2.BUG_FUNC], ...
    'GraphBU randomize is not working.')

assert(isequal(hist_g, hist_rg), ...
    [BRAPH2.STR ':GraphBU:' BRAPH2.BUG_FUNC], ...
    'GraphBU randomize_A is not working.')
