% test Transitivity

%% Test 1: GraphBU
A = [
    0 1 1 1; 
    1 0 1 0; 
    1 1 0 1; 
    1 0 1 0
    ];

known_transitivity = {3/4};

g = GraphBU(A);
transitivity = Transitivity(g);

assert(isequal(transitivity.getValue(), known_transitivity), ...
    [BRAPH2.STR ':Transitivity:' BRAPH2.BUG_ERR], ...
    'Transitivity is not being calculated correctly for GraphBU.')

%% Test 2: GraphBD
A = [
    0 0 1; 
    1 0 0; 
    0 1 0 
    ];

% cycle rule - default
known_transitivity = {1/2};

g = GraphBD(A);
transitivity = Transitivity(g);

assert(isequal(transitivity.getValue(), known_transitivity), ...
    [BRAPH2.STR ':Transitivity:' BRAPH2.BUG_ERR], ...
    'Transitivity is not being calculated correctly for GraphBD.')

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

known_transitivity = {
                 3/4
                 3/4
                 };      

g = MultiplexGraphBU(A);
transitivity = Transitivity(g);

assert(isequal(transitivity.getValue(), known_transitivity), ...
    [BRAPH2.STR ':Transitivity:' BRAPH2.BUG_ERR], ...
    'Transitivity is not being calculated correctly for MultiplexGraphBU.')

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
known_transitivity = {
                 1/2
                 1/2
                 }; 

g = MultiplexGraphBD(A);
transitivity = Transitivity(g, 'DirectedTrianglesRule', 'cycle');

assert(isequal(transitivity.getValue(), known_transitivity), ...
    [BRAPH2.STR ':Transitivity:' BRAPH2.BUG_ERR], ...
    'Transitivity is not being calculated correctly for MultiplexGraphBD.')

%% Test 5: GraphWU: Comparison with standard method 
clear A
A = rand(randi(10));
g = GraphWU(A); 

transitivity = Transitivity(g);
transitivity_bct = transitivity_standard_WU(g.getA());

assert(isequal(transitivity.getValue(), {transitivity_bct}), ...
    [BRAPH2.STR ':Transitivity:' BRAPH2.BUG_ERR], ...
    'Transitivity is not being calculated correctly for BCT.')

%% Test 6: GraphWD: Comparison with standard method 
clear A
A = rand(randi(10));
g = GraphWD(A); 

transitivity = Transitivity(g, 'DirectedTrianglesRule', 'all');
transitivity_bct = transitivity_standard_WD(g.getA());
cl = transitivity.getValue();

assert(isequal(round(cl{1}, 10), round(transitivity_bct, 10)), ...
    [BRAPH2.STR ':Transitivity:' BRAPH2.BUG_ERR], ...
    'Transitivity is not being calculated correctly for BCT.')

%% Test 7: GraphBU: Comparison with standard method 
clear A
A = rand(randi(10));
g = GraphBU(A);

transitivity = Transitivity(g);
transitivity_bct = transitivity_standard_BU(g.getA());

assert(isequal(transitivity.getValue(), {transitivity_bct}), ...
    [BRAPH2.STR ':Transitivity:' BRAPH2.BUG_ERR], ...
    'Transitivity is not being calculated correctly for BCT.')

%% Test 8: GraphBD: Comparison with standard method 
clear A
A = rand(randi(10));
g = GraphBD(A); 

transitivity = Transitivity(g, 'DirectedTrianglesRule', 'all');
transitivity_bct = transitivity_standard_BD(g.getA());

assert(isequal(transitivity.getValue(), {transitivity_bct}), ...
    [BRAPH2.STR ':Transitivity:' BRAPH2.BUG_ERR], ...
    'Transitivity is not being calculated correctly for BCT.')

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
K1=sum(A~=0,2);
K2=sum(A.'~=0,2);
K=sum(K1+K2,2);            	%total degree (in + out)
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