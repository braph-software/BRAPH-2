% test InEccentricity
A = rand(randi(5));
graph_class_list = {'GraphBD', 'GraphWD'};

%% Test 1: Calculation AllGraphs
for i = 1:1:length(graph_class_list)
    graph_class = graph_class_list{i};
    g = Graph.getGraph(graph_class, A);
    ecc = InEccentricity(g).getValue();
    
    assert(~isempty(ecc), ...
        ['BRAPH:' graph_class ':InEccentricity'], ...
        ['InEccentricity is not calculated for ' graph_class])
end

%% Test 2: Calculation AllGraphs vs Known Solution subgraphs
for i = 1:1:length(graph_class_list)
    graph_class = graph_class_list{i};
    A = [
        0   .1  0   0   0
        .2   0  0   0   0
        0    0  0  .2   0
        0    0 .1   0   0
        0    0  0   0   0
        ];
    g = Graph.getGraph(graph_class, A);
    ecc = InEccentricity(g, 'InEccentricityRule', 'subgraphs').getValue();
    
    switch (graph_class)
        case 'GraphWD'
            known_solution = [
                5;
                10;
                10;
                5;
                0;
                ];
            
        case 'GraphBD'
            known_solution = [
                1;
                1;
                1;
                1;
                0;
                ];
    end
    
    assert(isequal(ecc, known_solution), ...
        ['BRAPH:' graph_class ':InEccentricity'], ...
        ['InEccentricity is not calculated for ' graph_class])
end

%% Test 3: Calculation AllGraphs vs Known Solution standard
for i = 1:1:length(graph_class_list)
    graph_class = graph_class_list{i};
    A = [
        0   .1  0   0   0
        .2   0  0   0   0
        0    0  0  .2   0
        0    0 .1   0   0
        0    0  0   0   0
        ];
    g = Graph.getGraph(graph_class, A);
    ecc = InEccentricity(g).getValue();
    
    switch (graph_class)
        case 'GraphWD'
            known_solution = [
                Inf;
                Inf;
                Inf;
                Inf;
                Inf;
                ];
            
        case 'GraphBD'
            known_solution = [
                Inf;
                Inf;
                Inf;
                Inf;
                Inf;
                ];
    end
    
    assert(isequal(ecc, known_solution), ...
        ['BRAPH:' graph_class ':InEccentricity'], ...
        ['InEccentricity is not calculated for ' graph_class])
end

%% Test 4: Calculation WD subgraphs vs BCT

A = [
    0   .1  0   0   0
    .2   0  0   0   0
    0    0  0  .2   0
    0    0 .1   0   0
    0    0  0   0   0
    ];
g = Graph.getGraph('GraphWD', A);
ecc = InEccentricity(g, 'InEccentricityRule', 'subgraphs').getValue();

d = Distance(g).getValue();
[~, ~, bct_value, ~, ~] = charpath(d);

assert(isequal(ecc(1:1), bct_value), ...
    ['BRAPH:InEccentricity:BCT'], ...
    ['InEccentricity is not calculated for BCT.'])

%% Functions to calculate Eccentricity from 2019_03_03_BCT
function  [lambda,efficiency,ecc,radius,diameter] = charpath(D,diagonal_dist,infinite_dist)
%CHARPATH       Characteristic path length, global efficiency and related statistics
%
%   lambda                                  = charpath(D);
%   lambda                                  = charpath(D);
%   [lambda,efficiency]                     = charpath(D);
%   [lambda,efficiency,ecc,radius,diameter] = charpath(D,diagonal_dist,infinite_dist);
%
%   The network characteristic path length is the average shortest path
%   length between all pairs of nodes in the network. The global efficiency
%   is the average inverse shortest path length in the network. The nodal
%   eccentricity is the maximal path length between a node and any other
%   node in the network. The radius is the minimal eccentricity, and the
%   diameter is the maximal eccentricity.
%
%   Input:      D,              distance matrix
%               diagonal_dist   optional argument
%                               include distances on the main diagonal
%                                   (default: diagonal_dist=0)
%               infinite_dist   optional argument
%                               include infinite distances in calculation
%                                   (default: infinite_dist=1)
%
%   Outputs:    lambda,         network characteristic path length
%               efficiency,     network global efficiency
%               ecc,            nodal eccentricity
%               radius,         network radius
%               diameter,       network diameter
%
%   Notes:
%       The input distance matrix may be obtained with any of the distance
%   functions, e.g. distance_bin, distance_wei.
%       Characteristic path length is defined here as the mean shortest
%   path length between all pairs of nodes, for consistency with common
%   usage. Note that characteristic path length is also defined as the
%   median of the mean shortest path length from each node to all other
%   nodes.
%       Infinitely long paths (i.e. paths between disconnected nodes) are
%   included in computations by default. This behavior may be modified with
%   via the infinite_dist argument.
%
%
%   Olaf Sporns, Indiana University, 2002/2007/2008
%   Mika Rubinov, U Cambridge, 2010/2015

%   Modification history
%   2002: original (OS)
%   2010: incorporation of global efficiency (MR)
%   2015: exclusion of diagonal weights by default (MR)
%   2016: inclusion of infinite distances by default (MR)

n = size(D,1);
if any(any(isnan(D)))
    error('The distance matrix must not contain NaN values');
end
if ~exist('diagonal_dist','var') || ~diagonal_dist || isempty(diagonal_dist)
    D(1:n+1:end) = NaN;             % set diagonal distance to NaN
end
if  exist('infinite_dist','var') && ~infinite_dist
    D(isinf(D))  = NaN;             % ignore infinite path lengths
end

Dv = D(~isnan(D));                  % get non-NaN indices of D

% Mean of entries of D(G)
lambda     = mean(Dv);

% Efficiency: mean of inverse entries of D(G)
efficiency = mean(1./Dv);

% Eccentricity for each vertex
% Modified by Emiliano Gomez to get nodal eccentricity.
ecc        = nanmax(D(2:2,1),[],2);

% Radius of graph
radius     = min(ecc);

% Diameter of graph
diameter   = max(ecc);

end