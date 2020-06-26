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

% cycle rule - default
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

%% Test 3: MultiplexGraphBU
A11 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];
A12 = eye(4);
A21 = eye(4);
A22 = [
      0 1 1 1;
      1 0 1 0;
      1 1 0 1;
      1 0 1 0
      ];
A = {
    A11     A12
    A21     A22
    };

known_triangles = {
                 [2 1 2 1]'
                 [2 1 2 1]'
                 };      

g = MultiplexGraphBU(A);
triangles = Triangles(g);

assert(isequal(triangles.getValue(), known_triangles), ...
    [BRAPH2.STR ':Triangles:' BRAPH2.BUG_ERR], ...
    'Triangles is not being calculated correctly for MultiplexGraphBU.')

%% Test 4: MultiplexGraphBD
A11 = [
      0 0 1; 
      1 0 0; 
      0 1 0 
      ];
A12 = eye(3);
A21 = eye(3);
A22 = [
      0 0 1; 
      1 0 0; 
      0 1 0 
      ];
A = {
    A11     A12
    A21     A22
    };

% cycle rule - default
known_triangles = {
                 [1 1 1]'
                 [1 1 1]'
                 }; 

g = MultiplexGraphBD(A);
triangles = Triangles(g, 'DirectedTrianglesRule', 'cycle');

assert(isequal(triangles.getValue(), known_triangles), ...
    [BRAPH2.STR ':Triangles:' BRAPH2.BUG_ERR], ...
    'Triangles is not being calculated correctly for MultiplexGraphBD.')

%% Test 5: GraphWU: Comparison with standard method 
A = randn(randi(10));
g = GraphWU(A); 

triangles = Triangles(g);
triangles_bct = triangles_standard_WU(g.getA());

assert(isequal(triangles.getValue(), {triangles_bct}), ...
    [BRAPH2.STR ':Triangles:' BRAPH2.BUG_ERR], ...
    'Triangles is not being calculated correctly for GraphWU.')

%% Test 6: GraphWD: Comparison with standard method 
A = randn(randi(10));
g = GraphWD(A); 

triangles = Triangles(g, 'DirectedTrianglesRule', 'all');
triangles_bct = triangles_standard_WD(g.getA());

assert(isequal(triangles.getValue(), {triangles_bct}), ...
    [BRAPH2.STR ':Triangles:' BRAPH2.BUG_ERR], ...
    'Triangles is not being calculated correctly for GraphWD.')

%% Test 7: GraphBU: Comparison with standard method 
A = randn(randi(10));
g = GraphBU(A); 

triangles = Triangles(g);
triangles_bct = triangles_standard_BU(g.getA());

assert(isequal(triangles.getValue(), {triangles_bct}), ...
    [BRAPH2.STR ':Triangles:' BRAPH2.BUG_ERR], ...
    'Triangles is not being calculated correctly for GraphBU.')

%% Test 6: GraphBD: Comparison with standard method 
A = randn(randi(10));
g = GraphBD(A); 

triangles = Triangles(g, 'DirectedTrianglesRule', 'all');
triangles_bct = triangles_standard_WD(g.getA());

assert(isequal(triangles.getValue(), {triangles_bct}), ...
    [BRAPH2.STR ':Triangles:' BRAPH2.BUG_ERR], ...
    'Triangles is not being calculated correctly for GraphBD.')

% Functions to calculate triangles ADAPTED from 2019_03_03_BCT

function stdvalue_BD = triangles_standard_BD(A)
S=A+A.';                    %symmetrized input graph
cyc3=diag(S^3)/2;           %number of 3-cycles (ie. directed triangles)
stdvalue_BD=cyc3;           %clustering coefficient
end

function stdvalue_BU = triangles_standard_BU(A)
n = length(A);
stdvalue_BU = zeros(n,1);
for u = 1:n
    V = find(A(u,:));
    k = length(V);
    if k>=2                 %degree must be at least 2
        S = A(V,V);
        stdvalue_BU(u) = sum(S(:))/ 2;
    end
end
end

function stdvalue_WD = triangles_standard_WD(A)
S=A.^(1/3)+(A.').^(1/3);	%symmetrized weights matrix ^1/3
cyc3=diag(S^3)/2;           %number of 3-cycles (ie. directed triangles)
stdvalue_WD=cyc3;               %clustering coefficient
end

function stdvalue_WU = triangles_standard_WU(A)
cyc3=diag((A.^(1/3))^3);
stdvalue_WU=cyc3/2;
end