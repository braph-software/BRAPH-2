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