% test Clustering

%% Test 1: GraphBU
A = [
    0 1 1 1; 
    1 0 1 0; 
    1 1 0 1; 
    1 0 1 0
    ];

known_clustering = {[2/3 1 2/3 1]'};

g = GraphBU(A);
clustering = Clustering(g);

assert(isequal(clustering.getValue(), known_clustering), ...
    [BRAPH2.STR ':Clustering:' BRAPH2.BUG_ERR], ...
    'Clustering is not being calculated correctly for GraphBU.')

%% Test 2: GraphBD
A = [
    0 0 1; 
    1 0 0; 
    0 1 0 
    ];

% cycle rule - default
known_clustering_default_cycle = {[1 1 1]'};

g = GraphBD(A);
clustering = Clustering(g);

assert(isequal(clustering.getValue(), known_clustering_default_cycle), ...
    [BRAPH2.STR ':Clustering:' BRAPH2.BUG_ERR], ...
    'Clustering is not being calculated correctly for GraphBD.')

% in rule 
known_clustering_in = {[0 0 0]'};

g = GraphBD(A);
clustering = Clustering(g, 'DirectedTrianglesRule', 'in');

assert(isequal(clustering.getValue(), known_clustering_in), ...
    [BRAPH2.STR ':Clustering:' BRAPH2.BUG_ERR], ...
    'Clustering is not being calculated correctly for GraphBD.')

% out rule 
known_clustering_out = {[0 0 0]'};

g = GraphBD(A);
clustering = Clustering(g, 'DirectedTrianglesRule', 'out');

assert(isequal(clustering.getValue(), known_clustering_out), ...
    [BRAPH2.STR ':Clustering:' BRAPH2.BUG_ERR], ...
    'Clustering is not being calculated correctly for GraphBD.')

% middleman rule
known_clustering_middleman = {[0 0 0]'};

g = GraphBD(A);
clustering = Clustering(g, 'DirectedTrianglesRule', 'middleman');

assert(isequal(clustering.getValue(), known_clustering_middleman), ...
    [BRAPH2.STR ':Clustering:' BRAPH2.BUG_ERR], ...
    'Clustering is not being calculated correctly for GraphBD.')

% all rule 
known_clustering_all = {[1/2 1/2 1/2]'};

g = GraphBD(A);
clustering = Clustering(g, 'DirectedTrianglesRule', 'all');

assert(isequal(clustering.getValue(), known_clustering_all), ...
    [BRAPH2.STR ':Clustering:' BRAPH2.BUG_ERR], ...
    'Clustering is not being calculated correctly for GraphBD.')

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

known_clustering = {
                 [2/3 1 2/3 1]'
                 [2/3 1 2/3 1]'
                 };      

g = MultiplexGraphBU(A);
clustering = Clustering(g);

assert(isequal(clustering.getValue(), known_clustering), ...
    [BRAPH2.STR ':Clustering:' BRAPH2.BUG_ERR], ...
    'Clustering is not being calculated correctly for MultiplexGraphBU.')

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
known_clustering = {
                 [1 1 1]'
                 [1 1 1]'
                 }; 

g = MultiplexGraphBD(A);
clustering = Clustering(g, 'DirectedTrianglesRule', 'cycle');

assert(isequal(clustering.getValue(), known_clustering), ...
    [BRAPH2.STR ':Clustering:' BRAPH2.BUG_ERR], ...
    'Clustering is not being calculated correctly for MultiplexGraphBD.')

%% Test 5: GraphWU: Comparison with standard method 
clear A
A = rand(randi(10));
g = GraphWU(A); 

clustering = Clustering(g);
clustering_bct = clustering_standard_WU(g.getA());

assert(isequal(clustering.getValue(), {clustering_bct}), ...
    [BRAPH2.STR ':Clustering:' BRAPH2.BUG_ERR], ...
    'Clustering is not being calculated correctly for GraphWU.')

%% Test 6: GraphWD: Comparison with standard method 
clear A
A = rand(randi(10));
g = GraphWD(A); 

clustering = Clustering(g, 'DirectedTrianglesRule', 'all');
clustering_bct = clustering_standard_WD(g.getA());
cl = clustering.getValue();

assert(isequal(round(cl{1}, 10), round(clustering_bct, 10)), ...
    [BRAPH2.STR ':Clustering:' BRAPH2.BUG_ERR], ...
    'Clustering is not being calculated correctly for GraphWD.')

%% Test 7: GraphBU: Comparison with standard method 
clear A
A = rand(randi(10));
g = GraphBU(A);

clustering = Clustering(g);
clustering_bct = clustering_standard_BU(g.getA());

assert(isequal(clustering.getValue(), {clustering_bct}), ...
    [BRAPH2.STR ':Clustering:' BRAPH2.BUG_ERR], ...
    'Clustering is not being calculated correctly for GraphBU.')

%% Test 8: GraphBD: Comparison with standard method 
clear A
A = rand(randi(10));
g = GraphBD(A); 

clustering = Clustering(g, 'DirectedTrianglesRule', 'all');
clustering_bct = clustering_standard_BD(g.getA());

assert(isequal(clustering.getValue(), {clustering_bct}), ...
    [BRAPH2.STR ':Clustering:' BRAPH2.BUG_ERR], ...
    'Clustering is not being calculated correctly for GraphBD.')

%% Functions to calculate clustering from 2019_03_03_BCT

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
K1=sum(A~=0,2);
K2=sum(A.'~=0,2);
K=sum(K1+K2,2);            	%total degree (in + out)
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