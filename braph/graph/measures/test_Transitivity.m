% test Transitivity
A_BU = [
    0 1 1 1; 
    1 0 1 0; 
    1 1 0 1; 
    1 0 1 0
    ];
transitivity_BU = 0.75;

A_BD = [
    0 0 1; 
    1 0 0; 
    0 1 0 
    ];
transitivity_BD = 0.5; 

A_test = rand(randi(10));

%% Test 1: Comparison with known BU graph
g = GraphBU(A_BU);
transitivity_1 = Transitivity(g).getValue();
transitivity_2 = transitivity_BU;
assert(isequal(transitivity_1, transitivity_2), ...
    'BRAPH:Transitivity:Bug', ...
    'Transitivity is not being calculated correctly for GraphBU')

%% Test 2: Comparison with known BD graph 
g = GraphBD(A_BD);
transitivity_1 = Transitivity(g).getValue();
transitivity_2 = transitivity_BD;
assert(isequal(transitivity_1, transitivity_2), ...
    'BRAPH:Transitivity:Bug', ...
    'Transitivity is not being calculated correctly for GraphBD')

%% Test 3: Comparison with standard method for BU graphs
g = GraphBU(A_test);
A_BU = g.getA();
transitivity_1 = Transitivity(g).getValue();
transitivity_2 = transitivity_standard_BU(A_BU);
assert(isequal(transitivity_1, transitivity_2), ...
    'BRAPH:Transitivity:Bug', ...
    'Transitivity is not being calculated correctly for GraphBU')

%% Test 4: Comparison with standard method for BD graphs 
g = GraphBD(A_test);
A_BD = g.getA();
transitivity_1 = Transitivity(g,'DirectedTrianglesRule', 'all').getValue();
transitivity_2 = transitivity_standard_BD(A_BD);
assert(isequal(transitivity_1, transitivity_2), ...
    'BRAPH:Transitivity:Bug', ...
    'Transitivity is not being calculated correctly for GraphBD')

%% Test 5: Comparison with standard method for WU graphs
g = GraphWU(A_test);
A_WU = g.getA();
transitivity_1 = Transitivity(g).getValue();
transitivity_2 = transitivity_standard_WU(A_WU);
assert(isequal(transitivity_1, transitivity_2), ...
    'BRAPH:Transitivity:Bug', ...
    'Transitivity is not being calculated correctly for GraphWU')

%% Test 6: Comparison with standard method for WD graphs 
g = GraphWD(A_test);
A_WD = g.getA();
transitivity_1 = round(Transitivity(g,'DirectedTrianglesRule', 'all').getValue(),10);
transitivity_2 = round(transitivity_standard_WD(A_WD),10);
assert(isequal(transitivity_1, transitivity_2), ...
    'BRAPH:Transitivity:Bug', ...
    'Transitivity is not being calculated correctly for GraphWD')

%% Functions to calculate transitivity adapted from 2019_03_03_BCT

function stdvalue_BD = transitivity_standard_BD(A)
S    = A+A.';                           % symmetrized input graph
K    = sum(S,2);                        % total degree (in + out)
cyc3 = diag(S^3)/2;                     % number of 3-cycles (ie. directed triangles)
K(cyc3==0)=inf; 
CYC3 = K.*(K-1)-2*diag(A^2);            % number of all possible 3-cycles
stdvalue_BD    = sum(cyc3)./sum(CYC3);            % transitivity
end

function stdvalue_BU = transitivity_standard_BU(A)
stdvalue_BU = trace(A^3) / (sum(sum(A^2)) - trace(A^2));
stdvalue_BU(isnan(stdvalue_BU)) = 0;  % Should return zeros, not NaN
end

function stdvalue_WD = transitivity_standard_WD(A)                 
S    = A.^(1/3)+(A.').^(1/3);      	% symmetrized weights matrix ^1/3
K    = sum(A+A.',2);               	% total degree (in + out)
cyc3 = diag(S^3)/2;                	% number of 3-cycles (ie. directed triangles)
K(cyc3==0)=inf; 
CYC3 = K.*(K-1)-2*diag(A^2);        % number of all possible 3-cycles
stdvalue_WD    = sum(cyc3)./sum(CYC3);       	% transitivity
end

function stdvalue_WU = transitivity_standard_WU(A)      
K    = sum(A~=0,2);            	
cyc3 = diag((A.^(1/3))^3);    
K(cyc3==0)=inf; 
stdvalue_WU    = sum(cyc3)./sum((K.*(K-1)));       %transitivity
end
