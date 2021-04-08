%% ¡header!
OverlappingDegreeAv < OverlappingDegree (m, average overlapping degree) is the graph average overlapping degree.

%%% ¡description!
The average overlapping degree of a graph is the average of the sum of the 
degrees of a node in all layers. 

%%% ¡shape!
shape = Measure.GLOBAL;

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
M (result, cell) is the average overlapping degree.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
[l, ls] = g.layernumber();

if l == 0
    value = {};
else
    overlapping_degree = calculateValue@OverlappingDegree(m, prop);
    overlapping_degree_av = cell(length(ls), 1);

    for i=1:length(ls)
        overlapping_degree_av(i) = {mean(overlapping_degree{i})};
    end
    value = overlapping_degree_av;
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

known_overlapping_degree_av = {mean([3, 3, 2])};

g = MultiplexBU('B', B);
overlapping_degree_av = OverlappingDegreeAv('G', g);
                 
assert(isequal(overlapping_degree_av.get('M'), known_overlapping_degree_av), ...
    [BRAPH2.STR ':OverlappingDegreeAv:' BRAPH2.BUG_ERR], ...
    'OverlappingDegreeAv is not being calculated correctly for MultiplexBU')

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

known_overlapping_degree_av = { ...
                            mean([3, 3, 2])
                            0
                            };

g = MultiplexBUT('B', B, 'THRESHOLDS', [0 1]);
overlapping_degree_av = OverlappingDegreeAv('G', g);
                 
assert(isequal(overlapping_degree_av.get('M'), known_overlapping_degree_av), ...
    [BRAPH2.STR ':OverlappingDegreeAv:' BRAPH2.BUG_ERR], ...
    'OverlappingDegreeAv is not being calculated correctly for MultiplexBUT')

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

known_overlapping_degree_av = {mean([3, 3, 2])};

g = MultiplexWU('B', B);
overlapping_degree_av = OverlappingDegreeAv('G', g);

assert(isequal(overlapping_degree_av.get('M'), known_overlapping_degree_av), ...
    [BRAPH2.STR ':OverlappingDegreeAv:' BRAPH2.BUG_ERR], ...
    'OverlappingDegreeAv is not being calculated correctly for MultiplexWU.')