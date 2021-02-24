%% ¡header!
OverlappingOutStrengthAv < OverlappingOutStrength (m, average overlapping out-strength) is the graph average overlapping out-strength.

%%% ¡description!
The average overlapping out-strength of a graph is the average of the sum of the 
out-strengths of a node in all layers. 

%%% ¡shape!
shape = Measure.GLOBAL;

%%% ¡scope!
scope = Measure.SUPERGLOBAL;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
MultiplexGraphWD

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the average overlapping out-strength.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
overlapping_out_strength = calculateValue@OverlappingOutStrength(m, prop);

value = {mean(cell2mat(overlapping_out_strength))};

%% ¡tests!

%%% ¡test!
%%%% ¡name!
MultiplexGraphWD
%%%% ¡code!
B11 = [
    0   .2  1
    .3  0   .1
    1   0   0
    ];
B22 = [
    0   1   0
    1   0   0
    .7  .3  0
    ];
B = {B11 B22};

known_overlapping_in_strength_av = {mean([2.2 1.4 2])};

g = MultiplexGraphWD('B', B);
overlapping_in_strength_av = OverlappingOutStrengthAv('G', g);

assert(isequal(overlapping_in_strength_av.get('M'), known_overlapping_in_strength_av), ...
    [BRAPH2.STR ':OverlappingOutStrengthAv:' BRAPH2.BUG_ERR], ...
    'OverlappingOutStrengthAv is not being calculated correctly for MultiplexGraphWD.')