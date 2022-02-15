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
MultiplexBD
MultiplexWD

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the overlapping in-degree.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
L = g.layernumber();

if L == 0
    value = {};
else  
    N = g.nodenumber();
    in_degree = calculateValue@InDegree(m, prop);
    overlapping_in_degree = zeros(N(1), 1);

    for li = 1:1:L  
        overlapping_in_degree = overlapping_in_degree + in_degree{li};
    end
    value = {overlapping_in_degree};
end

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

known_overlapping_in_degree = {[3, 2, 1]'};

g = MultiplexBD('B', B);
overlapping_in_degree = OverlappingInDegree('G', g);
                 
assert(isequal(overlapping_in_degree.get('M'), known_overlapping_in_degree), ...
    [BRAPH2.STR ':OverlappingInDegree:' BRAPH2.BUG_ERR], ...
    'OverlappingInDegree is not being calculated correctly for MultiplexBD')

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

known_overlapping_in_degree = {[2, 3, 1]'};

g = MultiplexWD('B', B);
overlapping_in_degree = OverlappingInDegree('G', g);

assert(isequal(overlapping_in_degree.get('M'), known_overlapping_in_degree), ...
    [BRAPH2.STR ':OverlappingInDegree:' BRAPH2.BUG_ERR], ...
    'OverlappingInDegree is not being calculated correctly for MultiplexWD.')