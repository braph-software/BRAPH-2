%% ¡header!
DegreeOverlapAv < DegreeOverlap (m, average degree overlap) is the graph average degree overlap.

%%% ¡description!
The average degree overlap is the average of the number of edges connected to the 
node in all layers. Connection weights are ignored in calculations.

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
M (result, cell) is the average degree overlap.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
[l, ls] = g.layernumber();

if l == 0
    value = {};
else
    degree_overlap = calculateValue@DegreeOverlap(m, prop);	
    degree_overlap_av = cell(length(ls), 1);
    
    for i=1:length(ls)
        degree_overlap_av(i) = {mean(degree_overlap{i})};
    end
    value = degree_overlap_av;
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

known_degree_overlap = {mean([1 1 0])};

g = MultiplexBU('B', B);
degree_overlap_av = DegreeOverlapAv('G', g);
                 
assert(isequal(degree_overlap_av.get('M'), known_degree_overlap), ...
    [BRAPH2.STR ':DegreeOverlapAv:' BRAPH2.BUG_ERR], ...
    'DegreeOverlapAv is not being calculated correctly for MultiplexBU')

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
                        mean([1 1 0])
                        0};

g = MultiplexBUT('B', B, 'THRESHOLDS', [0 1]);
degree_overlap_av = DegreeOverlapAv('G', g);
                 
assert(isequal(degree_overlap_av.get('M'), known_degree_overlap), ...
    [BRAPH2.STR ':DegreeOverlapAv:' BRAPH2.BUG_ERR], ...
    'DegreeOverlapAv is not being calculated correctly for MultiplexBUT')

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

known_degree_overlap = {mean([1 1 0])};

g = MultiplexWU('B', B);
degree_overlap_av = DegreeOverlapAv('G', g);

assert(isequal(degree_overlap_av.get('M'), known_degree_overlap), ...
    [BRAPH2.STR ':DegreeOverlapAv:' BRAPH2.BUG_ERR], ...
    'DegreeOverlapAv is not being calculated correctly for MultiplexWU')