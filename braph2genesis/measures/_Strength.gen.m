%% ¡header!
Strength < Measure (m, strength) is the graph strength.

%%% ¡description!
The strength of a graph is the sum of all weights of the edges connected to 
a node within a layer. 

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the strength.
%%%% ¡default!
'Strength'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the strength.
%%%% ¡default!
'The strength of a node is the number of edges connected to the node within a layer. Connection weights are ignored in calculations.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the strength.

%%% ¡prop!
ID (data, string) is a few-letter code of the strength.
%%%% ¡default!
'Strength ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the strength.
%%%% ¡default!
'Strength label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the strength.
%%%% ¡default!
'Strength notes'

%%% ¡prop!
SHAPE (constant, scalar) is the measure shape __Measure.NODAL__.
%%%% ¡default!
Measure.NODAL

%%% ¡prop!
SCOPE (constant, scalar) is the measure scope __Measure.UNILAYER__.
%%%% ¡default!
Measure.UNILAYER

%%% ¡prop!
PARAMETRICITY (constant, scalar) is the parametricity of the measure __Measure.NONPARAMETRIC__.
%%%% ¡default!
Measure.NONPARAMETRIC

%%% ¡prop!
COMPATIBLE_GRAPHS (constant, classlist) is the list of compatible graphs.
%%%% ¡default!
{'GraphWU' 'MultiplexWU' 'OrdMxWU'}

%%% ¡prop!
M (result, cell) is the strength.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)

L = g.get('LAYERNUMBER');
strength = cell(L, 1);

parfor li = 1:1:L
    Aii = A{li, li};
    strength(li) = {sum(Aii, 2)};  % calculates the strength of a node for layer li
end
value = strength;

%% ¡tests!

%%% ¡excluded_props!
[Strength.PFM]

%%% ¡test!
%%%% ¡name!
GraphWU
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0  .2 1
    .2 0  0
    1  0  0
    ];
known_strength = {[1.2 0.2 1]'};
g = GraphWU('B', B);
m_outside_g = Strength('G', g);
assert(isequal(m_outside_g.get('M'), known_strength), ...
    [BRAPH2.STR ':Strength:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Strength');
assert(isequal(m_inside_g.get('M'), known_strength), ...
    [BRAPH2.STR ':Strength:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])


%%% ¡test!
%%%% ¡name!
MultiplexWU
%%%% ¡probability!
.01
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
m_outside_g = Strength('G', g);
assert(isequal(m_outside_g.get('M'), known_strength), ...
    [BRAPH2.STR ':Strength:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Strength');
assert(isequal(m_inside_g.get('M'), known_strength), ...
    [BRAPH2.STR ':Strength:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])


%%% ¡test!
%%%% ¡name!
OrdMxWU
%%%% ¡probability!
.01
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
B= {B11 B22};

known_strength = {
    [1.2 .2 1]'
    [1 1.3 .3]'
    };

g = OrdMxWU('B', B);

m_outside_g = Strength('G', g);
assert(isequal(m_outside_g.get('M'), known_strength), ...
    [BRAPH2.STR ':Strength:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'Strength');
assert(isequal(m_inside_g.get('M'), known_strength), ...
    [BRAPH2.STR ':Strength:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
