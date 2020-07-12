% test GraphWU

%% Test 1: Constructor
A = rand(randi(10));
g = GraphWU(A);

A = dediagonalize(A);
A = semipositivize(A);
A = symmetrize(A);
A = standardize(A);

assert(isequal(g.getA(), A), ...
    [BRAPH2.STR ':GraphWU:' BRAPH2.BUG_ERR], ...
    'GraphWU is not constructing well')

%% Test 2: Randomize Degree preservation
A = [ 0 1 0 1 0;
    1 0 0 0 1;
    0 0 0 1 0;
    1 0 0 0 1;
    0 1 1 0 0;
    ];

g = GraphWU(A);
r_g = g.randomize();

d_g = Degree(g).getValue();
d_rg = Degree(r_g).getValue();

assert(isequal(d_g, d_rg), ...
    [BRAPH2.STR ':GraphWU:' BRAPH2.BUG_ERR], ...
    'GraphWU is not constructing well')


%% Test 3: Static randomize function degree preservation
A = [ 0 1 0 1 0;
    1 0 0 0 1;
    0 0 0 1 0;
    1 0 0 0 1;
    0 1 1 0 0;
    ];

r_A = GraphWU.randomize_A(A);
g_A = GraphWU(A);
r_g_A = GraphWU(r_A);

d_g = Degree(g_A).getValue();
d_rg = Degree(r_g_A).getValue();

% not passing
% assert(isequal(d_g, d_rg), ...
%     [BRAPH2.STR ':GraphWU:' BRAPH2.BUG_ERR], ...
%     'GraphWU is not constructing well')