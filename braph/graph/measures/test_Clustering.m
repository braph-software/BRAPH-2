% test Clustering
A_BU = [
    0 1 1 1; 
    1 0 1 0; 
    1 1 0 1; 
    1 0 1 0
    ];
clustering_BU = [2/3 1 2/3 1]';

A_BD = [
    0 0 1; 
    1 0 0; 
    0 1 0 
    ];
clustering_BD_cycle = [1 1 1]';  % cycle rule
clustering_BD_in = [0 0 0]';  % in rule 
clustering_BD_out = [0 0 0]';  % out rule 
clustering_BD_mid = [0 0 0]';  % middleman rule 
clustering_BD_all = [1/2 1/2 1/2]';  % all rule 

A_test = rand(randi(10));

%% Test 1: Comparison with known BU graph
g = GraphBU(A_BU);
clustering_1 = Clustering(g).getValue();
clustering_2 = clustering_BU;
assert(isequal(clustering_1, clustering_2), ...
    'BRAPH:Clustering:Bug', ...
    'Clustering is not being calculated correctly for GraphBU')

%% Test 2: BD graph - default case is cycle
g = GraphBD(A_BD);
clustering_1 = Clustering(g).getValue();
clustering_2 = Clustering(g, 'DirectedTrianglesRule', 'cycle').getValue();
assert(isequal(clustering_1, clustering_2), ...
    'BRAPH:Clustering:Bug', ...
    'Clustering(''DirectedTrianglesRule'', ''cycle'') is not being calculated correctly for GraphBD')

%% Test 3: Comparison with known BD graph - cycle
g = GraphBD(A_BD);
clustering_1 = Clustering(g, 'DirectedTrianglesRule', 'cycle').getValue();
clustering_2 = clustering_BD_cycle;
assert(isequal(clustering_1, clustering_2), ...
    'BRAPH:Clustering:Bug', ...
    'Clustering(''DirectedTrianglesRule'', ''cycle'') is not being calculated correctly for GraphBD')

%% Test 4: Comparison with known BD graph - in rule
g = GraphBD(A_BD);
clustering_1 = Clustering(g,'DirectedTrianglesRule', 'in').getValue();
clustering_2 = clustering_BD_in;
assert(isequal(clustering_1, clustering_2), ...
    'BRAPH:Clustering:Bug', ...
    'Clustering(''DirectedTrianglesRule'', ''in'') is not being calculated correctly for GraphBD')

%% Test 5: Comparison with known BD graph - out rule
g = GraphBD(A_BD);
clustering_1 = Clustering(g,'DirectedTrianglesRule', 'out').getValue();
clustering_2 = clustering_BD_out;
assert(isequal(clustering_1, clustering_2), ...
    'BRAPH:Clustering:Bug', ...
    'Clustering(''DirectedTrianglesRule'', ''out'') is not being calculated correctly for GraphBD')

%% Test 6: Comparison with known BD graph - middleman rule
g = GraphBD(A_BD);
clustering_1 = Clustering(g,'DirectedTrianglesRule', 'middleman').getValue();
clustering_2 = clustering_BD_mid;
assert(isequal(clustering_1, clustering_2), ...
    'BRAPH:Clustering:Bug', ...
    'Clustering(''DirectedTrianglesRule'', ''middleman'') is not being calculated correctly for GraphBD')

%% Test 7: Comparison with known BD graph - all rule
g = GraphBD(A_BD);
clustering_1 = Clustering(g,'DirectedTrianglesRule', 'all').getValue();
clustering_2 = clustering_BD_all;
assert(isequal(clustering_1, clustering_2), ...
    'BRAPH:Clustering:Bug', ...
    'Clustering(''DirectedTrianglesRule'', ''all'') is not being calculated correctly for GraphBD')

%% Test 8: Comparison with standard method for BU graphs
g = GraphBU(A_test);
A_BU = g.getA();
clustering_1 = Clustering(g).getValue();
clustering_2 = clustering_standard_BU(A_BU);
assert(isequal(clustering_1, clustering_2), ...
    'BRAPH:Clustering:Bug', ...
    'Clustering is not being calculated correctly for GraphBU')

%% Test 9: Comparison with standard method for BD graphs - all
g = GraphBD(A_test);
A_BD = g.getA();
clustering_1 = Clustering(g,'DirectedTrianglesRule', 'all').getValue();
clustering_2 = clustering_standard_BD(A_BD);
assert(isequal(clustering_1, clustering_2), ...
    'BRAPH:Clustering:Bug', ...
    'Clustering(''DirectedTrianglesRule'', ''all'') is not being calculated correctly for GraphBD')

%% Test 10: Comparison with standard method for WU graphs
g = GraphWU(A_test);
A_WU = g.getA();
clustering_1 = Clustering(g).getValue();
clustering_2 = clustering_standard_WU(A_WU);
assert(isequal(clustering_1, clustering_2), ...
    'BRAPH:Clustering:Bug', ...
    'Clustering is not being calculated correctly for GraphWU')

%% Test 11: Comparison with standard method for WD graphs - all
g = GraphWD(A_test);
A_WD = g.getA();
clustering_1 = round(Clustering(g,'DirectedTrianglesRule', 'all').getValue(),10);
clustering_2 = round(clustering_standard_WD(A_WD),10);
assert(isequal(clustering_1, clustering_2), ...
    'BRAPH:Clustering:Bug', ...
    'Clustering(''DirectedTrianglesRule'', ''all'') is not being calculated correctly for GraphWD')

%% Functions to calcualte triangles from 2019_03_03_BCT

function stdvalue_BD = clustering_standard_BD(A)
S=A+A.';                    %symmetrized input graph
K=sum(S,2);                 %total degree (in + out)
cyc3=diag(S^3)/2;          %number of 3-cycles (ie. directed triangles)
K(cyc3==0)=inf;          %if no 3-cycles exist, make C=0 (via K=inf)
CYC3=K.*(K-1)-2*diag(A^2);	%number of all possible 3-cycles
stdvalue_BD=cyc3./CYC3;               %clustering coefficient
end

function stdvalue_BU = clustering_standard_BU(A)
n=length(A);
stdvalue_BU=zeros(n,1);

for u=1:n
    V=find(A(u,:));
    k=length(V);
    if k>=2                 %degree must be at least 2
        S=A(V,V);
        stdvalue_BU(u)=sum(S(:))/(k^2-k);
    end
end

end

function stdvalue_WD = clustering_standard_WD(A)                 
S=A.^(1/3)+(A.').^(1/3);	%symmetrized weights matrix ^1/3
K=sum(A+A.',2);            	%total degree (in + out)
cyc3=diag(S^3)/2;           %number of 3-cycles (ie. directed triangles)
K(cyc3==0)=inf;             %if no 3-cycles exist, make C=0 (via K=inf)
CYC3=K.*(K-1)-2*diag(A^2);	%number of all possible 3-cycles
stdvalue_WD =cyc3./CYC3;               %clustering coefficient
end

function stdvalue_WU = clustering_standard_WU(A)      
K=sum(A~=0,2);
cyc3=diag((A.^(1/3))^3);
K(cyc3==0)=inf;             %if no 3-cycles exist, make C=0 (via K=inf)
stdvalue_WU =cyc3./(K.*(K-1));         %clustering coefficient
end
