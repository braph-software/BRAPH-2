% test Edge Betweenness Centrality

%% Test 1: GraphBU
A = [
    0 1 1; 
    1 0 0; 
    1 0 0
    ];

known_edge_betweenness_centrality = {[
                                0 2 2;
                                2 0 0;
                                2 0 0
                                ]};
g = GraphBU(A);
edge_betweenness_centrality = EdgeBetweennessCentrality(g);

assert(isequal(edge_betweenness_centrality.getValue(), known_edge_betweenness_centrality), ...
    [BRAPH2.STR ':EdgeBetweennessCentrality:' BRAPH2.BUG_ERR], ...
    'EdgeBetweennessCentrality is not being calculated correctly for GraphBU.')

%% Test 2: GraphBD
A = [
    0 1 0; 
    1 0 0; 
    1 0 0
    ];

known_edge_betweenness_centrality = {[
                                0 2 0;
                                1 0 0;
                                2 0 0
                                ]};
g = GraphBD(A);
edge_betweenness_centrality = EdgeBetweennessCentrality(g);

assert(isequal(edge_betweenness_centrality.getValue(), known_edge_betweenness_centrality), ...
    [BRAPH2.STR ':EdgeBetweennessCentrality:' BRAPH2.BUG_ERR], ...
    'EdgeBetweennessCentrality is not being calculated correctly for GraphBD.')

%% Test 3: GraphWU
A = [
    0 1 4
    1 0 0
    4 0 0
    ];

known_edge_betweenness_centrality = {[
                                0 2 2;
                                2 0 0;
                                2 0 0
                                ]};
g = GraphWU(A);
edge_betweenness_centrality = EdgeBetweennessCentrality(g);

assert(isequal(edge_betweenness_centrality.getValue(), known_edge_betweenness_centrality), ...
    [BRAPH2.STR ':EdgeBetweennessCentrality:' BRAPH2.BUG_ERR], ...
    'EdgeBetweennessCentrality is not being calculated correctly for GraphWU.')

%% Test 4: GraphWD
A = [
    0 1 0
    1 0 0
    4 0 0
    ];

known_edge_betweenness_centrality = {[
                                0 2 0;
                                1 0 0;
                                2 0 0
                                ]};
g = GraphWD(A);
edge_betweenness_centrality = EdgeBetweennessCentrality(g);

assert(isequal(edge_betweenness_centrality.getValue(), known_edge_betweenness_centrality), ...
    [BRAPH2.STR ':EdgeBetweennessCentrality:' BRAPH2.BUG_ERR], ...
    'EdgeBetweennessCentrality is not being calculated correctly for GraphWD.')

%% Test 5: MultiplexGraphBU
A11 = [
    0   1   1
    1   0   0
    1   0   0
    ];
A12 = eye(3);
A21 = eye(3);
A22 = [
    0   1   0
    1   0   1
    0   1   0
    ];
A = {
    A11     A12
    A21     A22
    };

known_edge_betweenness_centrality = {[
                                      0 2 2;
                                      2 0 0;
                                      2 0 0
                                     ]
                                     [
                                      0 2 0;
                                      2 0 2;
                                      0 2 0
                                     ]};
g = MultiplexGraphBU(A);
edge_betweenness_centrality = EdgeBetweennessCentrality(g);

assert(isequal(edge_betweenness_centrality.getValue(), known_edge_betweenness_centrality), ...
    [BRAPH2.STR ':EdgeBetweennessCentrality:' BRAPH2.BUG_ERR], ...
    'EdgeBetweennessCentrality is not being calculated correctly for MultiplexGraphBU.')

%% Test 6: MultiplexGraphBD
A11 = [
    0   1   0
    1   0   0
    1   0   0
    ];
A12 = eye(3);
A21 = eye(3);
A22 = [
    0   1   0
    1   0   0
    0   1   0
    ];
A = {
    A11     A12
    A21     A22
    };
known_edge_betweenness_centrality = {[
                                      0 2 0;
                                      1 0 0;
                                      2 0 0
                                     ]
                                     [
                                      0 1 0;
                                      2 0 0;
                                      0 2 0
                                     ]};
g = MultiplexGraphBD(A);
edge_betweenness_centrality = EdgeBetweennessCentrality(g);
assert(isequal(edge_betweenness_centrality.getValue(), known_edge_betweenness_centrality), ...
    [BRAPH2.STR ':EdgeBetweennessCentrality:' BRAPH2.BUG_ERR], ...
    'EdgeBetweennessCentrality is not being calculated correctly for MultiplexGraphBD.')

