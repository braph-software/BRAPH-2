%% ¡header!
OverlappingOutDegreeAv < OverlappingOutDegree (m, average overlapping out-degree) is the graph average overlapping out-degree.

%%% ¡description!
The average overlapping out-degree of a graph is the average of the sum of the 
out-degrees of a node in all layers. 

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
M (result, cell) is the average overlapping out-degree.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
overlapping_out_degree_av = calculateValue@OverlappingOutDegree(m, prop);

value = {mean(cell2mat(overlapping_out_degree_av))};

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

known_overlapping_out_degree_av = {mean([2, 3, 1])};

g = MultiplexBD('B', B);
overlapping_out_degree_av = OverlappingOutDegreeAv('G', g);
                 
assert(isequal(overlapping_out_degree_av.get('M'), known_overlapping_out_degree_av), ...
    [BRAPH2.STR ':OverlappingOutDegreeAv:' BRAPH2.BUG_ERR], ...
    'OverlappingOutDegreeAv is not being calculated correctly for MultiplexBD')

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

known_overlapping_out_degree_av = {mean([3, 1, 2])};

g = MultiplexWD('B', B);
overlapping_out_degree_av = OverlappingOutDegreeAv('G', g);

assert(isequal(overlapping_out_degree_av.get('M'), known_overlapping_out_degree_av), ...
    [BRAPH2.STR ':OverlappingOutDegreeAv:' BRAPH2.BUG_ERR], ...
    'OverlappingOutDegreeAv is not being calculated correctly for MultiplexWD.')