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

%% Test 2: Randomize Degree preservation
A = [ 0 1 0 1 0;
      1 0 0 0 1;
      0 0 0 1 0;
      1 0 0 0 1;
      0 1 1 0 0;
    ];

g = GraphBU(A);
r_g = g.randomize();

in_d_g = Degree(g).getValue();
in_d_rg = Degree(r_g).getValue();

assert(isequal(in_d_g, in_d_rg), ...
    [BRAPH2.STR ':GraphBU:' BRAPH2.BUG_ERR], ...
    'GraphBU is not constructing well')


%% Test 3: Static randomize function degree preservation
A = [ 0 1 0 1 0;
      1 0 0 0 1;
      0 0 0 1 0;
      1 0 0 0 1;
      0 1 1 0 0;
    ];

r_A = GraphBU.randomize_A(A);
g = GraphBU(A);
r_g = GraphBU(r_A);
in_d_g = Degree(g).getValue();
in_d_rg = Degree(r_g).getValue();

assert(isequal(in_d_g, in_d_rg), ...
    [BRAPH2.STR ':GraphBU:' BRAPH2.BUG_ERR], ...
    'GraphBU is not constructing well')
