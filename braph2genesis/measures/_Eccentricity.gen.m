%% ¡header!
Eccentricity < Measure (m, eccentricity) is the graph eccentricity.

%%% ¡description!
The Eccentricity of a node is the maximal shortest path length between a node and any other node within a layer.

%%% ¡shape!
shape = Measure.NODAL;

%%% ¡scope!
scope = Measure.UNILAYER;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
GraphWU
GraphBU
MultiplexGraphWU
MultiplexGraphBU

%% ¡constants!
RULES = { ... 
        'all' ... % default
        'subgraphs' ...
        };

%% ¡props!
%%% ¡prop! 
rule (metadata, SCALAR) 
%%%% ¡check_prop!
check = value >= 1 & value <= 2;
%%%% ¡default!
1

%% ¡props_update!
%%% ¡prop!
M (result, cell) is the eccentricity.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)

distance = Distance('G', g).get('M'); 
eccentricity_rule = Eccentricity.RULES(m.get('rule'));
bct_eccentricity = cell(g.layernumber(), 1);
for li = 1:1:g.layernumber()
    switch lower(eccentricity_rule{1})
        case {'subgraphs'}
            bct_eccentricity(li)  = {max(distance{li}.*(distance{li}~=Inf), [], 2)};
        case {'all'}
            bct_eccentricity(li)  = {max(distance{li}, [], 2)};
    end
end
value = bct_eccentricity;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphBU
%%%% ¡code!
B = [
    0     .1  .2  .25  0;
    .125  0   0   0    0;
    .2    .5  0   .25  0;
    .125  10  0   0    0;
    0     0   0   0    0
    ];

