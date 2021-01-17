% test Triangles
A_BU = [
    0 1 1 1;
    1 0 1 0;
    1 1 0 1;
    1 0 1 0
    ];
triangles_BU = [2 1 2 1]';

A_BD = [
    0 0 1; 
    1 0 0; 
    0 1 0 
    ];
triangles_BD_cycle = [1 1 1]';  % cycle rule
triangles_BD_in = [0 0 0]';  % in rule 
triangles_BD_out = [0 0 0]';  % out rule 
triangles_BD_mid = [0 0 0]';  % middleman rule 
triangles_BD_all = [1 1 1]';  % all rule 

A_test = randn(randi(10));

%% Test 1: BD graph - default case is cycle
g = GraphBD(A_BD);
triangles_1 = Triangles(g).getValue();
triangles_2 = Triangles(g, 'DirectedTrianglesRule', 'cycle').getValue();
assert(isequal(triangles_1, triangles_2), ...
    'BRAPH:Triangles:Bug', ...
    'Triangles(''DirectedTrianglesRule'', ''cycle'') is not being calculated correctly for GraphBD')

%% Test 2: Comparison with known BD graph - in 
g = GraphBD(A_BD);
triangles_1 = Triangles(g, 'DirectedTrianglesRule', 'in').getValue();
triangles_2 = triangles_BD_in;
assert(isequal(triangles_1, triangles_2), ...
    'BRAPH:Triangles:Bug', ...
    'Triangles(''DirectedTrianglesRule'', ''in'') is not being calculated correctly for GraphBD')

%% Test 3: Comparison with known BD graph - out 
g = GraphBD(A_BD);
triangles_1 = Triangles(g, 'DirectedTrianglesRule', 'out').getValue();
triangles_2 = triangles_BD_out;
assert(isequal(triangles_1, triangles_2), ...
    'BRAPH:Triangles:Bug', ...
    'Triangles(''DirectedTrianglesRule'', ''out'') is not being calculated correctly for GraphBD')

%% Test 4: Comparison with known BD graph - cycle 
g = GraphBD(A_BD);
triangles_1 = Triangles(g, 'DirectedTrianglesRule', 'cycle').getValue();
triangles_2 = triangles_BD_cycle;
assert(isequal(triangles_1, triangles_2), ...
    'BRAPH:Triangles:Bug', ...
    'Triangles(''DirectedTrianglesRule'', ''cycle'') is not being calculated correctly for GraphBD')

%% Test 5: Comparison with known BD graph - middleman 
g = GraphBD(A_BD);
triangles_1 = Triangles(g, 'DirectedTrianglesRule', 'middleman').getValue();
triangles_2 = triangles_BD_mid;
assert(isequal(triangles_1, triangles_2), ...
    'BRAPH:Triangles:Bug', ...
    'Triangles(''DirectedTrianglesRule'', ''middleman'') is not being calculated correctly for GraphBD')

%% Test 6: Comparison with known BD graph - all 
g = GraphBD(A_BD);
triangles_1 = Triangles(g, 'DirectedTrianglesRule', 'all').getValue();
triangles_2 = triangles_BD_all;
assert(isequal(triangles_1, triangles_2), ...
    'BRAPH:Triangles:Bug', ...
    'Triangles(''DirectedTrianglesRule'', ''all'') is not being calculated correctly for GraphBD')

%% Test 7: Comparison with known BU graphs
g = GraphBU(A_BU);
triangles_1 = Triangles(g).getValue();
triangles_2 = triangles_BU;
assert(isequal(triangles_1, triangles_2), ...
    'BRAPH:Triangles:Bug', ...
    'Triangles is not being calculated correctly for GraphBU')

%% Test 8: Comparison with standard method for BD graphs
g = GraphBD(A_test); 
A_BD = g.getA();
triangles_1 = Triangles(g, 'DirectedTrianglesRule', 'all').getValue();
triangles_2 = triangles_standard_BD(A_BD);
assert(isequal(triangles_1, triangles_2), ...
    'BRAPH:Triangles:Bug', ...
    'Triangles(''DirectedTrianglesRule'', ''all'') is not being calculated correctly for GraphBD')

%% Test 9: Comparison with standard method for BU graphs
g = GraphBU(A_test); 
A_BU = g.getA();
triangles_1 = Triangles(g).getValue();
triangles_2 = triangles_standard_BU(A_BU);
assert(isequal(triangles_1, triangles_2), ...
    'BRAPH:Triangles:Bug', ...
    'Triangles is not being calculated correctly for GraphBU')

%% Test 10: Comparison with standard method for WD graphs
g = GraphWD(A_test); 
A_WD = g.getA();
triangles_1 = Triangles(g, 'DirectedTrianglesRule', 'all').getValue();
triangles_2 = triangles_standard_WD(A_WD);
assert(isequal(triangles_1, triangles_2), ...
    'BRAPH:Triangles:Bug', ...
    'Triangles(''DirectedTrianglesRule'', ''all'') is not being calculated correctly for GraphWD')

%% Test 11: Comparison with standard method for WU graphs
g = GraphWU(A_test); 
A_WU = g.getA();
triangles_1 = Triangles(g).getValue();
triangles_2 = triangles_standard_WU(A_WU);
assert(isequal(triangles_1, triangles_2), ...
    'BRAPH:Triangles:Bug', ...
    'Triangles is not being calculated correctly for GraphWU')

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