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
MultiplexBU
MultiplexBUD
MultiplexBUT
MultiplexWU

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the multiplex participation.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
[l, ls] = g.layernumber();

if l == 0
    value = {};
else
    N = g.nodenumber();
    degree = Degree('G', g).get('M');
    overlapping_degree = OverlappingDegree('G', g).get('M'); 
    multiplex_participation = cell(length(ls), 1);

    count = 1;
    for i = 1:1:length(ls)
        multiplex_participation_partition = zeros(N(1), 1);
        for li = count:1:ls(i) + count - 1
            multiplex_participation_partition = multiplex_participation_partition + (degree{li}./overlapping_degree{i}).^2;
        end
        multiplex_participation_partition = ls(i) / (ls(i) - 1) * (1 - multiplex_participation_partition);
        multiplex_participation_partition(isnan(multiplex_participation_partition)) = 0;  % Should return zeros, since NaN happens when strength = 0 and overlapping strength = 0 for all regions
        count = count + ls(i);
        multiplex_participation(i) = {multiplex_participation_partition};
    end
    value = multiplex_participation;
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
MultiplexBU
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

g = MultiplexBU('B', B);
multiplex_participation_partition = MultiplexParticipation('G', g);

assert(isequal(multiplex_participation_partition.get('M'), known_multiplex_participation), ...
    [BRAPH2.STR ':MultiplexParticipation:' BRAPH2.BUG_ERR], ...
    'MultiplexParticipation is not being calculated correctly for MultiplexBU.')

%%% ¡test!
%%%% ¡name!
MultiplexBUT
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

known_multiplex_participation = {...
                                [8/9 8/9 1]'
                                [0, 0, 0]'
                                };

g = MultiplexBUT('B', B, 'THRESHOLDS', [0 1]);
multiplex_participation_partition = MultiplexParticipation('G', g);

assert(isequal(multiplex_participation_partition.get('M'), known_multiplex_participation), ...
    [BRAPH2.STR ':MultiplexParticipation:' BRAPH2.BUG_ERR], ...
    'MultiplexParticipation is not being calculated correctly for MultiplexBUT.')

%%% ¡test!
%%%% ¡name!
MultiplexWU
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

g = MultiplexWU('B', B);
multiplex_participation_partition = MultiplexParticipation('G', g);

assert(isequal(multiplex_participation_partition.get('M'), known_multiplex_participation), ...
    [BRAPH2.STR ':MultiplexParticipation:' BRAPH2.BUG_ERR], ...
    'MultiplexParticipation is not being calculated correctly for MultiplexWU.')