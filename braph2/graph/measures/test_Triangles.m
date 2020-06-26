% test Triangles

%% Test 1: GraphBU
A = [
    0 1 1 1;
    1 0 1 0;
    1 1 0 1;
    1 0 1 0
    ];

known_triangles = {[2 1 2 1]'};

g = GraphBU(A);
triangles = Triangles(g);

assert(isequal(triangles.getValue(), known_triangles), ...
    [BRAPH2.STR ':Triangles:' BRAPH2.BUG_ERR], ...
    'Triangles is not being calculated correctly for GraphBU.')

%% Test 2: GraphBD
A = [
    0 0 1; 
    1 0 0; 
    0 1 0 
    ];

% cycle rule
known_triangles_default_cycle = {[1 1 1]'};

g = GraphBD(A);
triangles = Triangles(g);

assert(isequal(triangles.getValue(), known_triangles_default_cycle), ...
    [BRAPH2.STR ':Triangles:' BRAPH2.BUG_ERR], ...
    'Triangles is not being calculated correctly for GraphBD.')

% in rule 
known_triangles_in = {[0 0 0]'};

g = GraphBD(A);
triangles = Triangles(g, 'DirectedTrianglesRule', 'in');

assert(isequal(triangles.getValue(), known_triangles_in), ...
    [BRAPH2.STR ':Triangles:' BRAPH2.BUG_ERR], ...
    'Triangles is not being calculated correctly for GraphBD.')

% out rule 
known_triangles_out = {[0 0 0]'};

g = GraphBD(A);
triangles = Triangles(g, 'DirectedTrianglesRule', 'out');

assert(isequal(triangles.getValue(), known_triangles_out), ...
    [BRAPH2.STR ':Triangles:' BRAPH2.BUG_ERR], ...
    'Triangles is not being calculated correctly for GraphBD.')

% middleman rule
known_triangles_middleman = {[0 0 0]'};

g = GraphBD(A);
triangles = Triangles(g, 'DirectedTrianglesRule', 'middleman');

assert(isequal(triangles.getValue(), known_triangles_middleman), ...
    [BRAPH2.STR ':Triangles:' BRAPH2.BUG_ERR], ...
    'Triangles is not being calculated correctly for GraphBD.')

% all rule 
known_triangles_all = {[1 1 1]'};

g = GraphBD(A);
triangles = Triangles(g, 'DirectedTrianglesRule', 'all');

assert(isequal(triangles.getValue(), known_triangles_all), ...
    [BRAPH2.STR ':Triangles:' BRAPH2.BUG_ERR], ...
    'Triangles is not being calculated correctly for GraphBD.')