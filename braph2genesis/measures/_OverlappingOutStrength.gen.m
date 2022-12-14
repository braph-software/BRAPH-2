%% ¡header!
OverlappingOutStrength < OutStrength (m, overlapping out-strength) is the graph overlapping out-strength.

%%% ¡description!
The overlapping out-strength of a graph is the sum of the out-strengths of a 
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
M (result, cell) is the overlapping out-strength.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
L = g.layernumber();

if L == 0
    value = {};
else
    N = g.nodenumber();
    out_strength = calculateValue@OutStrength(m, prop);	
    overlapping_out_strength = zeros(N(1), 1);
    for li = 1:1:L  
        overlapping_out_strength = overlapping_out_strength + out_strength{li};
    end
    value = {overlapping_out_strength};
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
    0   1   0
    1   0   0
    .7  .3  0
    ];
B = {B11 B22};

known_overlapping_out_strength = {[2.2 1.4 2]'};

g = MultiplexWD('B', B);
overlapping_out_strength = OverlappingOutStrength('G', g);

assert(isequal(overlapping_out_strength.get('M'), known_overlapping_out_strength), ...
    [BRAPH2.STR ':OverlappingOutStrength:' BRAPH2.BUG_ERR], ...
    'OverlappingOutStrength is not being calculated correctly for MultiplexWD.')