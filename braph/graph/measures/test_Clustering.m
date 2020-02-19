% test Clustering
A_test = rand(randi(10));
A_BU = [
    0 1 1 1; 
    1 0 1 0; 
    1 1 0 1; 
    1 0 1 0
    ];
clustering_BU = [2/3 ; 1; 2/3; 1];
A_BD_cycle = [
    0 0 1 ; 
    1 0 0 ; 
    0 1 0 
    ];
clustering_BD_cycle = [1;1;1]; % cycle rule
A_BD_in = [
    0 0 1 ; 
    1 0 1 ; 
    0 0 0 
    ];
clustering_BD_in = [0;0;1/2]; % in rule 

%% Test 1: Comparison with known BU graph
g = GraphBU(A_BU);
clustering = Clustering(g);
assert(isequal(clustering.getValue(), clustering_BU), ...
    'BRAPH:Clustering:Bug', ...
    'Clustering is not beeing calculated correctly for GraphBU')

%% Test 2: Comparison with known BD graph - cycle
g = GraphBD(A_BD_cycle);
clustering = Clustering(g);
assert(isequal(clustering.getValue(), clustering_BD_cycle), ...
    'BRAPH:Clustering:Bug', ...
    'Clustering [cycle] is not beeing calculated correctly for GraphBD')

%% Test 3: Comparison with known BD graph - in rule
g = GraphBD(A_BD_in);
clustering = Clustering(g,'DirectedTrianglesRule', 'in');
assert(isequal(clustering.getValue(), clustering_BD_in), ...
    'BRAPH:Clustering:Bug', ...
    'Clustering [in] is not beeing calculated correctly for GraphBD')

%% Test 5: Comparison with standard method for BU graphs
g = GraphBU(A_test);
A_BU = g.getA();
clustering = Clustering(g);
% calculate the values by Braph2 and standard methods
value_braph2 = clustering.getValue();
value_std = clustering_standard_BU(A_BU);
assert(isequal(value_braph2, value_std), ...
    'BRAPH:Clustering:Bug', ...
    'Clustering is not beeing calculated correctly for GraphBU')

%% Test 6: Comparison with standard method for BD graphs - all
g = GraphBD(A_test);
A_BD = g.getA();
clustering = Clustering(g,'DirectedTrianglesRule', 'all');
% calculate the values by Braph2 and standard methods
value_braph2 = clustering.getValue();
value_std = clustering_standard_BD(A_BD);
assert(isequal(value_braph2, value_std), ...
    'BRAPH:Clustering:Bug', ...
    'Clustering [all] is not beeing calculated correctly for GraphBU')

%% Test 7: Comparison with standard method for WU graphs
g = GraphWU(A_test);
A_WU = g.getA();
clustering = Clustering(g);
% calculate the values by Braph2 and standard methods
value_braph2 = clustering.getValue();
value_std = clustering_standard_WU(A_WU);
assert(isequal(value_braph2, value_std), ...
    'BRAPH:Clustering:Bug', ...
    'Clustering is not beeing calculated correctly for GraphWU')

%% Test 8: Comparison with standard method for WD graphs - all
g = GraphWD(A_test);
A_WD = g.getA();
clustering = Clustering(g,'DirectedTrianglesRule', 'all');
% calculate the values by Braph2 and standard methods
value_braph2 = clustering.getValue();
value_std = clustering_standard_WD(A_WD);
assert(isequal(value_braph2, value_std), ...
    'BRAPH:Clustering:Bug', ...
    'Clustering [all] is not beeing calculated correctly for GraphWD')


% Functions to calcualte triangles from 2019_03_03_BCT

function stdvalue_BD = clustering_standard_BD(A)
S=A+A.';                    %symmetrized input graph
K=sum(S,2);                 %total degree (in + out)
cyc3=diag(S^3)/2;           %number of 3-cycles (ie. directed triangles)
K(cyc3==0)=inf;             %if no 3-cycles exist, make C=0 (via K=inf)
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
