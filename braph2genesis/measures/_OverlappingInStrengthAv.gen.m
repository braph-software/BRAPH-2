%% ¡header!
OverlappingInStrengthAv < OverlappingInStrength (m, average overlapping in-strength) is the graph average overlapping in-strength.

%%% ¡description!
The average overlapping in-strength of a graph is the average of the sum of the 
in-strengths of a node in all layers. 

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
M (result, cell) is the average overlapping in-strength.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
overlapping_in_strength = calculateValue@OverlappingInStrength(m, prop);

value = {mean(overlapping_in_strength{1})};

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
    0   1   .4
    1   0   0
    .7  .3  0
    ];
B = {B11 B22};

known_overlapping_in_strength_av = {mean([3 1.5 1.5])};

g = MultiplexGraphWD('B', B);
overlapping_in_strength_av = OverlappingInStrengthAv('G', g);

assert(isequal(overlapping_in_strength_av.get('M'), known_overlapping_in_strength_av), ...
    [BRAPH2.STR ':OverlappingInStrengthAv:' BRAPH2.BUG_ERR], ...
    'OverlappingInStrengthAv is not being calculated correctly for MultiplexGraphWD.')