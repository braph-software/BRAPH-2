% test Distance
A = rand(randi(5));
B = {
    A   A
    A   A
    };
graph_class_distance_list = Distance.getCompatibleGraphList();

%% Test 1: AllGraphs
for i = 1:1:length(graph_class_distance_list)
    graph_class = graph_class_distance_list{i};
    
    if Graph.getGraphType(graph_class) == 1  % single-layer graphs
        g = Graph.getGraph(graph_class, A);
        size_A = size(g.getA());
    else  % non single-layer graphs
        g = Graph.getGraph(graph_class, B);
        size_A = size(g.getA(1));  % size A first layer
    end
    
    distance = Distance(g);
    value = distance.getValue();
    
    assert(~isempty(value), ...
        [BRAPH2.STR ':' graph_class ':' BRAPH2.WRONG_OUTPUT], ...
        ['Distance is not calculated for ' graph_class])
    
    assert(isequal(size(value{1}), size_A), ...
        [BRAPH2.STR ':' graph_class ':' BRAPH2.WRONG_OUTPUT], ...
        ['Distance dim is not correct for ' graph_class])
end

%% Test 2: Calculation vs Known Values
for i = 1:1:length(graph_class_distance_list)
    graph_class = graph_class_distance_list{i};
    
    n = 5;
    L = [
        0 .1 .2 .25 0; 
        .125 0 0 0 0; 
        .2 .5 0 .25 0; 
        .125 10 0 0 0
        ];
    A = [L;zeros(1,n)];
    B = {A, A; A, A};
    
    if Graph.getGraphType(graph_class) == 1  % single-layer graphs
        g = Graph.getGraph(graph_class, A);
        known_solution = {A};
    else
        g = Graph.getGraph(graph_class, B);
        known_solution = {A; A};
    end
    dg = Distance(g);
    dg_value = dg.getValue();
    
    switch (graph_class)
        case 'GraphWD'
            solution = [
                0 5 5 4 Inf;
                8 0 13 12 Inf;
                5 2 0 4 Inf;
                8 1 13 0 Inf;
                Inf Inf Inf Inf 0;
                ];
            known_solution = {solution};
            
        case 'GraphWU'
            solution = [
                0 5 5 4 Inf;
                5 0 2 1 Inf;
                5 2 0 3 Inf;
                4 1 3 0 Inf;
                Inf Inf Inf Inf 0;
                ];
            known_solution = {solution};
            
        case 'GraphBD'
            solution = [
                0 1 1 1 Inf;
                1 0 2 2 Inf;
                1 1 0 1 Inf;
                1 1 2 0 Inf;
                Inf Inf Inf Inf 0;
                ];
            known_solution = {solution};
            
        case 'GraphBU'
            solution = [
                0 1 1 1 Inf;
                1 0 1 1 Inf;
                1 1 0 1 Inf;
                1 1 1 0 Inf;
                Inf Inf Inf Inf 0;
                ];
            known_solution = {solution};
            
        case 'MultiplexGraphWD'
            solution = [
                0 5 5 4 Inf;
                8 0 13 12 Inf;
                5 2 0 4 Inf;
                8 1 13 0 Inf;
                Inf Inf Inf Inf 0;
                ];
            known_solution = {solution; solution};
            
        case 'MultiplexGraphWU'
            solution = [
                0 5 5 4 Inf;
                5 0 2 1 Inf;
                5 2 0 3 Inf;
                4 1 3 0 Inf;
                Inf Inf Inf Inf 0;
                ];
            known_solution = {solution; solution};
            
        case 'MultiplexGraphBD'
            solution = [
                0 1 1 1 Inf;
                1 0 2 2 Inf;
                1 1 0 1 Inf;
                1 1 2 0 Inf;
                Inf Inf Inf Inf 0;
                ];
            known_solution = {solution; solution};
            
        case 'MultiplexGraphBU'
            solution = [
                0 1 1 1 Inf;
                1 0 1 1 Inf;
                1 1 0 1 Inf;
                1 1 1 0 Inf;
                Inf Inf Inf Inf 0;
                ];
            known_solution = {solution; solution};
    end
    
    assert( isequal(dg_value, known_solution), ...
        [BRAPH2.STR ':Distance:' BRAPH2.BUG_ERR], ...
        ['Distance is not working for: ' graph_class ])
end

