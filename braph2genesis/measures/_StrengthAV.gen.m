%% ¡header!
StrengthAV < Strength (m, average strength) is the graph average strength.

%%% ¡description!
The average strength of a graph is the average of the sum of all weights of
the edges connected to a node within a layer. 

%%% ¡shape!
shape = Measure.GLOBAL;

%%% ¡scope!
scope = Measure.UNILAYER;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
GraphWU
MultiplexGraphWU

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the average strength.
%%%% ¡calculate!
strength= calculateValue@Strength(m, prop);					
g = m.get('G');  % graph from measure class

strength_av = cell(g.layernumber(), 1);
for li = 1:1:length(strength_av)
    strength_av(li) = {mean(strength{li})};
end

value = strength_av;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphWU
%%%% ¡code!
B = [
    0  .2 1
    .2 0  0
    1  0  0
    ];
known_strength_av = {mean([1.2 0.2 1])'};
g = GraphWU('B', {B});
s_outside_g = Strength('G', g);

assert(isequal(s_outside_g.get('M'), known_strength_av), ...
    [BRAPH2.STR ':Strength:' BRAPH2.BUG_ERR], ...
    'StrengthAV is not being calculated correctly for GraphWU.')

%%% ¡test!
%%%% ¡name!
MultiplexGraphWU
%%%% ¡code!
B11 = [
    0  .2 1
    .2 0  0
    1  0  0
    ];
B12 = eye(3);
B21 = eye(3);
B22 = [
    0 1  0
    1 0  .4
    0 .4 0
    ];
B = {
    B11     B12  
    B21     B22
    };

known_strength_av = {
                 mean([1.2 .2  1]')
                 mean([1   1.4 .4]')
                 };
                                
g = MultiplexGraphWU('B', {B});
strength_av = Strength('G', g);

assert(isequal(strength_av.get('M'), known_strength_av), ...
    [BRAPH2.STR ':Strength:' BRAPH2.BUG_ERR], ...
    'StrengthAV is not being calculated correctly for MultiplexGraphWU.')