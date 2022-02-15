%% ¡header!
OverlappingInDegreeAv < OverlappingInDegree (m, average overlapping in-degree) is the graph average overlapping in-degree.

%%% ¡description!
The average overlapping in-degree of a graph is the average of the sum of the 
in-degrees of a node in all layers. 

%%% ¡shape!
shape = Measure.GLOBAL;

%%% ¡scope!
scope = Measure.SUPERGLOBAL;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
MultiplexBD
MultiplexWD

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the average overlapping in-degree.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
overlapping_in_degree_av = calculateValue@OverlappingInDegree(m, prop);

value = {mean(cell2mat(overlapping_in_degree_av))};

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
    0   0   0
    ];
B = {B11 B22};

known_overlapping_in_degree_av = {mean([3, 2, 1])};

g = MultiplexBD('B', B);
overlapping_in_degree_av = OverlappingInDegreeAv('G', g);
                 
assert(isequal(overlapping_in_degree_av.get('M'), known_overlapping_in_degree_av), ...
    [BRAPH2.STR ':OverlappingInDegreeAv:' BRAPH2.BUG_ERR], ...
    'OverlappingInDegreeAv is not being calculated correctly for MultiplexBD')

%%% ¡test!
%%%% ¡name!
MultiplexWD
%%%% ¡code!
B11 = [
    0   .4  1
    0   0   0
    1   0   0
    ];
B22 = [
    0   1   0
    1   0   0
    0   .3  0
    ];
B = {B11 B22};

known_overlapping_in_degree_av = {mean([2, 3, 1])};

g = MultiplexWD('B', B);
overlapping_in_degree_av = OverlappingInDegreeAv('G', g);

assert(isequal(overlapping_in_degree_av.get('M'), known_overlapping_in_degree_av), ...
    [BRAPH2.STR ':OverlappingInDegreeAv:' BRAPH2.BUG_ERR], ...
    'OverlappingInDegreeAv is not being calculated correctly for MultiplexWD.')