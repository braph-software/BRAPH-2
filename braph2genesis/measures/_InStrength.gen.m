%% ¡header!
InStrength < Measure (m, in-strength) is the graph in-strength.

%%% ¡description!
The in-strength of a graph is the sum of all weights of the inward edges 
connected to a node within a layer, i.e., it is the sum of the columns of 
the adjacency matrix. 
    
%%% ¡shape!
shape = Measure.NODAL;

%%% ¡scope!
scope = Measure.UNILAYER;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
GraphWD
MultiplexWD

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the in-strength.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
A = g.get('A');  % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)

in_strength = cell(g.layernumber(), 1);

for li = 1:1:g.layernumber()    
    Aii = A{li, li};
    in_strength(li) = {sum(Aii, 1)'};  % calculates the in-strength of a node for layer li
end
value = in_strength;

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
known_in_strength = {[1 0.2 1.8]'};
g = GraphWD('B', B);
s_outside_g = InStrength('G', g);

assert(isequal(s_outside_g.get('M'), known_in_strength), ...
    [BRAPH2.STR ':InStrength:' BRAPH2.BUG_ERR], ...
    'InStrength is not being calculated correctly for GraphWD.')

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

known_in_strength = {
                [1 .2  1.8]'
                [1 1.4 1]'
                 };
                                
g = MultiplexWD('B', B);
in_strength = InStrength('G', g);

assert(isequal(in_strength.get('M'), known_in_strength), ...
    [BRAPH2.STR ':InStrength:' BRAPH2.BUG_ERR], ...
    'InStrength is not being calculated correctly for MultiplexWD.')