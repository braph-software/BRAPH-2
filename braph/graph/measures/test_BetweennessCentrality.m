% test Betweenness Centrality
A_BU = [
    0 1 1;
    1 0 0;
    1 0 0
    ];

bc_BU = [1, 0, 0]';

A_WU = [
    0 1 4; 
    1 0 0; 
    4 0 0 
    ];

bc_WU =[1, 0, 0]'; 

A_test = rand(randi(30));

%% Test 1: Comparison with known BU graph
g = GraphBU(A_BU);
bc_1 = BetweennessCentrality(g).getValue();
bc_2 = bc_BU;
assert(isequal(bc_1, bc_2), ...
    'BRAPH:BetweennessCentrality:Bug', ...
    'Betweenness Centrality is not being calculated correctly for GraphBU')

%% Test 2: Comparison with known WU graph 
g = GraphBD(A_WU);
bc_1 = BetweennessCentrality(g).getValue();
bc_2 = bc_WU;
assert(isequal(bc_1, bc_2), ...
    'BRAPH:BetweennessCentrality:Bug', ...
    'Betweenness Centrality is not being calculated correctly for GraphWU')

%% Test 3: Comparison with standard method for BU graphs
g = GraphBU(A_test);
A_BU = g.getA();
bc_1 = BetweennessCentrality(g).getValue();
bc_2 = betweenness_binary_standard(A_BU);
assert(isequal(bc_1, bc_2), ...
    'BRAPH:BetweennessCentrality:Bug', ...
    'Betweenness Centrality is not being calculated correctly for GraphBU')

%% Test 4: Comparison with standard method for BD graphs 
g = GraphBD(A_test);
A_BD = g.getA();
bc_1 = BetweennessCentrality(g).getValue();
bc_2 = betweenness_binary_standard(A_BD);
assert(isequal(bc_1, bc_2), ...
    'BRAPH:BetweennessCentrality:Bug', ...
    'Betweenness Centrality is not being calculated correctly for GraphBD')

%% Test 5: Comparison with standard method for WU graphs
g = GraphWU(A_test);
A_WU = g.getA();
bc_1 = BetweennessCentrality(g).getValue();
bc_2 = betweenness_weighted_standard(A_WU);
assert(isequal(bc_1, bc_2), ...
    'BRAPH:BetweennessCentrality:Bug', ...
    'Betweenness Centrality is not being calculated correctly for GraphWU')

%% Test 6: Comparison with standard method for WD graphs 
g = GraphWD(A_test);
A_WD = g.getA();
bc_1 = BetweennessCentrality(g).getValue();
bc_2 = betweenness_weighted_standard(A_WD);
assert(isequal(bc_1, bc_2), ...
    'BRAPH:BetweennessCentrality:Bug', ...
    'Betweenness Centrality is not being calculated correctly for GraphWD')

%% Functions to calculate betweenness centrality adapted from 2019_03_03_BCT

% Function for undirected graphs
function bc_standard_B = betweenness_binary_standard(G)
n=length(G);                %number of nodes
I=eye(n)~=0;                %logical identity matrix
d=1;                     	%path length
NPd=G;                      %number of paths of length |d|
NSPd=NPd;                  	%number of shortest paths of length |d|
NSP=NSPd; NSP(I)=1;        	%number of shortest paths of any length
L=NSPd; L(I)=1;           	%length of shortest paths

%calculate NSP and L
while find(NSPd,1)
    d=d+1;
    NPd=NPd*G;
    NSPd=NPd.*(L==0);
    NSP=NSP+NSPd;
    L=L+d.*(NSPd~=0);
end
L(~L)=inf; L(I)=0;          %L for disconnected vertices is inf
NSP(~NSP)=1;                %NSP for disconnected vertices is 1

Gt=G.';
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
end

% Function for directed graphs
function bc_standard_W = betweenness_weighted_standard(G)
n=length(G);
E=find(G); G(E)=1./G(E);        %invert weights
bc_standard_W=zeros(n,1);                  %vertex betweenness

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
        bc_standard_W(w)=bc_standard_W(w)+DP(w);
        for v=find(P(w,:))
            DP(v)=DP(v)+(1+DP(w)).*NP(v)./NP(w);
        end
    end
end
bc_standard_W = bc_standard_W / ((n-1)*(n-2)); % normalization
end