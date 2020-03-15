% test InLocalEfficency
A = rand(randi(5));
graph_class_list = {'GraphBD', 'GraphWD'};

%% Test 1: Calculation AllGraphs
for i = 1:1:length(graph_class_list)
    graph_class = graph_class_list{i};
    g = Graph.getGraph(graph_class, A);
    ecc = InLocalEfficency(g).getValue();
    
    assert(~isempty(ecc), ...
        ['BRAPH:' graph_class ':InLocalEfficency'], ...
        ['InLocalEfficency is not calculated for ' graph_class])
end

%% Test 2: Calculation AllGraphs vs Known Solution
for i = 1:1:length(graph_class_list)
    graph_class = graph_class_list{i};
    A = [
        0 .2 .2 .1;
        .2 0 .3 0;
        .2 .3 0 .3;
        .1 0 .3 0;
        ];
    g = Graph.getGraph(graph_class, A);
    le = InLocalEfficency(g).getValue();
    
    switch (graph_class)
        case 'GraphWD'
            known_solution = [
                .25
                .2
                .1222
                .2
                ];
        case 'GraphBD'
            known_solution = [
                0.8333
                1 
                0.8333
                1
                ];
    end
    
    assert(isequal(round(le, 4), known_solution), ...
        ['BRAPH:' graph_class ':InLocalEfficency'], ...
        ['InLocalEfficency is not calculated for ' graph_class])
end

%% Test 3: Calculation WU subgraphs vs BCT
A = [  
    0 .2 .2 .1;
    .2 0 .3 0;
    .2 .3 0 .3;
    .1 0 .3 0;
    ];
g = Graph.getGraph('GraphBD', A);
le = InLocalEfficency(g).getValue();

[~, ~, bct_value]= rout_efficiency(g.getA());

assert(isequal(le, bct_value), ...
        ['BRAPH:InLocalEfficency'], ...
        ['InLocalEfficency is not calculated for BCT.'])

%% Functions to calculate local efficency from 2019_03_03_BCT
function [GErout,Erout,Eloc] = rout_efficiency(D,transform)
% ROUT_EFFICIENCY       Mean, pair-wise and local routing efficiency
%
%   [GErout,Erout,Eloc] = rout_efficiency(D,transform);
%
%   The routing efficiency is the average of inverse shortest path length.
%
%   The local routing efficiency of a node u is the routing efficiency
%   computed on the subgraph formed by the neighborhood of node u
%   (excluding node u).
%
%
%   Inputs:
%
%       D,
%           Weighted/unweighted directed/undirected
%           connection *weight* OR *length* matrix.
%
%       transform,
%           If the input matrix is a connection *weight* matrix, specify a
%           transform that map input connection weights to connection
%           lengths. Two transforms are available.
%               'log' -> l_ij = -log(w_ij)
%               'inv' -> l_ij =    1/w_ij
%
%           If the input matrix is a connection *length* matrix, do not
%           specify a transform (or specify an empty transform argument).
%
%
%   Outputs:
%
%       GErout,
%           Mean global routing efficiency (scalar).
%
%   	Erout,
%           Pair-wise routing efficiency (matrix).
%
%    	Eloc,
%           Local efficiency (vector)
%
%
%   Note:
%
%       The input matrix may be either a connection weight matrix, or a
%       connection length matrix. The connection length matrix is typically
%       obtained with a mapping from weight to length, such that higher
%       weights are mapped to shorter lengths (see above).
%
%
%   Algorithm:  Floyd–Warshall Algorithm
%
%
%   References:
%       Latora and Marchiori (2001) Phys Rev Lett
%       Goñi et al (2013) PLoS ONE
%       Avena-Koenigsberger et al (2016) Brain Structure and Function
%
%
%   Andrea Avena-Koenigsberger and Joaquin Goñi, IU Bloomington, 2012
%

%   Modification history
%   2012 - original
%   2016 - included comutation of local efficiency
%   2016 - included transform variable that maps strengths onto distances


if ~exist('transform','var')
    transform = [];
end

n=length(D);                                            % number of nodes

Erout = distance_wei_floyd(D,transform);               	% pair-wise routing efficiency
Erout = 1./Erout;
Erout(eye(n)>0) = 0;
GErout = sum(Erout(~eye(n)>0))/(n^2-n);                 % global routing efficiency

