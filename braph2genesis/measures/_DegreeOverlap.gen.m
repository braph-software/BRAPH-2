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
MultiplexBU
MultiplexBUD
MultiplexBUT
MultiplexWU

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the degree overlap.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
[l, ls] = g.layernumber();

if l == 0
    value = {};
else
    edge_overlap = calculateValue@EdgeOverlap(m, prop);
    degree_overlap = cell(length(ls), 1);
    
    for i=1:length(ls)
        edge_overlap_partition = edge_overlap{i};
        degree_overlap(i) = {sum(edge_overlap_partition == 1, 2)};
    end
    value = degree_overlap;
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
B = {B11 B22};

known_degree_overlap = {[1 1 0]'};

g = MultiplexBU('B', B);
degree_overlap = DegreeOverlap('G', g);
                 
assert(isequal(degree_overlap.get('M'), known_degree_overlap), ...
    [BRAPH2.STR ':DegreeOverlap:' BRAPH2.BUG_ERR], ...
    'DegreeOverlap is not being calculated correctly for MultiplexBU')

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
B = {B11 B22};

known_degree_overlap = {
                        [1 1 0]'
                        [0 0 0]'};

g = MultiplexBUT('B', B, 'THRESHOLDS', [0 1]);
degree_overlap = DegreeOverlap('G', g);
                 
assert(isequal(degree_overlap.get('M'), known_degree_overlap), ...
    [BRAPH2.STR ':DegreeOverlap:' BRAPH2.BUG_ERR], ...
    'DegreeOverlap is not being calculated correctly for MultiplexBUT')

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