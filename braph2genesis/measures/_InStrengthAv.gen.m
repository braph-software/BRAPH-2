%% ¡header!
InStrengthAv < InStrength (m, average in-strength) is the graph average in-strength.

%%% ¡description!
The average in-strength of a graph is the average of the sum of all weights of
the inward edges connected to a node within a layer. 

%%% ¡shape!
shape = Measure.GLOBAL;

%%% ¡scope!
scope = Measure.UNILAYER;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
GraphWD
MultiplexWD

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the average in-strength.
%%%% ¡calculate!
in_strength = calculateValue@InStrength(m, prop);					
g = m.get('G');  % graph from measure class

in_strength_av = cell(g.layernumber(), 1);
for li = 1:1:length(in_strength_av)
    in_strength_av(li) = {mean(in_strength{li})};
end

value = in_strength_av;

%% ¡tests!

%%% ¡test!
%%%% ¡name!
GraphWD
%%%% ¡code!
B = [
    0  .2 1
    0  0  .8
    1  0  0
    ];
known_in_strength_av = {mean([[1 0.2 1.8]])'};
g = GraphWD('B', B);
s_outside_g = InStrengthAv('G', g);

assert(isequal(s_outside_g.get('M'), known_in_strength_av), ...
    [BRAPH2.STR ':InStrengthAv:' BRAPH2.BUG_ERR], ...
    'InStrengthAv is not being calculated correctly for GraphWD.')

%%% ¡test!
%%%% ¡name!
MultiplexWD
%%%% ¡code!
B11 = [
    0   .2  1
    0   0   .8
    1   0   0
    ];
B22 = [
    0  1   .6
    1  0   .4
    0  .4  0
    ];
B = {B11 B22};

known_in_strength_av = {
                 mean([1 .2  1.8])
                 mean([1 1.4 1])
                 };
                                
g = MultiplexWD('B', B);
in_strength_av = InStrengthAv('G', g);

assert(isequal(in_strength_av.get('M'), known_in_strength_av), ...
    [BRAPH2.STR ':InStrengthAv:' BRAPH2.BUG_ERR], ...
    'InStrengthAv is not being calculated correctly for MultiplexWD.')