%% Test 7: MultiplexGraphWU
A11 = [
    0   1   4
    1   0   0
    4   0   0
    ];
A12 = eye(3);
A21 = eye(3);
A22 = [
    0   1   0
    1   0   4
    0   4   0
    ];
A = {
    A11     A12
    A21     A22
    };
known_edge_betweenness_centrality = {[
                                      0 2 2;
                                      2 0 0;
                                      2 0 0
                                     ]
                                     [
                                      0 2 0;
                                      2 0 2;
                                      0 2 0
                                     ]};
g = MultiplexGraphWU(A);
edge_betweenness_centrality = EdgeBetweennessCentrality(g);
assert(isequal(edge_betweenness_centrality.getValue(), known_edge_betweenness_centrality), ...
    [BRAPH2.STR ':EdgeBetweennessCentrality:' BRAPH2.BUG_ERR], ...
    'EdgeBetweennessCentrality is not being calculated correctly for MultiplexGraphWU.')

%% Test 8: MultiplexGraphWD
A11 = [
    0   1   0
    1   0   0
    4   0   0
    ];
A12 = eye(3);
A21 = eye(3);
A22 = [
    0   1   0
    1   0   0
    0   4   0
    ];
A = {
    A11     A12
    A21     A22
    };
known_edge_betweenness_centrality = {[
                                      0 2 0;
                                      1 0 0;
                                      2 0 0
                                     ]
                                     [
                                      0 1 0;
                                      2 0 0;
                                      0 2 0
                                     ]};
g = MultiplexGraphWD(A);
edge_betweenness_centrality = EdgeBetweennessCentrality(g);
assert(isequal(edge_betweenness_centrality.getValue(), known_edge_betweenness_centrality), ...
    [BRAPH2.STR ':EdgeBetweennessCentrality:' BRAPH2.BUG_ERR], ...
    'EdgeBetweennessCentrality is not being calculated correctly for MultiplexGraphWD.')

%% Test 9: Calculation vs BCT
A = rand(randi(5));
g = GraphBU(A); 

edge_betweenness_centrality = EdgeBetweennessCentrality(g).getValue();
edge_betweenness_centrality = edge_betweenness_centrality{1};
edge_betweenness_centrality_bct = edge_betweenness_binary_standard(g.getA());
edge_betweenness_centrality(isnan(edge_betweenness_centrality)) = 0;
edge_betweenness_centrality_bct(isnan(edge_betweenness_centrality_bct)) = 0;

assert(isequal(edge_betweenness_centrality, edge_betweenness_centrality_bct), ...
    [BRAPH2.STR ':EdgeBetweennessCentrality:' BRAPH2.BUG_ERR], ...
    'EdgeBetweennessCentrality is not being calculated correctly for GraphBU BCT.')

g = GraphBD(A);

edge_betweenness_centrality = EdgeBetweennessCentrality(g).getValue();
edge_betweenness_centrality = edge_betweenness_centrality{1};
edge_betweenness_centrality_bct = edge_betweenness_binary_standard(g.getA());
edge_betweenness_centrality(isnan(edge_betweenness_centrality)) = 0;
edge_betweenness_centrality_bct(isnan(edge_betweenness_centrality_bct)) = 0;

assert(isequal(edge_betweenness_centrality, edge_betweenness_centrality_bct), ...
    [BRAPH2.STR ':EdgeBetweennessCentrality:' BRAPH2.BUG_ERR], ...
    'EdgeBetweennessCentrality is not being calculated correctly for GraphBD BCT.')

g = GraphWU(A);

edge_betweenness_centrality = EdgeBetweennessCentrality(g).getValue();
edge_betweenness_centrality = edge_betweenness_centrality{1};
edge_betweenness_centrality_bct = edge_betweenness_weighted_standard(g.getA());
edge_betweenness_centrality(isnan(edge_betweenness_centrality)) = 0;
edge_betweenness_centrality_bct(isnan(edge_betweenness_centrality_bct)) = 0;

assert(isequal(edge_betweenness_centrality, edge_betweenness_centrality_bct), ...
    [BRAPH2.STR ':EdgeBetweennessCentrality:' BRAPH2.BUG_ERR], ...
    'EdgeBetweennessCentrality is not being calculated correctly for GraphWU BCT.')

g = GraphWD(A);

