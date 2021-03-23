% test MultiplexGraphWU
B = rand(randi(10));
A = {B, B; B, B};

%% Test 1: Constructor
g = MultiplexGraphWU(A);

C = dediagonalize(B);
C = semipositivize(C);
C = symmetrize(C);
A = {C, diagonalize(B); diagonalize(B), C};

assert(isequal(g.getA(), A), ...
    [BRAPH2.STR ':MultiplexGraphWU:' BRAPH2.BUG_ERR], ...
    'MultiplexGraphWU is not constructing well')

%% Test 2: Randomize degree distribution preservation
B = [ 0 1 0 1 0;
    1 0 0 0 1;
    0 0 0 1 0;
    1 0 0 0 1;
    0 1 1 0 0;
    ];

A = {B, B; B B};

g = MultiplexGraphWU(A);
r_g = g.randomize();

d_g = Degree(g).getValue();
d_rg = Degree(r_g).getValue();
d_g{1} = sort(d_g{1});
d_g{2} = sort(d_g{2});
d_rg{1} = sort(d_rg{1});
d_rg{2} = sort(d_rg{2});

hist_g_1 = histcounts(d_g{1}, 1:5);
hist_rg_1 = histcounts(d_rg{1}, 1:5);
hist_g_2 = histcounts(d_g{2}, 1:5);
hist_rg_2 = histcounts(d_rg{2}, 1:5);

assert(isequal(d_g, d_rg), ...
    [BRAPH2.STR ':MultiplexGraphWU:' BRAPH2.BUG_FUNC], ...
    'MultiplexGraphWU randomize is not working.')

assert(isequal(hist_g_1, hist_rg_1), ...
    [BRAPH2.STR ':MultiplexGraphWU:' BRAPH2.BUG_FUNC], ...
    'MultiplexGraphWU randomize is not working.')

assert(isequal(hist_g_2, hist_rg_2), ...
    [BRAPH2.STR ':MultiplexGraphWU:' BRAPH2.BUG_FUNC], ...
    'MultiplexGraphWU randomize is not working.')
