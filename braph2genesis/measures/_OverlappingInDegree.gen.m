%% ¡header!
OverlappingInDegree < InDegree (m, overlapping in-degree) is the graph overlapping in-degree.

%%% ¡description!
The overlapping in-degree of a graph is the sum of the in-degrees of a node 
in all layers. 

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
M (result, cell) is the overlapping in-degree.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
A = g.get('A');  % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
L = g.layernumber();
N = g.nodenumber();

in_degree = calculateValue@InDegree(m, prop);
if L > 0
    overlapping_in_degree = zeros(N(1), 1);
else
    overlapping_in_degree = zeros(1);
end

for li = 1:1:L  
    overlapping_in_degree = overlapping_in_degree + in_degree{li};
end
value = {overlapping_in_degree};

%% ¡tests!

%%% ¡test!
%%%% ¡name!
MultiplexGraphBD
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

known_overlapping_in_degree = {[3, 2, 1]'};

g = MultiplexGraphBD('B', B);
overlapping_in_degree = OverlappingInDegree('G', g);
                 
assert(isequal(overlapping_in_degree.get('M'), known_overlapping_in_degree), ...
    [BRAPH2.STR ':OverlappingInDegree:' BRAPH2.BUG_ERR], ...
    'OverlappingInDegree is not being calculated correctly for MultiplexGraphBD')

%%% ¡test!
%%%% ¡name!
MultiplexGraphWD
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

known_overlapping_in_degree = {[2, 3, 1]'};

g = MultiplexGraphWD('B', B);
overlapping_in_degree = OverlappingInDegree('G', g);

assert(isequal(overlapping_in_degree.get('M'), known_overlapping_in_degree), ...
    [BRAPH2.STR ':OverlappingInDegree:' BRAPH2.BUG_ERR], ...
    'OverlappingInDegree is not being calculated correctly for MultiplexGraphWD.')