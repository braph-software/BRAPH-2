%% ¡header!
OutStrengthAv < OutStrength (m, average out-strength) is the graph average out-strength.

%%% ¡description!
The average out-strength of a graph is the average of the sum of all weights of
the outward edges connected to a node within a layer. 

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
M (result, cell) is the average out-strength.
%%%% ¡calculate!
out_strength = calculateValue@OutStrength(m, prop);					
g = m.get('G');  % graph from measure class

out_strength_av = cell(g.layernumber(), 1);
for li = 1:1:length(out_strength_av)
    out_strength_av(li) = {mean(out_strength{li})};
end

value = out_strength_av;

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
known_out_strength_av = {mean([1.2 0.8 1])'};
g = GraphWD('B', B);
s_outside_g = OutStrengthAv('G', g);

assert(isequal(s_outside_g.get('M'), known_out_strength_av), ...
    [BRAPH2.STR ':OutStrengthAv:' BRAPH2.BUG_ERR], ...
    'OutStrengthAv is not being calculated correctly for GraphWD.')

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

known_out_strength_av = {
                 mean([1.2 .8  1])
                 mean([1.6 1.4 .4])
                 };
                                
g = MultiplexWD('B', B);
out_strength_av = OutStrengthAv('G', g);

assert(isequal(out_strength_av.get('M'), known_out_strength_av), ...
    [BRAPH2.STR ':OutStrengthAv:' BRAPH2.BUG_ERR], ...
    'OutStrengthAv is not being calculated correctly for MultiplexWD.')