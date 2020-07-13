% test MultiplexGraphBD
B = rand(randi(10));
A = {B, B; B, B};

%% Test 1: Constructor
g = MultiplexGraphBD(A);
B = semipositivize(B);
B = binarize(B);
C = dediagonalize(B);
A = {C, diagonalize(B); diagonalize(B), C};

assert(isequal(g.getA(), A), ...
    [BRAPH2.STR ':MultiplexGraphBD:' BRAPH2.BUG_ERR], ...
    'MultiplexGraphBD is not constructing well')

%% Test 2: Randomize degree distribution preservation
B = [ 0 1 0 1 0;
    1 0 0 0 1;
    0 0 0 1 0;
    1 0 0 0 1;
    0 1 1 0 0;
    ];

A = {B, B; B B};

g = MultiplexGraphBD(A);
r_g = g.randomize();

in_d_g = InDegree(g).getValue();
in_d_rg = InDegree(r_g).getValue();
in_d_g{1} = sort(in_d_g{1});
in_d_g{2} = sort(in_d_g{2});
in_d_rg{1} = sort(in_d_rg{1});
in_d_rg{2} = sort(in_d_rg{2});

out_d_g = OutDegree(g).getValue();
out_d_rg = OutDegree(r_g).getValue();
out_d_g{1} = sort(out_d_g{1});
out_d_g{2} = sort(out_d_g{2});
out_d_rg{1} = sort(out_d_rg{1});
out_d_rg{2} = sort(out_d_rg{2});

hist_g_1 = histcounts(in_d_g{1}, 1:5);
hist_rg_1 = histcounts(in_d_rg{1}, 1:5);
hist_g_2 = histcounts(in_d_g{2}, 1:5);
hist_rg_2 = histcounts(in_d_rg{2}, 1:5);

assert(isequal(in_d_g, in_d_rg), ...
    [BRAPH2.STR ':MultiplexGraphBD:' BRAPH2.BUG_FUNC], ...
    'MultiplexGraphBD randomize is not working.')

assert(isequal(out_d_g, out_d_rg), ...
    [BRAPH2.STR ':MultiplexGraphBD:' BRAPH2.BUG_FUNC], ...
    'MultiplexGraphBD randomize is not working.')

assert(isequal(hist_g_1, hist_rg_1), ...
    [BRAPH2.STR ':MultiplexGraphBD:' BRAPH2.BUG_FUNC], ...
    'MultiplexGraphBD randomize is not working.')

assert(isequal(hist_g_2, hist_rg_2), ...
    [BRAPH2.STR ':MultiplexGraphBD:' BRAPH2.BUG_FUNC], ...
    'MultiplexGraphBD randomize is not working.')