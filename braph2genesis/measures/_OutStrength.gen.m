%% ¡header!
OutStrength < Measure (m, out-strength) is the graph out-strength.

%%% ¡description!
The out-strength of a graph is the sum of all weights of the outward edges 
connected to a node within a layer, i.e., it is the sum of the rows of 
the adjacency matrix. 
    
%%% ¡shape!
shape = Measure.NODAL;

%%% ¡scope!
scope = Measure.UNILAYER;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
GraphWD
MultiplexGraphWD

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the out-strength.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
A = g.get('A');  % cell array with adjacency matrix 

out_strength = cell(g.layernumber(), 1);

for li = 1:1:g.layernumber()    
    Aii = A{li, li};
    out_strength(li) = {sum(Aii, 2)};  % calculates the out-strength of a node for layer li
end
value = out_strength;

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
known_out_strength = {[1.2 0.8 1]'};
g = GraphWD('B', B);
s_outside_g = OutStrength('G', g);

assert(isequal(s_outside_g.get('M'), known_out_strength), ...
    [BRAPH2.STR ':OutStrength:' BRAPH2.BUG_ERR], ...
    'OutStrength is not being calculated correctly for GraphWD.')

%%% ¡test!
%%%% ¡name!
MultiplexGraphWD
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

known_out_strength = {
                [1.2 .8  1]'
                [1.6 1.4 .4]'
                 };
                                
g = MultiplexGraphWD('B', B);
out_strength = OutStrength('G', g);

assert(isequal(out_strength.get('M'), known_out_strength), ...
    [BRAPH2.STR ':OutStrength:' BRAPH2.BUG_ERR], ...
    'OutStrength is not being calculated correctly for MultiplexGraphWD.')