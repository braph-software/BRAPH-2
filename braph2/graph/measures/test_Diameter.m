% test Diameter

%% Test 1: GraphBU
A = [
    0     .1  .2  .25  0;
    .125  0   0   0    0;
    .2    .5  0   .25  0;
    .125  10  0   0    0;
    0     0   0   0    0
    ];
    
known_diameter_subgraphs = {[1]};

g = GraphBU(A);
diameter = Diameter(g, 'EccentricityRule', 'subgraphs');

assert(isequal(diameter.getValue(), known_diameter_subgraphs), ...
    [BRAPH2.STR ':Diameter:' BRAPH2.BUG_ERR], ...
    'Diameter is not being calculated correctly for GraphBU.')

known_diameter_default = {[Inf]'};

diameter = Diameter(g, 'EccentricityRule', 'default');

assert(isequal(diameter.getValue(), known_diameter_default), ...
    [BRAPH2.STR ':Diameter:' BRAPH2.BUG_ERR], ...
    'Diameter is not being calculated correctly for GraphBU.')

%% Test 2: GraphWU
A = [
    0     .1  .2  .25  0;
    .125  0   0   0    0;
    .2    .5  0   .25  0;
    .125  10  0   0    0;
    0     0   0   0    0
    ];
    
known_diameter_subgraphs = {[5]};

g = GraphWU(A);
diameter = Diameter(g, 'EccentricityRule', 'subgraphs');

assert(isequal(diameter.getValue(), known_diameter_subgraphs), ...
    [BRAPH2.STR ':Diameter:' BRAPH2.BUG_ERR], ...
    'Diameter is not being calculated correctly for GraphWU.')

known_diameter_default = {[Inf]};

diameter = Diameter(g, 'EccentricityRule', 'default');

assert(isequal(diameter.getValue(), known_diameter_default), ...
    [BRAPH2.STR ':Diameter:' BRAPH2.BUG_ERR], ...
    'Diameter is not being calculated correctly for GraphWU.')

%% Test 3: MultiplexGraphBU
A11 = [
    0     .1  .2  .25  0;
    .125  0   0   0    0;
    .2    .5  0   .25  0;
    .125  10  0   0    0;
    0     0   0   0    0
    ];
A12 = eye(5);
A21 = eye(5);
A22 = [
    0     .1  .2  .25  0;
    .125  0   0   0    0;
    .2    .5  0   .25  0;
    .125  10  0   0    0;
    0     0   0   0    0
    ];

A = {
    A11     A12
    A21     A22
    };

known_diameter_subgraphs = {
                                [1]
                                [1]
                                };

g = MultiplexGraphBU(A);
diameter = Diameter(g, 'EccentricityRule', 'subgraphs');

assert(isequal(diameter.getValue(), known_diameter_subgraphs), ...
    [BRAPH2.STR ':Diameter:' BRAPH2.BUG_ERR], ...
    'Diameter is not being calculated correctly for MultiplexGraphBU.')

known_diameter_default = {
                          [Inf]
                          [Inf]
                         };

diameter = Diameter(g);

assert(isequal(diameter.getValue(), known_diameter_default), ...
    [BRAPH2.STR ':Diameter:' BRAPH2.BUG_ERR], ...
    'Diameter is not being calculated correctly for MultiplexGraphBU.')

%% Test 4: MultiplexGraphWU
A11 = [
    0     .1  .2  .25  0;
    .125  0   0   0    0;
    .2    .5  0   .25  0;
    .125  10  0   0    0;
    0     0   0   0    0
    ];
A12 = eye(5);
A21 = eye(5);
A22 = [
    0     .1  .2  .25  0;
    .125  0   0   0    0;
    .2    .5  0   .25  0;
    .125  10  0   0    0;
    0     0   0   0    0
    ];

A = {
    A11     A12
    A21     A22
    };

known_diameter_subgraphs = {
                            [5]
                            [5]
                           };

g = MultiplexGraphWU(A);
diameter = Diameter(g, 'EccentricityRule', 'subgraphs');

assert(isequal(diameter.getValue(), known_diameter_subgraphs), ...
    [BRAPH2.STR ':Diameter:' BRAPH2.BUG_ERR], ...
    'Diameter is not being calculated correctly for MultiplexGraphWU.')

known_diameter_default = {
                          [Inf]
                          [Inf]
                         };

diameter = Diameter(g);

assert(isequal(diameter.getValue(), known_diameter_default), ...
    [BRAPH2.STR ':Diameter:' BRAPH2.BUG_ERR], ...
    'Diameter is not being calculated correctly for MultiplexGraphWU.')

%% Test 5: Calculation WU subgraphs vs BCT
A = [
    0     .1  .2  .25  0;
    .125  0   0   0    0;
    .2    .5  0   .25  0;
    .125  10  0   0    0;
    0     0   0   0    0
    ];
g = GraphWU(A);
diameter = Diameter(g, 'EccentricityRule', 'subgraphs').getValue();

distance = Distance(g).getValue();
[~, ~, ~, ~, diameter_bct]= charpath(distance{1});
round(cell2mat(diameter), 3)
round(diameter_bct, 3)
assert(isequal(round(cell2mat(diameter), 3), round(diameter_bct, 3)), ...
        [BRAPH2.STR ':Diameter:' BRAPH2.BUG_ERR], ...
        'Diameter is not being calculated correctly for BCT.')

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
D(D==Inf) = 0;
ecc        = nanmax(D(1,:),[],2);
ecc(isnan(ecc)) = 0;

% Radius of graph
radius     = min(ecc);

% Diameter of graph
diameter   = max(ecc);

end