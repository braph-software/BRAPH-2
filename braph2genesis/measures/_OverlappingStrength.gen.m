%% ¡header!
OverlappingStrength < Strength (m, overlapping strength) is the graph overlapping strength.

%%% ¡description!
The overlapping strength of a graph is the sum of the strengths of a node in
all layers. 
  
%%% ¡shape!
shape = Measure.NODAL;

%%% ¡scope!
scope = Measure.SUPERGLOBAL;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
MultiplexGraphWU

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the overlapping strength.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
A = g.get('A');  % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
L = g.layernumber();
N = 1;
if L > 0
    N = length(A{1});
end

strength = calculateValue@Strength(m, prop);	
overlapping_strength = zeros(N, 1);
for li = 1:1:L  
    overlapping_strength = overlapping_strength + strength{li};
end
value = {overlapping_strength};

%% ¡tests!

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

known_overlapping_strength = {[2.2 1.5 1.3]'};

g = MultiplexGraphWU('B', B);
overlapping_strength = OverlappingStrength('G', g);

assert(isequal(overlapping_strength.get('M'), known_overlapping_strength), ...
    [BRAPH2.STR ':OverlappingStrength:' BRAPH2.BUG_ERR], ...
    'OverlappingStrength is not being calculated correctly for MultiplexGraphWU.')