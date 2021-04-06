%% ¡header!
OverlappingDegree < Degree (m, overlapping degree) is the graph overlapping degree.

%%% ¡description!
The overlapping degree of a graph is the sum of the degrees of a node in
all layers. 

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
M (result, cell) is the overlapping degree.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
[ls, l] = g.layernumber();

if ls == 0
    value = {};
else
    N = g.nodenumber();
    degree = calculateValue@Degree(m, prop);
    overlapping_degree = cell(length(l), 1);
    
    count = 1;
    for i = 1:1:length(l)
        overlapping_degree_partition = zeros(N(1), 1);
        for li = count:1:l(i) + count - 1
            overlapping_degree_partition = overlapping_degree_partition + degree{li};
        end
        count = count + l(i);
        overlapping_degree(i) = {overlapping_degree_partition};
    end
    value = overlapping_degree;
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

known_overlapping_degree = {[3, 3, 2]'};

g = MultiplexBU('B', B);
overlapping_degree = OverlappingDegree('G', g);
                 
assert(isequal(overlapping_degree.get('M'), known_overlapping_degree), ...
    [BRAPH2.STR ':OverlappingDegree:' BRAPH2.BUG_ERR], ...
    'OverlappingDegree is not being calculated correctly for MultiplexBU')

%%% ¡test!
%%%% ¡name!
MultiplexBUD
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

known_overlapping_degree = { ...
                            [0, 0, 0]'
                            [6, 6, 6]'
                            };

g = MultiplexBUD('B', B, 'DENSITIES', [0 100]);
overlapping_degree = OverlappingDegree('G', g);
                 
assert(isequal(overlapping_degree.get('M'), known_overlapping_degree), ...
    [BRAPH2.STR ':OverlappingDegree:' BRAPH2.BUG_ERR], ...
    'OverlappingDegree is not being calculated correctly for MultiplexBUD')

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

known_overlapping_degree = { ...
                            [3, 3, 2]'
                            [0, 0, 0]'
                            };

g = MultiplexBUT('B', B, 'THRESHOLDS', [0 1]);
overlapping_degree = OverlappingDegree('G', g);
                 
assert(isequal(overlapping_degree.get('M'), known_overlapping_degree), ...
    [BRAPH2.STR ':OverlappingDegree:' BRAPH2.BUG_ERR], ...
    'OverlappingDegree is not being calculated correctly for MultiplexBUT')

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

known_overlapping_degree = {[3, 3, 2]'};

g = MultiplexWU('B', B);
overlapping_degree = OverlappingDegree('G', g);

assert(isequal(overlapping_degree.get('M'), known_overlapping_degree), ...
    [BRAPH2.STR ':OverlappingDegree:' BRAPH2.BUG_ERR], ...
    'OverlappingDegree is not being calculated correctly for MultiplexWU.')