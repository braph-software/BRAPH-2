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
MultiplexGraphBU
MultiplexGraphWU

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the overlapping degree.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
A = g.get('A');  % cell array with adjacency matrix 
L = g.layernumber();
N = g.nodenumber();

degree = calculateValue@Degree(m, prop);
if L > 0
    overlapping_degree = zeros(N(1), 1);
else
    overlapping_degree = zeros(1);
end

for li = 1:1:L  
    overlapping_degree = overlapping_degree + degree{li};
end
value = {overlapping_degree};

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

known_overlapping_degree = {[3, 3, 2]'};

g = MultiplexGraphBU('B', B);
overlapping_degree = OverlappingDegree('G', g);
                 
assert(isequal(overlapping_degree.get('M'), known_overlapping_degree), ...
    [BRAPH2.STR ':OverlappingDegree:' BRAPH2.BUG_ERR], ...
    'OverlappingDegree is not being calculated correctly for MultiplexGraphBU')

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

known_overlapping_degree = {[3, 3, 2]'};

g = MultiplexGraphWU('B', B);
overlapping_degree = OverlappingDegree('G', g);

assert(isequal(overlapping_degree.get('M'), known_overlapping_degree), ...
    [BRAPH2.STR ':OverlappingStrength:' BRAPH2.BUG_ERR], ...
    'OverlappingStrength is not being calculated correctly for MultiplexGraphWU.')