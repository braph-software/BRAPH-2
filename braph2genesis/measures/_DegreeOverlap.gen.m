%% ¡header!
DegreeOverlap < EdgeOverlap (m, degree overlap) is the graph degree overlap.

%%% ¡description!
The degree overlap is the number of edges connected to the node in all layers. 
Connection weights are ignored in calculations.

%%% ¡shape!
shape = Measure.NODAL;

%%% ¡scope!
scope = Measure.SUPERGLOBAL;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
MultiplexGraphBU
MultiplexWU

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the degree overlap.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class

edge_overlap = calculateValue@EdgeOverlap(m, prop);	
degree_overlap = {sum(edge_overlap{1} == 1, 2)};

value = degree_overlap;

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
B = {B11 B22};

known_degree_overlap = {[1 1 0]'};

g = MultiplexGraphBU('B', B);
degree_overlap = DegreeOverlap('G', g);
                 
assert(isequal(degree_overlap.get('M'), known_degree_overlap), ...
    [BRAPH2.STR ':DegreeOverlap:' BRAPH2.BUG_ERR], ...
    'DegreeOverlap is not being calculated correctly for MultiplexGraphBU')

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
B = {B11 B22};

known_degree_overlap = {[1 1 0]'};

g = MultiplexWU('B', B);
degree_overlap = DegreeOverlap('G', g);

assert(isequal(degree_overlap.get('M'), known_degree_overlap), ...
    [BRAPH2.STR ':DegreeOverlap:' BRAPH2.BUG_ERR], ...
    'DegreeOverlap is not being calculated correctly for MultiplexWU')