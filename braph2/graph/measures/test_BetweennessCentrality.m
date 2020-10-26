% test Betweenness Centrality

%% Test 1: GraphBU
A = [
    0 1 1; 
    1 0 0; 
    1 0 0
    ];

known_betweenness_centrality = {[1 0 0]'};

g = GraphBU(A);
betweenness_centrality = BetweennessCentrality(g);

assert(isequal(betweenness_centrality.getValue(), known_betweenness_centrality), ...
    [BRAPH2.STR ':BetweennessCentrality:' BRAPH2.BUG_ERR], ...
    'BetweennessCentrality is not being calculated correctly for GraphBU.')

%% Test 2: GraphBD
A = [
    0 1 0; 
    1 0 0; 
    1 0 0
    ];

known_betweenness_centrality = {[1/2 0 0]'};

g = GraphBD(A);
betweenness_centrality = BetweennessCentrality(g);

assert(isequal(betweenness_centrality.getValue(), known_betweenness_centrality), ...
    [BRAPH2.STR ':BetweennessCentrality:' BRAPH2.BUG_ERR], ...
    'BetweennessCentrality is not being calculated correctly for GraphBD.')

%% Test 3: GraphWU
A = [
    0 1 4
    1 0 0
    4 0 0
    ];

known_betweenness_centrality = {[1 0 0]'};

g = GraphWU(A);
betweenness_centrality = BetweennessCentrality(g);

assert(isequal(betweenness_centrality.getValue(), known_betweenness_centrality), ...
    [BRAPH2.STR ':BetweennessCentrality:' BRAPH2.BUG_ERR], ...
    'BetweennessCentrality is not being calculated correctly for GraphWU')

%% Test 4: GraphWD
A = [
    0 1 0
    1 0 0
    4 0 0
    ];

known_betweenness_centrality = {[1/2 0 0]'};

g = GraphWD(A);
betweenness_centrality = BetweennessCentrality(g);

assert(isequal(betweenness_centrality.getValue(), known_betweenness_centrality), ...
    [BRAPH2.STR ':BetweennessCentrality:' BRAPH2.BUG_ERR], ...
    'BetweennessCentrality is not being calculated correctly for GraphWD')

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

known_betweenness_centrality = {
    [1 0 0]'
    [0 1 0]'
    };

g = MultiplexGraphBU(A);
betweenness_centrality = BetweennessCentrality(g);

assert(isequal(betweenness_centrality.getValue(), known_betweenness_centrality), ...
    [BRAPH2.STR ':BetweennessCentrality:' BRAPH2.BUG_ERR], ...
    'BetweennessCentrality is not being calculated correctly for MultiplexGraphBU.')

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

known_betweenness_centrality = {
    [1/2 0   0]'
    [0   1/2 0]'
    };

g = MultiplexGraphBD(A);
betweenness_centrality = BetweennessCentrality(g);

assert(isequal(betweenness_centrality.getValue(), known_betweenness_centrality), ...
    [BRAPH2.STR ':BetweennessCentrality:' BRAPH2.BUG_ERR], ...
    'BetweennessCentrality is not being calculated correctly for MultiplexGraphBD.')

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

known_betweenness_centrality = {
    [1 0 0]'
    [0 1 0]'
    };

g = MultiplexGraphWU(A);
betweenness_centrality = BetweennessCentrality(g);

assert(isequal(betweenness_centrality.getValue(), known_betweenness_centrality), ...
    [BRAPH2.STR ':BetweennessCentrality:' BRAPH2.BUG_ERR], ...
    'BetweennessCentrality is not being calculated correctly for MultiplexGraphWU.')

%% Test 7: MultiplexGraphWD
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

known_betweenness_centrality = {
    [1/2 0   0]'
    [0   1/2 0]'
    };

g = MultiplexGraphWD(A);
betweenness_centrality = BetweennessCentrality(g);

assert(isequal(betweenness_centrality.getValue(), known_betweenness_centrality), ...
    [BRAPH2.STR ':BetweennessCentrality:' BRAPH2.BUG_ERR], ...
    'BetweennessCentrality is not being calculated correctly for MultiplexGraphWD.')

%% Test 9: Calculation vs BCT
A = rand(randi(5));
g = GraphBU(A); 

betweenness_centrality = BetweennessCentrality(g).getValue();
betweenness_centrality = betweenness_centrality{1};
betweenness_centrality_bct = betweenness_binary_standard(g.getA());

assert(isequal(betweenness_centrality, betweenness_centrality_bct), ...
    [BRAPH2.STR ':BetweennessCentrality:' BRAPH2.BUG_ERR], ...
    'BetweennessCentrality is not being calculated correctly for GraphBU BCT.')

g = GraphBD(A);

betweenness_centrality = BetweennessCentrality(g).getValue();
betweenness_centrality = betweenness_centrality{1};
betweenness_centrality_bct = betweenness_binary_standard(g.getA());

assert(isequal(betweenness_centrality, betweenness_centrality_bct), ...
    [BRAPH2.STR ':BetweennessCentrality:' BRAPH2.BUG_ERR], ...
    'BetweennessCentrality is not being calculated correctly for GraphBD BCT.')

g = GraphWU(A);

betweenness_centrality = BetweennessCentrality(g).getValue();
betweenness_centrality = betweenness_centrality{1};
betweenness_centrality_bct = betweenness_weighted_standard(g.getA());

assert(isequal(betweenness_centrality, betweenness_centrality_bct), ...
    [BRAPH2.STR ':BetweennessCentrality:' BRAPH2.BUG_ERR], ...
    'BetweennessCentrality is not being calculated correctly for GraphWU BCT.')

g = GraphWD(A);

betweenness_centrality = BetweennessCentrality(g).getValue();
betweenness_centrality = betweenness_centrality{1};
betweenness_centrality_bct = betweenness_weighted_standard(g.getA());

assert(isequal(betweenness_centrality, betweenness_centrality_bct), ...
    [BRAPH2.STR ':BetweennessCentrality:' BRAPH2.BUG_ERR], ...
    'BetweennessCentrality is not being calculated correctly for GraphWD BCT.')

%% Functions to calculate betweenness centrality adapted from 2019_03_03_BCT

% Function for undirected graphs
function bc_standard_B = betweenness_binary_standard(A)
n=length(A);                %number of nodes
I=eye(n)~=0;                %logical identity matrix
d=1;                     	%path length
NPd=A;                      %number of paths of length |d|
NSPd=NPd;                  	%number of shortest paths of length |d|
NSP=NSPd; NSP(I)=1;        	%number of shortest paths of any length
L=NSPd; L(I)=1;           	%length of shortest paths

%calculate NSP and L
while find(NSPd,1)
    d=d+1;
    NPd=NPd*A;
    NSPd=NPd.*(L==0);
    NSP=NSP+NSPd;
    L=L+d.*(NSPd~=0);
end
L(~L)=inf; L(I)=0;          %L for disconnected vertices is inf
NSP(~NSP)=1;                %NSP for disconnected vertices is 1

Gt=A.';
DP=zeros(n);            	%vertex on vertex dependency
diam=d-1;                  	%graph diameter

%calculate DP
for d=diam:-1:2
    DPd1=(((L==d).*(1+DP)./NSP)*Gt).*((L==(d-1)).*NSP);
    DP=DP + DPd1;           %DPd1: dependencies on vertices |d-1| from source
end

bc_standard_B=sum(DP,1);               %compute betweenness
bc_standard_B = bc_standard_B';
bc_standard_B = bc_standard_B / ((n-1)*(n-2)); % normalization
bc_standard_B(isnan(bc_standard_B)) = 0; % Should return zeros, not NaN
end

% Function for directed graphs
function bc_standard_W = betweenness_weighted_standard(A)
n=length(A);
E=find(A); A(E)=1./A(E);        %invert weights
bc_standard_W=zeros(n,1);                  %vertex betweenness

for u=1:n
    D=inf(1,n); D(u)=0;         %distance from u
    NP=zeros(1,n); NP(u)=1;     %number of paths from u
    S=true(1,n);                %distance permanence (true is temporary)
    P=false(n);                 %predecessors
    Q=zeros(1,n); q=n;          %order of non-increasing distance

    G1=A;
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
        bc_standard_W(w)=bc_standard_W(w)+DP(w);
        for v=find(P(w,:))
            DP(v)=DP(v)+(1+DP(w)).*NP(v)./NP(w);
        end
    end
end
bc_standard_W = bc_standard_W / ((n-1)*(n-2)); % normalization
bc_standard_W(isnan(bc_standard_W)) = 0; % Should return zeros, not NaN
end