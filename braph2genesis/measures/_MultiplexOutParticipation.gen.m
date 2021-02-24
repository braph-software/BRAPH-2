%% ¡header!
MultiplexOutParticipation < Measure (m, multiplex out-participation) is the graph multiplex out-participation.

%%% ¡description!
The multiplex out-participation is the heterogenerity of the number of outward 
neighbours of a node across the layers.
    
%%% ¡shape!
shape = Measure.NODAL;

%%% ¡scope!
scope = Measure.SUPERGLOBAL;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
MultiplexGraphBD
MultiplexGraphWD

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the multiplex out-participation.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
L = g.layernumber();

if L == 0
    value = {};
else
    
    N = g.nodenumber();
    out_degree = OutDegree('G', g).get('M');
    overlapping_out_degree = OverlappingOutDegree('G', g).get('M');
    multiplex_out_participation =  zeros(N(1), 1);

    for li = 1:1:L
        multiplex_out_participation = multiplex_out_participation + (out_degree{li}./overlapping_out_degree{1}).^2;
    end
    multiplex_out_participation = L / (L - 1) * (1 - multiplex_out_participation);
    multiplex_out_participation(isnan(multiplex_out_participation)) = 0;  % Should return zeros, since NaN happens when strength = 0 and overlapping strength = 0 for all regions
    value = {multiplex_out_participation};
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
MultiplexGraphBD
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

known_multiplex_out_participation = {[8/9 8/9 1]'};

g = MultiplexGraphBD('B', B);
multiplex_out_participation = MultiplexOutParticipation('G', g);

assert(isequal(multiplex_out_participation.get('M'), known_multiplex_out_participation), ...
    [BRAPH2.STR ':MultiplexOutParticipation:' BRAPH2.BUG_ERR], ...
    'MultiplexOutParticipation is not being calculated correctly for MultiplexGraphBD.')

%%% ¡test!
%%%% ¡name!
MultiplexGraphWD
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

known_multiplex_out_participation = {[8/9 8/9 1]'};

g = MultiplexGraphWD('B', B);
multiplex_out_participation = MultiplexOutParticipation('G', g);

assert(isequal(multiplex_out_participation.get('M'), known_multiplex_out_participation), ...
    [BRAPH2.STR ':MultiplexOutParticipation:' BRAPH2.BUG_ERR], ...
    'MultiplexOutParticipation is not being calculated correctly for MultiplexGraphWD.')