known_eccentricity_subgraphs = {[1 1 1 1 0]'};
known_eccentricity_default = {[Inf Inf Inf Inf Inf]'};

g = GraphBU('B', B);
m_outside_g = Eccentricity('G', g, 'rule', find(contains(Eccentricity.RULES, 'subgraphs')));
assert(isequal(m_outside_g.get('M'), known_eccentricity_subgraphs), ...
    [BRAPH2.STR ':Eccentricity:' BRAPH2.BUG_ERR], ...
    'Eccentricity is not being calculated correctly for GraphBU.')

g = GraphBU('B', B);
m_inside_g = g.getMeasure('Eccentricity', 'rule', find(contains(Eccentricity.RULES, 'subgraphs')));
assert(isequal(m_inside_g.get('M'), known_eccentricity_subgraphs), ...
    [BRAPH2.STR ':Eccentricity:' BRAPH2.BUG_ERR], ...
    'Eccentricity is not being calculated correctly for GraphBU.')

g = GraphBU('B', B);
m_outside_g = Eccentricity('G', g, 'rule', find(contains(Eccentricity.RULES, 'all')));
assert(isequal(m_outside_g.get('M'), known_eccentricity_default), ...
    [BRAPH2.STR ':Eccentricity:' BRAPH2.BUG_ERR], ...
    'Eccentricity is not being calculated correctly for GraphBU.')

g = GraphBU('B', B);
m_inside_g = g.getMeasure('Eccentricity', 'rule', find(contains(Eccentricity.RULES, 'all')));
assert(isequal(m_inside_g.get('M'), known_eccentricity_default), ...
    [BRAPH2.STR ':Eccentricity:' BRAPH2.BUG_ERR], ...
    'Eccentricity is not being calculated correctly for GraphBU.')

%%% ¡test!
%%%% ¡name!
GraphWU
%%%% ¡code!
B = [
    0     .1  .2  .25  0;
    .125  0   0   0    0;
    .2    .5  0   .25  0;
    .125  10  0   0    0;
    0     0   0   0    0
    ];

known_eccentricity_subgraphs = {[5 5 5 4 0]'};
known_eccentricity_default = {[Inf Inf Inf Inf Inf]'};

g = GraphWU('B', B);
m_outside_g = Eccentricity('G', g, 'rule', find(contains(Eccentricity.RULES, 'subgraphs')));
assert(isequal(m_outside_g.get('M'), known_eccentricity_subgraphs), ...
    [BRAPH2.STR ':Eccentricity:' BRAPH2.BUG_ERR], ...
    'Eccentricity is not being calculated correctly for GraphWU.')

g = GraphWU('B', B);
m_inside_g = g.getMeasure('Eccentricity', 'rule', find(contains(Eccentricity.RULES, 'subgraphs')));
assert(isequal(m_inside_g.get('M'), known_eccentricity_subgraphs), ...
    [BRAPH2.STR ':Eccentricity:' BRAPH2.BUG_ERR], ...
    'Eccentricity is not being calculated correctly for GraphWU.')

g = GraphWU('B', B);
m_outside_g = Eccentricity('G', g, 'rule', find(contains(Eccentricity.RULES, 'all')));
assert(isequal(m_outside_g.get('M'), known_eccentricity_default), ...
    [BRAPH2.STR ':Eccentricity:' BRAPH2.BUG_ERR], ...
    'Eccentricity is not being calculated correctly for GraphWU.')

g = GraphWU('B', B);
m_inside_g = g.getMeasure('Eccentricity', 'rule', find(contains(Eccentricity.RULES, 'all')));
assert(isequal(m_inside_g.get('M'), known_eccentricity_default), ...
    [BRAPH2.STR ':Eccentricity:' BRAPH2.BUG_ERR], ...
    'Eccentricity is not being calculated correctly for GraphWU.')

%%% ¡test!
%%%% ¡name!
MultiplexGraphBU
%%%% ¡code!
B11 = [
      0     .1  .2  .25  0;
      .125  0   0   0    0;
      .2    .5  0   .25  0;
      .125  10  0   0    0;
      0     0   0   0    0
      ];
B22 = [
      0     .1  .2  .25  0;
      .125  0   0   0    0;
      .2    .5  0   .25  0;
      .125  10  0   0    0;
      0     0   0   0    0
      ];
B = {
    B11 B22
    };

known_eccentricity_subgraphs = { 
                               [1 1 1 1 0]'
                               [1 1 1 1 0]'
                               };
known_eccentricity_default = {
                             [Inf Inf Inf Inf Inf]'
                             [Inf Inf Inf Inf Inf]'
                             };

g = MultiplexGraphBU('B', B);
m_outside_g = Eccentricity('G', g, 'rule', find(contains(Eccentricity.RULES, 'subgraphs')));
assert(isequal(m_outside_g.get('M'), known_eccentricity_subgraphs), ...
    [BRAPH2.STR ':Eccentricity:' BRAPH2.BUG_ERR], ...
    'Eccentricity is not being calculated correctly for MultiplexGraphBU.')

g = MultiplexGraphBU('B', B);
m_inside_g = g.getMeasure('Eccentricity', 'rule', find(contains(Eccentricity.RULES, 'subgraphs')));
assert(isequal(m_inside_g.get('M'), known_eccentricity_subgraphs), ...
    [BRAPH2.STR ':Eccentricity:' BRAPH2.BUG_ERR], ...
    'Eccentricity is not being calculated correctly for MultiplexGraphBU.')

g = MultiplexGraphBU('B', B);
m_outside_g = Eccentricity('G', g, 'rule', find(contains(Eccentricity.RULES, 'all')));
assert(isequal(m_outside_g.get('M'), known_eccentricity_default), ...
    [BRAPH2.STR ':Eccentricity:' BRAPH2.BUG_ERR], ...
    'Eccentricity is not being calculated correctly for MultiplexGraphBU.')

g = MultiplexGraphBU('B', B);
m_inside_g = g.getMeasure('Eccentricity', 'rule', find(contains(Eccentricity.RULES, 'all')));
assert(isequal(m_inside_g.get('M'), known_eccentricity_default), ...
    [BRAPH2.STR ':Eccentricity:' BRAPH2.BUG_ERR], ...
    'Eccentricity is not being calculated correctly for MultiplexGraphBU.')

%%% ¡test!
%%%% ¡name!
MultiplexGraphWU
%%%% ¡code!
B11 = [
      0   .2  1
      0   0   .8
      1   0   0
      ];
B22 = [
      0  1   .6
      1  0   .4
      0  .4  0
      ];
B = {
    B11 B22
    };

known_eccentricity_subgraphs = {
                               [5 5 5 4 0]'
                               [5 5 5 4 0]'
                               };
known_eccentricity_default = {
                             [Inf Inf Inf Inf Inf]'
                             [Inf Inf Inf Inf Inf]'
                             };
                           
g = MultiplexGraphWU('B', B);
m_outside_g = Eccentricity('G', g, 'rule', find(contains(Eccentricity.RULES, 'subgraphs')));
assert(isequal(m_outside_g.get('M'), known_eccentricity_subgraphs), ...
    [BRAPH2.STR ':Eccentricity:' BRAPH2.BUG_ERR], ...
    'Eccentricity is not being calculated correctly for MultiplexGraphWU.')

g = MultiplexGraphWU('B', B);
m_inside_g = g.getMeasure('Eccentricity', 'rule', find(contains(Eccentricity.RULES, 'subgraphs')));
assert(isequal(m_inside_g.get('M'), known_eccentricity_subgraphs), ...
    [BRAPH2.STR ':Eccentricity:' BRAPH2.BUG_ERR], ...
    'Eccentricity is not being calculated correctly for MultiplexGraphWU.')

g = MultiplexGraphWU('B', B);
m_outside_g = Eccentricity('G', g, 'rule', find(contains(Eccentricity.RULES, 'all')));
assert(isequal(m_outside_g.get('M'), known_eccentricity_default), ...
    [BRAPH2.STR ':Eccentricity:' BRAPH2.BUG_ERR], ...
    'Eccentricity is not being calculated correctly for MultiplexGraphWU.')

g = MultiplexGraphWU('B', B);
m_inside_g = g.getMeasure('Eccentricity', 'rule', find(contains(Eccentricity.RULES, 'all')));
assert(isequal(m_inside_g.get('M'), known_eccentricity_default), ...
    [BRAPH2.STR ':Eccentricity:' BRAPH2.BUG_ERR], ...
    'Eccentricity is not being calculated correctly for MultiplexGraphWU.')

%%% ¡test!
%%%% ¡name!
Calculation WU subgraphs vs BCT
%%%% ¡code!

B = rand(randi(5));
g = GraphWU('B', B);

distance = Distance('G', g).get('M'); 
[~, ~, bct_eccentricity, ~, ~]= charpath(distance{1});

m_outside_g = Eccentricity('G', g, 'rule', find(contains(Eccentricity.RULES, 'subgraphs')));
calculated_eccentricity = m_outside_g.get('M')
assert(isequal(round(calculated_eccentricity(1), 3), round(bct_eccentricity, 3)), ...
    [BRAPH2.STR ':Eccentricity:' BRAPH2.BUG_ERR], ...
    'Eccentricity is not being calculated correctly for GraphWU.')

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