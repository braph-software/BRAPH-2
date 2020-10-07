% test MultiplexTriangles

%% Test 1: MultiplexGraphBU
A11 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 0;
      1 0 0 0
      ];
A12 = eye(4);
A21 = eye(4);
A22 = [
      0 1 1 1;
      1 0 0 0;
      1 0 0 0;
      1 0 0 0
      ];
A = {
    A11     A12
    A21     A22
    };

known_multiplex_triangles = {
                 [2 2 2 0]'
                 };      

g = MultiplexGraphBU(A);
multiplex_triangles = MultiplexTriangles(g);

assert(isequal(multiplex_triangles.getValue(), known_multiplex_triangles), ...
    [BRAPH2.STR ':MultiplexTriangles:' BRAPH2.BUG_ERR], ...
    'MultiplexTriangles is not being calculated correctly for MultiplexGraphBU.')

%% Test 2: MultiplexGraphWU
A11 = [
      0   .2  1   1;
      .2  0   1  0;
      1   1  0   0;
      1   0   0   0
      ];
A12 = eye(4);
A21 = eye(4);
A22 = [
      0   .2  1  .7;
      .2  0   0  0;
      1   0   0  0;
      .7  0   0  0
      ];
A = {
    A11     A12
    A21     A22
    };

known_multiplex_triangles = {
                 diag(A11.^(1/3)*A22.^(1/3)*A11.^(1/3) + A22.^(1/3)*A11.^(1/3)*A22.^(1/3))
                 };      

g = MultiplexGraphWU(A);
multiplex_triangles = MultiplexTriangles(g);

assert(isequal(multiplex_triangles.getValue(), known_multiplex_triangles), ...
    [BRAPH2.STR ':MultiplexTriangles:' BRAPH2.BUG_ERR], ...
    'MultiplexTriangles is not being calculated correctly for MultiplexGraphWU.')