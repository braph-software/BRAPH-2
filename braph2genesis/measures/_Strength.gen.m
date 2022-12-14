%% ¡header!
Strength < Measure (m, strength) is the graph strength.

%%% ¡description!
The strength of a graph is the sum of all weights of the edges connected to 
a node within a layer. 

%%% ¡shape!
shape = Measure.NODAL;

%%% ¡scope!
scope = Measure.UNILAYER;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
GraphWU
MultiplexWU
OrderedMultiplexWU

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the strength.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
A = g.get('A');  % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)

strength = cell(g.layernumber(), 1);

parfor li = 1:1:g.layernumber()    
    Aii = A{li, li};
    strength(li) = {sum(Aii, 2)};  % calculates the strength of a node for layer li
end
value = strength;

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
known_strength = {[1.2 0.2 1]'};
g = GraphWU('B', B);
s_outside_g = Strength('G', g);

assert(isequal(s_outside_g.get('M'), known_strength), ...
    [BRAPH2.STR ':Strength:' BRAPH2.BUG_ERR], ...
    'Strength is not being calculated correctly for GraphWU.')

%%% ¡test!
%%%% ¡name!
MultiplexWU
%%%% ¡code!
B11 = [
    0  .2 1
    .2 0  0
    1  0  0
    ];
B22 = [
    0 1  0
    1 0  .4
    0 .4 0
    ];
B = {B11 B22};

known_strength = {
                 [1.2 .2  1]'
                 [1   1.4 .4]'
                 };
                                
g = MultiplexWU('B', B);
strength = Strength('G', g);

assert(isequal(strength.get('M'), known_strength), ...
    [BRAPH2.STR ':Strength:' BRAPH2.BUG_ERR], ...
    'Strength is not being calculated correctly for MultiplexWU.')