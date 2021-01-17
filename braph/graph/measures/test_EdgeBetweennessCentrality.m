% test Edge Betweenness Centrality
A = [
    0   .1  0   0   0
    .2   0  0   0   0
    0    0  0  .2   0
    0    0 .1   0   0
    0    0  0   0   0
    ];
graph_class_list = {'GraphWU', 'GraphBU'};

%% Test 1: Comparison vs known solution
for i = 1:1:length(graph_class_list)
    graph_class = graph_class_list{i};
    g = Graph.getGraph(graph_class, A);
    ebc_1 = EdgeBetweennessCentrality(g).getValue();
    
    switch (graph_class)
        case 'GraphWU'
            ebc_2 =[
                0  1  0   0   0
                1  0  0   0   0
                0  0  0   1   0
                0  0  1   0   0
                0  0  0   0   0
                ];
        case 'GraphBU'
            ebc_2 =[
                0  1  0   0   0
                1  0  0   0   0
                0  0  0   1   0
                0  0  1   0   0
                0  0  0   0   0
                ];
    end    
    
    assert(isequal(ebc_1, ebc_2), ...
        'BRAPH:EdgeBetweennessCentrality:Bug', ...
        ['Edge Betweenness Centrality is not being calculated correctly for ' graph_class])
end


%% Test 2: Calculation vs BCT
for i = 1:1:length(graph_class_list)
    graph_class = graph_class_list{i};
    g = Graph.getGraph(graph_class, A);
    ebc_1 = EdgeBetweennessCentrality(g).getValue();
    
    switch (graph_class)
        case 'GraphWU'
            ebc_2 = edge_betweenness_wei(A);
        case 'GraphBU'
            ebc_2 = edge_betweenness_bin(A);
    end    
    
    assert(isequal(ebc_1, ebc_2), ...
        'BRAPH:EdgeBetweennessCentrality:Bug', ...
        ['Edge Betweenness Centrality is not being calculated correctly for ' graph_class])
end


%% Functions to calculate Edge Betweenness Centrality from 2019_03_03_BCT

function [EBC,BC]=edge_betweenness_bin(G)
%EDGE_BETWEENNESS_BIN    Edge betweenness centrality
%
%   EBC = edge_betweenness_bin(A);
%   [EBC BC] = edge_betweenness_bin(A);
%
%   Edge betweenness centrality is the fraction of all shortest paths in
%   the network that contain a given edge. Edges with high values of
%   betweenness centrality participate in a large number of shortest paths.
%
%   Input:      A,      binary (directed/undirected) connection matrix.
%
%   Output:     EBC,    edge betweenness centrality matrix.
%               BC,     node betweenness centrality vector.
%
%   Note: Betweenness centrality may be normalised to the range [0,1] as
%   BC/[(N-1)(N-2)], where N is the number of nodes in the network.
%
%   Reference: Brandes (2001) J Math Sociol 25:163-177.
%
%
%   Mika Rubinov, UNSW/U Cambridge, 2007-2012


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

function [EBC,BC]=edge_betweenness_wei(G)
%EDGE_BETWEENNESS_WEI    Edge betweenness centrality
%
%   EBC = edge_betweenness_wei(L);
%   [EBC BC] = edge_betweenness_wei(L);
%
%   Edge betweenness centrality is the fraction of all shortest paths in
%   the network that contain a given edge. Edges with high values of
%   betweenness centrality participate in a large number of shortest paths.
%
%   Input:      L,      Directed/undirected connection-length matrix.
%
%   Output:     EBC,    edge betweenness centrality matrix.
%               BC,     nodal betweenness centrality vector.
%
%   Notes:
%       The input matrix must be a connection-length matrix, typically
%   obtained via a mapping from weight to length. For instance, in a
%   weighted correlation network higher correlations are more naturally
%   interpreted as shorter distances and the input matrix should
%   consequently be some inverse of the connectivity matrix.
%       Betweenness centrality may be normalised to the range [0,1] as
%   BC/[(N-1)(N-2)], where N is the number of nodes in the network.
%
%   Reference: Brandes (2001) J Math Sociol 25:163-177.
%
%
%   Mika Rubinov, UNSW/U Cambridge, 2007-2012


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