edge_betweenness_centrality = EdgeBetweennessCentrality(g).getValue();
edge_betweenness_centrality = edge_betweenness_centrality{1};
edge_betweenness_centrality_bct = edge_betweenness_weighted_standard(g.getA());
edge_betweenness_centrality(isnan(edge_betweenness_centrality)) = 0;
edge_betweenness_centrality_bct(isnan(edge_betweenness_centrality_bct)) = 0;

assert(isequal(edge_betweenness_centrality, edge_betweenness_centrality_bct), ...
    [BRAPH2.STR ':EdgeBetweennessCentrality:' BRAPH2.BUG_ERR], ...
    'EdgeBetweennessCentrality is not being calculated correctly for GraphWD BCT.')

%% Functions to calculate Edge Betweenness Centrality from 2019_03_03_BCT
function [EBC,BC]=edge_betweenness_binary_standard(G)
n=length(G);
BC=zeros(n,1);                  %vertex betweenness
EBC=zeros(n);                   %edge betweenness

for u=1:n
    D=false(1,n); D(u)=1;      	%distance from u
    NP=zeros(1,n); NP(u)=1;     %number of paths from u
    P=false(n);                 %predecessors
    Q=zeros(1,n); q=n;          %order of non-increasing distance
    
    Gu=G;
    V=u;
    while V
        Gu(:,V)=0;              %remove remaining in-edges
        for v=V
            Q(q)=v; q=q-1;
            W=find(Gu(v,:));                %neighbours of v
            for w=W
                if D(w)
                    NP(w)=NP(w)+NP(v);      %NP(u->w) sum of old and new
                    P(w,v)=1;               %v is a predecessor
                else
                    D(w)=1;
                    NP(w)=NP(v);            %NP(u->w) = NP of new path
                    P(w,v)=1;               %v is a predecessor
                end
            end
        end
        V=find(any(Gu(V,:),1));
    end
    if ~all(D)                              %if some vertices unreachable,
        Q(1:q)=find(~D);                    %...these are first-in-line
    end
    
    DP=zeros(n,1);                          %dependency
    for w=Q(1:n-1)
        BC(w)=BC(w)+DP(w);
        for v=find(P(w,:))
            DPvw=(1+DP(w)).*NP(v)./NP(w);
            DP(v)=DP(v)+DPvw;
            EBC(v,w)=EBC(v,w)+DPvw;
        end
    end
end
end

function [EBC,BC]=edge_betweenness_weighted_standard(G)
n=length(G);
% E=find(G); G(E)=1./G(E);        %invert weights
BC=zeros(n,1);                  %vertex betweenness
EBC=zeros(n);                   %edge betweenness

for u=1:n
    D=inf(1,n); D(u)=0;         %distance from u
    NP=zeros(1,n); NP(u)=1;     %number of paths from u
    S=true(1,n);                %distance permanence (true is temporary)
    P=false(n);                 %predecessors
    Q=zeros(1,n); q=n;          %order of non-increasing distance
    
    G1=G;
    V=u;
    while 1
        S(V)=0;                 %distance u->V is now permanent
        G1(:,V)=0;              %no in-edges as already shortest
        for v=V
            Q(q)=v; q=q-1;
            W=find(G1(v,:));                %neighbours of v
            for w=W
                Duw=D(v)+G1(v,w);           %path length to be tested
                if Duw<D(w)                 %if new u->w shorter than old
                    D(w)=Duw;
                    NP(w)=NP(v);            %NP(u->w) = NP of new path
                    P(w,:)=0;
                    P(w,v)=1;               %v is the only predecessor
                elseif Duw==D(w)            %if new u->w equal to old
                    NP(w)=NP(w)+NP(v);      %NP(u->w) sum of old and new
                    P(w,v)=1;               %v is also a predecessor
                end
            end
        end
        
        minD=min(D(S));
        if isempty(minD), break             %all nodes reached, or
        elseif isinf(minD)                  %...some cannot be reached:
            Q(1:q)=find(isinf(D)); break	%...these are first-in-line
        end
        V=find(D==minD);
    end
    
    DP=zeros(n,1);                          %dependency
    for w=Q(1:n-1)
        BC(w)=BC(w)+DP(w);
        for v=find(P(w,:))
            DPvw=(1+DP(w)).*NP(v)./NP(w);
            DP(v)=DP(v)+DPvw;
            EBC(v,w)=EBC(v,w)+DPvw;
        end
    end
end
end