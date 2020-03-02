% test OutPathLength
graph_class_list = {'GraphBD', 'GraphWD'};

%% Test 1: Calculation AllGraphs
for i = 1:1:length(graph_class_list)
    A = rand(randi(5));
    graph_class = graph_class_list{i};
    g = Graph.getGraph(graph_class, A);
    pathL = g.getMeasure('OutPathLength');
    value = pathL.getValue();
    
    assert(~isempty(value), ...
        ['BRAPH:' graph_class ':OutPathLength'], ...
        ['OutPathLength is not calculated for ' graph_class])
    
end

%% Test 2: Calculation vs Known Values
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
    p = OutPathLength(g);
    p_value = p.getValue();
    p_value = round(p_value, 4);
    
    known_solution = A;
    
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
    
    assert( isequal(p_value, known_solution), ...
        ['BRAPH:OutPathLength: ' graph_class], ...
        ['OutPathLength is not working for: ' graph_class ])
end

%% Test 3: Calculation Harmonic WD vs know Value
A = [
    0   .1  0   0   0
    .2   0  0   0   0
    0    0  0  .2   0
    0    0 .1   0   0
    0    0  0   0   0
    ];
g = GraphWD(A);
p = OutPathLength(g, 'OutPathLengthAvRule', 'harmonic');
p_value = p.getValue();
p_value = round(p_value, 4);

known_solution = [
   40;
   20;
   20;
   40;
   Inf;
    ];

assert( isequal(p_value, known_solution), ...
    ['BRAPH:OutPathLength:Harmonic '], ...
    ['OutPathLength is not working for: Harmonic mean'])

%% Test 4: Calculation subgraphs WD vs know Value
A = [
    0   .1  0   0   0
    .2   0  0   0   0
    0    0  0  .2   0
    0    0 .1   0   0
    0    0  0   0   0
    ];
g = GraphWD(A);
p = OutPathLength(g, 'OutPathLengthAvRule', 'subgraphs');
p_value = p.getValue();
p_value = round(p_value, 4);

known_solution = [
    10;
    5;
    5;
    10;
    0;
    ];

assert( isequal(p_value, known_solution), ...
    ['BRAPH:OutPathLength:Subgraphs '], ...
    ['OutPathLength is not working for: Subgraphs mean'])

%% Test 5: Calculation subgraphs WD vs BCT
A = [
    0   .1  0   0   0
    .2   0  0   0   0
    0    0  0  .2   0
    0    0 .1   0   0
    0    0  0   0   0
    ];
g = GraphWD(A);
p = OutPathLength(g, 'OutPathLengthAvRule', 'subgraphs');
p_value = p.getValue();
p_value = round(p_value,4);

d = Distance(g).getValue();
value_bct = round(charpath(d), 4);

assert( isequal(p_value(1, 1), value_bct), ...
    ['BRAPH:OutPathLength:Subgraphs '], ...
    ['OutPathLength is not working for: modified BCT comparision'])


%% Functions to calculate Out Path Length from 2019_03_03_BCT
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
% Mean of entries of D(G)
% Modified version in order to get the first vector Emiliano Gomez 

Dv = D(1,:);                  % get row 1 for out path length

lambda     = mean((Dv(2:2)));  %  since function is ignoring diagonal and inf in this case

% Efficiency: mean of inverse entries of D(G)
efficiency = mean(1./Dv);

% Eccentricity for each vertex
ecc        = nanmax(D,[],2);

% Radius of graph
radius     = min(ecc);

% Diameter of graph
diameter   = max(ecc);

end