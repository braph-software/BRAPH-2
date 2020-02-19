% test Triangles
A_BD = [
    0 0 1 1; 
    1 0 0 1; 
    0 1 0 1; 
    0 0 0 0
    ];
triangles_BD = [0 0 0 3]'; % in rule

A_BU = [
    0 1 1 1; 
    1 0 1 0; 
    1 1 0 1; 
    1 0 1 0
    ];
triangles_BU = [2 1 2 1]';

A_test = randn(randi(10));

%% Test 1: Comparison with known BD graph
gBD = GraphBD(A_BD);
mBD = Triangles(gBD,'DirectedTrianglesRule', 'in');
valueBD = mBD.getValue();
assert(isequal(valueBD, triangles_BD), ...
    'BRAPH:Triangles:Bug', ...
    'Triangles is not beeing calculated correctly for GraphBD')

%% Test 2: Comparison with known BU graphs
gBU = GraphBU(A_BU);
mBU = Triangles(gBU);
valueBU = mBU.getValue();
assert(isequal(valueBU, triangles_BU), ...
    'BRAPH:Triangles:Bug', ...
    'Triangles is not beeing calculated correctly for GraphBU')

%% Test 3: Comparison with standard method for BD graphs
gBD_braph2 = GraphBD(A_test); A_BD = gBD_braph2.getA();
mBD_braph2 = Triangles(gBD_braph2, 'DirectedTrianglesRule', 'all');
% calculate the values by Braph2 and standard methods
valueBD_braph2 = mBD_braph2.getValue();
valueBD_std = triangles_standard_BD(A_BD);
assert(isequal(valueBD_braph2, valueBD_std), ...
    'BRAPH:Triangles:Bug', ...
    'Triangles is not beeing calculated correctly for GraphBD')

%% Test 4: Comparison with standard method for BU graphs
gBU_braph2 = GraphBU(A_test); A_BU = gBU_braph2.getA();
mBU_braph2 = Triangles(gBU_braph2);
% calculate the values by Braph2 and standard methods
valueBU_braph2 = mBU_braph2.getValue();
valueBU_std = triangles_standard_BU(A_BU);
assert(isequal(valueBU_braph2, valueBU_std), ...
    'BRAPH:Triangles:Bug', ...
    'Triangles is not beeing calculated correctly for GraphBU')

%% Test 5: Comparison with standard method for WD graphs
gWD_braph2 = GraphWD(A_test); A_WD = gWD_braph2.getA();
mWD_braph2 = Triangles(gWD_braph2, 'DirectedTrianglesRule', 'all');
% calculate the values by Braph2 and standard methods
valueWD_braph2 = mWD_braph2.getValue();
valueWD_std = triangles_standard_WD(A_WD);
assert(isequal(valueWD_braph2, valueWD_std), ...
    'BRAPH:Triangles:Bug', ...
    'Triangles is not beeing calculated correctly for GraphWD')

%% Test 6: Comparison with standard method for WU graphs
gWU_braph2 = GraphWU(A_test); A_WU = gWU_braph2.getA();
mWU_braph2 = Triangles(gWU_braph2);
% calculate the values by Braph2 and standard methods
valueWU_braph2 = mWU_braph2.getValue();
valueWU_std = triangles_standard_WU(A_WU);
assert(isequal(valueWU_braph2, valueWU_std), ...
    'BRAPH:Triangles:Bug', ...
    'Triangles is not beeing calculated correctly for GraphWU')

% Functions to calcualte triangles from 2019_03_03_BCT
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