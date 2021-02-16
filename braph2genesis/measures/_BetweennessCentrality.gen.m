%% ¡header!
BetweennessCentrality < Measure (m, betweenness centrality) is the graph betweenness centrality.

%%% ¡description!
The betweenness centrality of a graph is the fraction of all shortest paths in the 
graph that pass through a given node. Nodes with high values of betweenness
centrality participate in a large number of shortest paths.

%%% ¡shape!
shape = Measure.NODAL;

%%% ¡scope!
scope = Measure.UNILAYER;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
GraphWU
GraphWD
GraphBU
GraphBD

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the betweenness centrality.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
N = g.nodenumber(); 

betweenness_centrality = cell(g.layernumber(), 1);
connectivity_type =  g.getConnectivityType(g.layernumber());

for li = 1:1:g.layernumber()
    
    if g.is_graph(g)
        Aii = A;
        connectivity_layer = connectivity_type;
    else
        Aii = A{li, li};
        connectivity_layer = connectivity_type(li, li);
    end
    
    if connectivity_layer == Graph.WEIGHTED  % weighted graphs
        betweenness_centrality_layer = m.getWeightedCalculation(Aii)/((N(li)-1)*(N(li)-2));  % Normalized betweenness centrality
        betweenness_centrality(li) = {betweenness_centrality_layer};
    else  % binary graphs
        betweenness_centrality_layer = m.getBinaryCalculation(Aii)/((N(li)-1)*(N(li)-2));  % Normalized betweenness centrality
        betweenness_centrality(li) = {betweenness_centrality_layer};
    end
end

value = betweenness_centrality;

%% ¡methods!
function weighted_betweenness_centrality = getWeightedCalculation(m, A)
    %GETWEIGHTEDCALCULATION calculates the distance value of a weighted adjacency matrix.
    %
    % WEIGHTED_DISTANCE = GETWEIGHTEDCALCULATION(M, A) returns the value of the
    %  distance of a weighted adjacency matrix A.
    
    A = cell2mat(A);
    N = size(A, 2);  % number of nodes
    E = find(A);
    A(E) = 1./A(E);  % invert weights
    weighted_betweenness_centrality = zeros(N, 1);  % init vertex betweenness
    
    % Compute the distances and number of
    % shortest paths between all pairs of vertices
    for u = 1:N  % One search for each source vertex u
        D = inf(1, N);
        D(u) = 0;  % distance from u
        NP = zeros(1, N);
        NP(u) = 1;  % number of paths from u
        S = true(1, N);  % distance permanence S (true is temporary)
        P = false(N);  % predecessors P
        Q = zeros(1, N);  % order of non-increasing distance
        q = N;
        G = A;  % graph G
        V = u;  % set of nodes (V) of graph G
        
        % Forward pass:
        % Compute the shortest paths
        % from the source u to all the other nodes in V
        while 1
            S(V) = 0;  % distance u->V is now permanent
            G(:,V) = 0;  % no in-edges as already shortest
            for v = V
                Q(q) = v;
                q = q-1;
                neighbours = find(G(v,:));  % neighbours of v
                for neighbour = neighbours
                    Duw = D(v) + G(v, neighbour);  % Duw path length to be tested
                    if Duw<D(neighbour)  % if new u->w shorter than old
                        D(neighbour) = Duw;
                        NP(neighbour) = NP(v);  % NP(u->w) = NP of new path
                        P(neighbour,:) = 0;
                        P(neighbour, v) = 1;  % v is the only predecessor
                    elseif Duw==D(neighbour)  % if new u->w equal to old
                        NP(neighbour) = NP(neighbour)+NP(v);  % NP(u->w) sum of old and new
                        P(neighbour, v) = 1;  % v is also a predecessor
                    end
                end
            end
            minD = min(D(S));  % shortest distance
            if isempty(minD), break  % all nodes reached, or
            elseif isinf(minD)  % some cannot be reached:
                Q(1:q) = find(isinf(D)); break  % ...these are first-in-line
            end
            V = find(D==minD);
        end
        
        % Compute dependencies (DP)
        DP = zeros(N, 1);
        for n = Q(1:N-1)
            weighted_betweenness_centrality(n) = weighted_betweenness_centrality(n)+DP(n);  % update betweenness
            for v = find(P(n,:))
                DP(v) = DP(v)+(1+DP(n)).*NP(v)./NP(n);  % dependency
            end
        end
    end
end
function binary_betweenness_centrality = getBinaryCalculation(m, A)
    %GETBINARYCALCULATION calculates the distance value of a binary adjacency matrix.
    %
    % BINARY_DISTANCE = GETBINARYCALCULATION(A) returns the value of the
    %  distance of a binary adjacency matrix A.
    
    A = cell2mat(A);
    N = size(A, 1);  % number of nodes
    I = eye(N)~=0;  % logical identity matrix
    d = 1;  % start path length d
    NPd = A;  % number of paths of length |d|
    NSPd = NPd;  % number of shortest paths of length |d|
    NSP = NSPd;  % number of shortest paths of any length
    NSP(I) = 1;
    L = NSPd;  % length of shortest paths
    L(I) = 1;
    
    % Forward pass: Compute the distance (L) and the number of
    % shortest paths (NSP) between all pairs
    % Compute Path Count:
    while find(NSPd, 1)
        d = d + 1;
        NPd = NPd*A;  % Index value corresponds to number of paths found of length d+1
        NSPd = NPd.*(L==0);
        NSP = NSP + NSPd;  % Add new found shortest paths
        L = L+d.*(NSPd~=0);  % Add new found shortest paths' distance
    end
    L(~L) = inf; L(I) = 0;  % Lenght for disconnected vertices is inf
    NSP(~NSP) = 1;  % NSP for disconnected vertices is 1
    
    % Backward pass: compute the dependencies (DP)
    DP = zeros(N);  % vertex on vertex dependency
    diam = d-1;  % graph diameter
    for d = diam:-1:2  % L == path_length_d is zero for path_length_d = diam
        DPd1 = (((L==d).*(1+DP)./NSP)*(A.')).*((L==(d-1)).*NSP);
        DP = DP + DPd1;  %DPd1: dependencies on vertices |d-1| from source
    end
    binary_betweenness_centrality = sum(DP, 1);  % compute betweenness
    binary_betweenness_centrality = binary_betweenness_centrality';
end     

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBU
%%%% ¡code!
B_BU = [
    0 1 1;
    1 0 0;
    1 0 0
    ];

bc_BU = [1, 0, 0]';

g = GraphBU('B', B_BU);

bc_1 = BetweennessCentrality('G', g).get('M');

assert(isequal(bc_1{1}, bc_BU), ...
    [BRAPH2.STR ':BetweennessCentrality:' BRAPH2.BUG_ERR], ...
    'Betweenness Centrality is not being calculated correctly for GraphBU')

%%% ¡test!
%%%% ¡name!
GraphWU
%%%% ¡code!
B_WU = [
    0 1 4; 
    1 0 0; 
    4 0 0 
    ];

bc_WU =[1, 0, 0]'; 

g = GraphWU('B', B_WU);

bc_1 = BetweennessCentrality('G', g).get('M');
assert(isequal(bc_1{1}, bc_WU), ...
    [BRAPH2.STR ':BetweennessCentrality:' BRAPH2.BUG_ERR], ...
    'Betweenness Centrality is not being calculated correctly for GraphWU')
