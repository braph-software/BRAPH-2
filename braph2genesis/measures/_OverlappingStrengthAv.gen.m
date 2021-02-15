%% ¡header!
OverlappingStrengthAv < OverlappingStrength (m, overlapping strength) is the graph average overlapping strength.

%%% ¡description!
The average overlapping strength of a graph is the average of the sum of the 
strengths of a node in all layers. 

%%% ¡shape!
shape = Measure.GLOBAL;

%%% ¡scope!
scope = Measure.SUPERGLOBAL;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
MultiplexGraphWU

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the average overlapping strength.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
overlapping_strength = calculateValue@OverlappingStrength(m, prop);

value = {mean(overlapping_strength{1})};

%% ¡tests!

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
B = {B11 B22};

known_overlapping_strength_av = {mean([2.2 1.5 1.3])};

g = MultiplexGraphWU('B', B);
overlapping_strength = OverlappingStrengthAv('G', g);

assert(isequal(overlapping_strength.get('M'), known_overlapping_strength_av), ...
    [BRAPH2.STR ':OverlappingStrength:' BRAPH2.BUG_ERR], ...
    'OverlappingStrength is not being calculated correctly for MultiplexGraphWU.')