%script modified by Emiliano Gomez 10/03/2020
if nargout == 3
    Eloc = zeros(n,1);
    for u = 1:n
        Gu = find(D(u,:) | D(:,u).');                 	% u's neighbors
        nGu = length(Gu);
        e = distance_wei_floyd(D(Gu,Gu),transform);
        e = e.^-1;
        e(1:nGu+1:end) = 0;
        Eloc(u) = mean((sum(e, 2) / (nGu-1)));     	% efficiency of subgraph Gu
    end
end
end

function [SPL,hops,Pmat] = distance_wei_floyd(D,transform)
% DISTANCE_WEI_FLOYD        Distance matrix (Floyd-Warshall algorithm)
%
%   [SPL,hops,Pmat] = distance_wei_floyd(D,transform)
%
%   Computes the topological length of the shortest possible path
%   connecting every pair of nodes in the network.
%
%   Inputs:
%
%       D,
%           Weighted/unweighted directed/undirected 
%           connection *weight* OR *length* matrix.
%
%       transform,
%           If the input matrix is a connection *weight* matrix, specify a
%           transform that map input connection weights to connection
%           lengths. Two transforms are available.
%               'log' -> l_ij = -log(w_ij)
%               'inv' -> l_ij =    1/w_ij
%
%           If the input matrix is a connection *length* matrix, do not
%           specify a transform (or specify an empty transform argument).
%
%
%   Outputs:
%
%       SPL,
%           Unweighted/Weighted shortest path-length matrix.
%           If W is directed matrix, then SPL is not symmetric.
%
%       hops,
%           Number of edges in the shortest path matrix. If W is
%           unweighted, SPL and hops are identical.
%
%       Pmat,
%           Elements {i,j} of this matrix indicate the next node in the
%           shortest path between i and j. This matrix is used as an input
%           argument for function 'retrieve_shortest_path.m', which returns
%           as output the sequence of nodes comprising the shortest path
%           between a given pair of nodes.
%
%
%   Notes:
%
%       There may be more than one shortest path between any pair of nodes
%       in the network. Non-unique shortest paths are termed shortest path
%       degeneracies, and are most likely to occur in unweighted networks.
%       When the shortest-path is degenerate, The elements of matrix Pmat
%       correspond to the first shortest path discovered by the algorithm.
%
%       The input matrix may be either a connection weight matrix, or a
%       connection length matrix. The connection length matrix is typically
%       obtained with a mapping from weight to length, such that higher
%       weights are mapped to shorter lengths (see above).
%
%
%   Algorithm:  Floyd–Warshall Algorithm
%
%
%   Andrea Avena-Koenigsberger, IU, 2012

%   Modification history
%   2016 - included transform variable that maps weights to lengths

if exist('transform','var') && ~isempty(transform)
    
    switch transform
        
        case 'log'
            
            if any((D<0) & D>1)
                error('connection-strengths must be in the interval [0,1) to use the transform -log(w_ij) \n')
            else
                SPL = -log(D);
            end
            
        case 'inv'
            
            SPL = 1./D;
            
        otherwise
            
            error('Unexpected transform type. Only "log" and "inv" are accepted \n')
    end
    
else    % the input is a connection lengths matrix.
    SPL = D;
    SPL(SPL == 0) = inf;
end

n=size(D,2);

if nargout > 1
    flag_find_paths = true;
    hops = double(D ~= 0);
    Pmat = 1:n;
    Pmat = Pmat(ones(n,1),:);
else
    flag_find_paths = false;
end

for k=1:n
    i2k_k2j = bsxfun(@plus, SPL(:,k), SPL(k,:));
    
    if flag_find_paths
        path = bsxfun(@gt, SPL, i2k_k2j);
        [i,j] = find(path);
        hops(path) = hops(i,k) + hops(k,j)';
        Pmat(path) = Pmat(i,k);
    end
    
    SPL = min(SPL, i2k_k2j);
end

SPL(eye(n)>0)=0;

if flag_find_paths
    hops(eye(n)>0)=0;
    Pmat(eye(n)>0)=0;
end
end