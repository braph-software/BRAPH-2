%% ¡header!
StrengthOut < Measure (m, out-strength) is the graph Out-Strength.

%%% ¡description!
The Out-Strength (StrengthOut) of a graph is the sum of all weights of the outward edges 
connected to a node within a layer, i.e., it is the sum of the rows of 
the adjacency matrix. 

%%% ¡build!
1

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
StrengthOut.ID
%%%% ¡title!
Measure ID

%%% ¡prop!
%%%% ¡id!
StrengthOut.LABEL
%%%% ¡title!
Measure NAME

%%% ¡prop!
%%%% ¡id!
StrengthOut.G
%%%% ¡title!
Graph

%%% ¡prop!
%%%% ¡id!
StrengthOut.M
%%%% ¡title!
Out-Strength

%%% ¡prop!
%%%% ¡id!
StrengthOut.PFM
%%%% ¡title!
Measure Plot

%%% ¡prop!
%%%% ¡id!
StrengthOut.NOTES
%%%% ¡title!
Measure NOTES

%%% ¡prop!
%%%% ¡id!
StrengthOut.COMPATIBLE_GRAPHS
%%%% ¡title!
Compatible Graphs

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Out-Strength.
%%%% ¡default!
'StrengthOut'

%%% ¡prop!
NAME (constant, string) is the name of the Out-Strength.
%%%% ¡default!
'Out-Strength'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Out-Strength.
%%%% ¡default!
'The Out-Strength (StrengthOut) of a graph is the sum of all weights of the outward edges connected to a node within a layer, i.e., it is the sum of the rows of the adjacency matrix.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Out-Strength.
%%%% ¡settings!
'StrengthOut'

%%% ¡prop!
ID (data, string) is a few-letter code of the Out-Strength.
%%%% ¡default!
'StrengthOut ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Out-Strength.
%%%% ¡default!
'Out-Strength label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Out-Strength.
%%%% ¡default!
'Out-Strength notes'

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
{'GraphWD' 'MultiplexWD' 'OrdMxWD' 'MultilayerWD' 'OrdMlWD'}

%%% ¡prop!
M (result, cell) is the Out-Strength.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)

L = g.get('LAYERNUMBER');
out_strength = cell(L, 1);

parfor li = 1:1:L
    Aii = A{li, li};
    out_strength(li) = {sum(Aii, 2)};  % calculates the out-strength of a node for layer li
end
value = out_strength;

%% ¡tests!

%%% ¡excluded_props!
[StrengthIn.PFM]

%%% ¡test!
%%%% ¡name!
GraphWD
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0  .2 1
    .2 0  0
    1  0  0
    ];
known_strength = {[1.2 0.2 1]'};
g = GraphWD('B', B);
m_outside_g = StrengthOut('G', g);
assert(isequal(m_outside_g.get('M'), known_strength), ...
    [BRAPH2.STR ':StrengthOut:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'StrengthOut');
assert(isequal(m_inside_g.get('M'), known_strength), ...
    [BRAPH2.STR ':StrengthOut:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexWD
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
                                
g = MultiplexWD('B', B);
m_outside_g = StrengthOut('G', g);
assert(isequal(m_outside_g.get('M'), known_strength), ...
    [BRAPH2.STR ':StrengthOut:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'StrengthOut');
assert(isequal(m_inside_g.get('M'), known_strength), ...
    [BRAPH2.STR ':StrengthOut:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMxWD
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   .3  1
    .2  0   0
    1   0   0
    ];
B22 = [
    0   0.3   0
    1   0   .3
    0   .3  0
    ];
B= {B11 B22};

known_strength = {
    [1.3 .2 1]'
    [0.3 1.3 .3]'
    };

g = OrdMxWD('B', B);

m_outside_g = StrengthOut('G', g);
assert(isequal(m_outside_g.get('M'), known_strength), ...
    [BRAPH2.STR ':StrengthOut:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'StrengthOut');
assert(isequal(m_inside_g.get('M'), known_strength), ...
    [BRAPH2.STR ':StrengthOut:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultilayerWD
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   0.2   .7
    .2   0   .1
    .7  .1   0
    ];

B22 = [    
    0   .2   .7 .5
    .2   0   .1 .5
    .7  .1   0  .5
    .5  .5  .5  0
    ];
B33 = [    
    0   .2   .9 .5
    .2   0   .1 .5
    .9  .1   0  .2
    .5  .5  .2  0
    ];
B12 = rand(size(B11,1),size(B22,2));
B13 = rand(size(B11,1),size(B33,2));
B23 = rand(size(B22,1),size(B33,2));
B21 = B12';
B31 = B13';
B32 = B23';
B= {B11 B12 B13;
    B21 B22 B23;
    B31 B32 B33};

known_strength = {
    [0.9 0.3 0.8]'
    [1.4 0.8 1.3 1.5]'
    [1.6 0.8 1.2 1.2]'
    };

g = MultilayerWD('B', B);

m_outside_g = StrengthOut('G', g);
pl_answer = cellfun(@(x) round(x, 3), m_outside_g.get('M'), 'UniformOutput', false);;
assert(isequal(pl_answer, known_strength), ...
    [BRAPH2.STR ':StrengthOut:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'StrengthOut');
pl_answer = cellfun(@(x) round(x, 3), m_inside_g.get('M'), 'UniformOutput', false);
assert(isequal(pl_answer, known_strength), ...
    [BRAPH2.STR ':StrengthOut:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMlWD
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   0.2   .7
    .2   0   .1
    .7  .1   0
    ];

B22 = [    
    0   .2   .7 .5
    .2   0   .1 .5
    .7  .1   0  .5
    .5  .5  .5  0
    ];
B33 = [    
     0  .2   .9 .5
    .2   0   .1 .5
    .9  .1   0  .2
    .5  .5  .2  0
    ];
B12 = rand(size(B11,1),size(B22,2));
B13 = rand(size(B11,1),size(B33,2));
B23 = rand(size(B22,1),size(B33,2));
B21 = B12';
B31 = B13';
B32 = B23';
B= {B11 B12 B13;
    B21 B22 B23;
    B31 B32 B33};

known_strength = {
    [0.9 0.3 0.8]'
    [1.4 0.8 1.3 1.5]'
    [1.6 0.8 1.2 1.2]'
    };

g = OrdMlWD('B', B);
m_outside_g = StrengthOut('G', g);
pl_answer = cellfun(@(x) round(x, 3), m_outside_g.get('M'), 'UniformOutput', false);
assert(isequal(pl_answer, known_strength), ...
    [BRAPH2.STR ':StrengthOut:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'StrengthOut');
pl_answer = cellfun(@(x) round(x, 3), m_inside_g.get('M'), 'UniformOutput', false);
assert(isequal(pl_answer, known_strength), ...
    [BRAPH2.STR ':StrengthOut:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
