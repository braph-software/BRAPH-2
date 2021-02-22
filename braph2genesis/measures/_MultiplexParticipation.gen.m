%% ¡header!
MultiplexParticipation < Measure (m, multiplex participation) is the graph multiplex participation.

%%% ¡description!
The multiplex participation is the nodal homogeneity of the number of 
neighbours of a node across the layers.
It is calcualted as: Pi = L/(L - 1) [1 - sum_{l=1}^{L} (ki(l)/oi)^2]
where L is the number of layers, ki(l) is the degree in the l-th
layer and oi is the overlapping degree of the node.
Pi = 1 when the degree is the same in all layers and Pi = 0 when a
node has non-zero degree in only one layer.
    
%%% ¡shape!
shape = Measure.NODAL;

%%% ¡scope!
scope = Measure.SUPERGLOBAL;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
MultiplexGraphBU
MultiplexGraphWU

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the multiplex participation.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
B = g.get('A');  % cell array with adjacency matrices
L = g.layernumber();
N = g.nodenumber();

degree = Degree('G', g).get('M');
overlapping_degree = OverlappingDegree('G', g).get('M');

if L > 0   
    multiplex_participation =  zeros(N(1), 1);
else
    multiplex_participation =  zeros(1);
end

for li = 1:1:L
    multiplex_participation = multiplex_participation + (degree{li}./overlapping_degree{1}).^2;
end
multiplex_participation = L / (L - 1) * (1 - multiplex_participation);
multiplex_participation(isnan(multiplex_participation)) = 0;  % Should return zeros, since NaN happens when strength = 0 and overlapping strength = 0 for all regions
value = {multiplex_participation};

%% ¡tests!

%%% ¡test!
%%%% ¡name!
MultiplexGraphBU
%%%% ¡code!
B11 = [
    0   1   1
    1   0   0
    1   0   0
    ];
B22 = [
    0   1   0
    1   0   1
    0   1   0
    ];
B = {B11  B22};

known_multiplex_participation = {[8/9 8/9 1]'};

g = MultiplexGraphBU('B', B);
multiplex_participation = MultiplexParticipation('G', g);

assert(isequal(multiplex_participation.get('M'), known_multiplex_participation), ...
    [BRAPH2.STR ':MultiplexParticipation:' BRAPH2.BUG_ERR], ...
    'MultiplexParticipation is not being calculated correctly for MultiplexGraphBU.')

%%% ¡test!
%%%% ¡name!
MultiplexGraphWU
%%%% ¡code!
B11 = [
    0   .2  1
    .2  0   0
    1   0   0
    ];
B22 = [
    0   1   0
    1   0   .3
    0   .3  0
    ];
B = {B11  B22};

known_multiplex_participation = {[8/9 8/9 1]'};

g = MultiplexGraphWU('B', B);
multiplex_participation = MultiplexParticipation('G', g);

assert(isequal(multiplex_participation.get('M'), known_multiplex_participation), ...
    [BRAPH2.STR ':MultiplexParticipation:' BRAPH2.BUG_ERR], ...
    'MultiplexParticipation is not being calculated correctly for MultiplexGraphWU.')