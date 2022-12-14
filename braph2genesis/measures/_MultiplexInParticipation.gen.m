%% ¡header!
MultiplexInParticipation < Measure (m, multiplex in-participation) is the graph multiplex in-participation.

%%% ¡description!
The multiplex in-participation is the homogeneity of the number of inward 
neighbours of a node across the layers.
    
%%% ¡shape!
shape = Measure.NODAL;

%%% ¡scope!
scope = Measure.SUPERGLOBAL;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
MultiplexBD
MultiplexWD

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the multiplex in-participation.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
L = g.layernumber();

if L == 0
    value = {};
else
    
    N = g.nodenumber();
    in_degree = InDegree('G', g).get('M');
    overlapping_in_degree = OverlappingInDegree('G', g).get('M');  
    multiplex_in_participation =  zeros(N(1), 1);

    for li = 1:1:L
        multiplex_in_participation = multiplex_in_participation + (in_degree{li}./overlapping_in_degree{1}).^2;
    end
    multiplex_in_participation = L / (L - 1) * (1 - multiplex_in_participation);
    multiplex_in_participation(isnan(multiplex_in_participation)) = 0;  % Should return zeros, since NaN happens when strength = 0 and overlapping strength = 0 for all regions
    value = {multiplex_in_participation};
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
MultiplexBD
%%%% ¡code!
B11 = [
    0   1   0
    1   0   0
    1   0   0
    ];
B22 = [
    0   1   0
    1   0   1
    0   1   0
    ];
B33 = [
    0   1   0
    1   0   0
    0   1   0
    ];
B = {B11 B22 B33};

known_multiplex_in_participation = {[15/16 24/25 0]'};

g = MultiplexBD('B', B);
multiplex_in_participation = MultiplexInParticipation('G', g);

assert(isequal(cellfun(@(x)round(x,4),multiplex_in_participation.get('M'),'UniformOutput',false), known_multiplex_in_participation), ...
    [BRAPH2.STR ':MultiplexInParticipation:' BRAPH2.BUG_ERR], ...
    'MultiplexInParticipation is not being calculated correctly for MultiplexBD.')

%%% ¡test!
%%%% ¡name!
MultiplexWD
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

known_multiplex_in_participation = {[8/9 8/9 1]'};

g = MultiplexWD('B', B);
multiplex_in_participation = MultiplexInParticipation('G', g);

assert(isequal(multiplex_in_participation.get('M'), known_multiplex_in_participation), ...
    [BRAPH2.STR ':MultiplexInParticipation:' BRAPH2.BUG_ERR], ...
    'MultiplexInParticipation is not being calculated correctly for MultiplexWD.')