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
g = m.get('G');  % graph from measure class
L = g.layernumber();

if L == 0
    value = {};
else
    N = g.nodenumber();
    degree = calculateValue@Degree(m, prop);

    if g.existsTag('densities') || g.existsTag('thresholds') 
        if g.existsTag('densities') g.existsTag('thresholds') 
            dt = length(g.get('DENSITIES'));
        else
            dt = length(g.get('THRESHOLDS'));
        end
        
        overlapping_degree = cell(dt, 1);
        count = 1;
        for j = 1:L:dt*L
            overlapping_degree_dt = zeros(N(1), 1);
            for li = j:1:L+j-1  
                overlapping_degree_dt = overlapping_degree_dt + degree{li};
            end
            overlapping_degree(count) = {overlapping_degree_dt};
            count = count + 1;
        end
        value = overlapping_degree;
    else
    
        overlapping_degree = zeros(N(1), 1);

        for li = 1:1:L  
            overlapping_degree = overlapping_degree + degree{li};
        end
        value = {overlapping_degree};
    end
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

known_overlapping_degree = {
                            [3 3 2]'
                            [0 0 0]'};

thresholds = [0 1];
g = MultiplexBUT('B', B, 'THRESHOLDS', thresholds);

overlapping_degree = OverlappingDegree('G', g);
                 
assert(isequal(overlapping_degree.get('M'), known_overlapping_degree), ...
    [BRAPH2.STR ':OverlappingDegree:' BRAPH2.BUG_ERR], ...
    'OverlappingDegree is not being calculated correctly for MultiplexBU')

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