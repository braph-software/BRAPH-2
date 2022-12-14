%% ¡header!
OverlappingInStrength < InStrength (m, overlapping in-strength) is the graph overlapping in-strength.

%%% ¡description!
The overlapping in-strength of a graph is the sum of the in-strengths of a 
node in all layers. 
  
%%% ¡shape!
shape = Measure.NODAL;

%%% ¡scope!
scope = Measure.SUPERGLOBAL;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
MultiplexWD

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the overlapping in-strength.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
L = g.layernumber();

if L == 0
    value = {};
else
    N = g.nodenumber();
    in_strength = calculateValue@InStrength(m, prop);	
    overlapping_in_strength = zeros(N(1), 1);
    for li = 1:1:L  
        overlapping_in_strength = overlapping_in_strength + in_strength{li};
    end
    value = {overlapping_in_strength};
end

%% ¡tests!

%%% ¡test!
%%%% ¡name!
MultiplexWD
%%%% ¡code!
B11 = [
    0   .2  1
    .3  0   .1
    1   0   0
    ];
B22 = [
    0   1   .4
    1   0   0
    .7  .3  0
    ];
B = {B11 B22};

known_overlapping_in_strength = {[3 1.5 1.5]'};

g = MultiplexWD('B', B);
overlapping_in_strength = OverlappingInStrength('G', g);

assert(isequal(overlapping_in_strength.get('M'), known_overlapping_in_strength), ...
    [BRAPH2.STR ':OverlappingInStrength:' BRAPH2.BUG_ERR], ...
    'OverlappingInStrength is not being calculated correctly for MultiplexWD.')