%% Test 3: Calculation vs BCT
A = rand(randi(5));
for i = 1:1:length(graph_class_distance_list)/2
    graph_class = graph_class_distance_list{i};
    g = Graph.getGraph(graph_class, A);
    distance = Distance(g);
    value_distance = distance.getValue();
    
    switch(graph_class)
        case 'GraphBD'
            A(1:length(A)+1:end) = 0;
            A(A<0) = 0;
            A(A>0) = 1;
        case 'GraphBU'
            A(1:length(A)+1:end) = 0;
            A(A<0) = 0;
            A(A>0) = 1;
            A = max(A, A');
        case 'GraphWD'
            A(1:length(A)+1:end) = 0;
            A(A<0) = 0;
            A = standardize(A);
        case 'GraphWU'
            A(1:length(A)+1:end) = 0;
            A(A<0) = 0;
            A = max(A, A');
            A = standardize(A);
    end

    if g.is_weighted(graph_class)
        ind = A~=0;
        A(ind) = A(ind).^-1;
        value_bct = distance_wei(A);
    else
        value_bct = distance_bin(A);
    end
    
    assert(isequal(value_distance{1}, value_bct), ...
        ['BRAPH:' graph_class ':Distance'], ...
        ['Distance is not calculated for ' graph_class])
    
end

% Functions from 2019_03_03_BCT
function [D,B]=distance_wei(L)
% DISTANCE_WEI       Distance matrix (Dijkstra's algorithm)
%
%   D = distance_wei(L);
%   [D,B] = distance_wei(L);
%
%   The distance matrix contains lengths of shortest paths between all
%   pairs of nodes. An entry (u,v) represents the length of shortest path
%   from node u to node v. The average shortest path length is the
%   characteristic path length of the network.
%
%   Input:      L,      Directed/undirected connection-length matrix.
%   *** NB: The length matrix L isn't the weights matrix W (see below) ***
%
%   Output:     D,      distance (shortest weighted path) matrix
%               B,      number of edges in shortest weighted path matrix
%
%   Notes:
%       The input matrix must be a connection-length matrix, typically
%   obtained via a mapping from weight to length. For instance, in a
%   weighted correlation network higher correlations are more naturally
%   interpreted as shorter distances and the input matrix should
%   consequently be some inverse of the connectivity matrix.
%       The number of edges in shortest weighted paths may in general
%   exceed the number of edges in shortest binary paths (i.e. shortest
%   paths computed on the binarized connectivity matrix), because shortest
%   weighted paths have the minimal weighted distance, but not necessarily
%   the minimal number of edges.
%       Lengths between disconnected nodes are set to Inf.
%       Lengths on the main diagonal are set to 0.
%
%   Algorithm: Dijkstra's algorithm.
%
%
%   Mika Rubinov, UNSW/U Cambridge, 2007-2012.
%   Rick Betzel and Andrea Avena, IU, 2012

%Modification history
%2007: original (MR)
%2009-08-04: min() function vectorized (MR)
%2012: added number of edges in shortest path as additional output (RB/AA)
%2013: variable names changed for consistency with other functions (MR)

n=length(L);
D=inf(n);
D(1:n+1:end)=0;                             %distance matrix
B=zeros(n);                                 %number of edges matrix

for u=1:n
    S=true(1,n);                            %distance permanence (true is temporary)
    L1=L;
    V=u;
    while 1
        S(V)=0;                             %distance u->V is now permanent
        L1(:,V)=0;                          %no in-edges as already shortest
        for v=V
            T=find(L1(v,:));                %neighbours of shortest nodes
            [d,wi]=min([D(u,T);D(u,v)+L1(v,T)]);
            D(u,T)=d;                       %smallest of old/new path lengths
            ind=T(wi==2);                   %indices of lengthened paths
            B(u,ind)=B(u,v)+1;              %increment no. of edges in lengthened paths
        end
        
        minD=min(D(u,S));
        if isempty(minD)||isinf(minD)       %isempty: all nodes reached;
            break,                          %isinf: some nodes cannot be reached
        end
        
        V=find(D(u,:)==minD);
    end
end
end

function D=distance_bin(A)
%DISTANCE_BIN       Distance matrix
%
%   D = distance_bin(A);
%
%   The distance matrix contains lengths of shortest paths between all
%   pairs of nodes. An entry (u,v) represents the length of shortest path
%   from node u to node v. The average shortest path length is the
%   characteristic path length of the network.
%
%   Input:      A,      binary directed/undirected connection matrix
%
%   Output:     D,      distance matrix
%
%   Notes:
%       Lengths between disconnected nodes are set to Inf.
%       Lengths on the main diagonal are set to 0.
%
%   Algorithm: Algebraic shortest paths.
%
%
%   Mika Rubinov, U Cambridge
%   Jonathan Clayden, UCL
%   2007-2013

% Modification history:
% 2007: Original (MR)
% 2013: Bug fix, enforce zero distance for self-connections (JC)

A=double(A~=0);                 %binarize and convert to double format

l=1;                            %path length
Lpath=A;                        %matrix of paths l
D=A;                            %distance matrix

Idx=true;
while any(Idx(:))
    l=l+1;
    Lpath=Lpath*A;
    Idx=(Lpath~=0)&(D==0);
    D(Idx)=l;
end

D(~D)=inf;                      %assign inf to disconnected nodes
D(1:length(A)+1:end)=0;         %clear diagonal
end