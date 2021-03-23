%% ¡header!
OverlappingOutDegree < OutDegree (m, overlapping out-degree) is the graph overlapping out-degree.

%%% ¡description!
The overlapping out-degree of a graph is the sum of the out-degrees of a node 
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
M (result, cell) is the overlapping out-degree.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
L = g.layernumber();

if L == 0
    value = {};
else
    N = g.nodenumber();
    out_degree = calculateValue@OutDegree(m, prop);
    overlapping_out_degree = zeros(N(1), 1);

    for li = 1:1:L  
        overlapping_out_degree = overlapping_out_degree + out_degree{li};
    end
    value = {overlapping_out_degree};
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

known_overlapping_out_degree = {[2, 3, 1]'};

g = MultiplexBD('B', B);
overlapping_out_degree = OverlappingOutDegree('G', g);
                 
assert(isequal(overlapping_out_degree.get('M'), known_overlapping_out_degree), ...
    [BRAPH2.STR ':OverlappingOutDegree:' BRAPH2.BUG_ERR], ...
    'OverlappingOutDegree is not being calculated correctly for MultiplexBD')

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

known_overlapping_out_degree = {[3, 1, 2]'};

g = MultiplexWD('B', B);
overlapping_out_degree = OverlappingOutDegree('G', g);

assert(isequal(overlapping_out_degree.get('M'), known_overlapping_out_degree), ...
    [BRAPH2.STR ':OverlappingOutDegree:' BRAPH2.BUG_ERR], ...
    'OverlappingOutDegree is not being calculated correctly for MultiplexWD.')