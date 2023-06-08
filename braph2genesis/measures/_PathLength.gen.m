%% ¡header!
PathLength < Measure (m, pathlength) is the graph path length.

%%% ¡description!
The path length is the average shortest path length of one node to all 
other nodes within a layer.

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the path length.
%%%% ¡default!
'PathLength'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the path length.
%%%% ¡default!
'The path length is the average shortest path length of one node to all other nodes within a layer.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the path length.

%%% ¡prop!
ID (data, string) is a few-letter code of the path length.
%%%% ¡default!
'PathLength ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the path length.
%%%% ¡default!
'PathLength label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the path length.
%%%% ¡default!
'PathLength notes'

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
{'GraphWU' 'GraphBU' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexWU' 'MultiplexBU' 'MultiplexBUD' 'MultiplexBUT'}

%%% ¡prop!
M (result, cell) is the path length.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
A = g.get('A');  % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
N = g.get('NODENUMBER');
L = g.get('LAYERNUMBER');

path_length = cell(L, 1);                    
path_length_rule = m.get('rule');

distance = Distance('G', g).get('M');

parfor li = 1:1:L
    path_length_layer = zeros(N(1), 1);
    distance_layer = distance{li};

    switch lower(path_length_rule)
        case {'subgraphs'}
            for u = 1:1:N
                Du = distance_layer(:, u);
                path_length_layer(u) = mean(Du(Du~=Inf & Du~=0));
            end
        case {'mean'}
            for u = 1:1:N
                Du = distance_layer(:, u);
                path_length_layer(u) = mean(Du(Du~=0));
            end
        otherwise  % 'harmonic' 'default'
            for u = 1:1:N
                Du = distance_layer(:, u);
                path_length_layer(u) = harmmean(Du(Du~=0));
            end
    end 
    path_length(li) = {path_length_layer}; % node Inf corresponds to isolated nodes
end
value = path_length;

%% ¡props!

%%% ¡prop! 
RULE (parameter, option) is the path length algorithm
%%%% ¡settings!
{'subgraphs' 'harmonic' 'mean'}
%%%% ¡default!
'harmonic'

%% ¡tests!

%%% ¡excluded_props!
[PathLength.PFM]

%%% ¡test!
%%%% ¡name!
GraphWU
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0   .6  1
    .6  0   0
    1   0   0
    ];

known_degree = {[2 1 1]'};

g = GraphWU('B', B);

m_outside_g = PathLength('G', g);
assert(isequal(m_outside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':PathLength:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'PathLength');
assert(isequal(m_inside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':PathLength:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
GraphBU
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0   1   1
    1   0   0
    1   0   0
    ];

known_degree = {[2 1 1]'};

g = GraphBU('B', B);

m_outside_g = PathLength('G', g);
assert(isequal(m_outside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':PathLength:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'PathLength');
assert(isequal(m_inside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':PathLength:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultigraphBUD
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0   .2   .7
    .2   0   .1
    .7  .1   0
    ];

densities = [0 33 67 100];

known_degree = { ...
    [0 0 0]'
    [1 0 1]'
    [2 1 1]'
    [2 2 2]'
    };

g = MultigraphBUD('B', B, 'DENSITIES', densities);

m_outside_g = PathLength('G', g);
assert(isequal(m_outside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':PathLength:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'PathLength');
assert(isequal(m_inside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':PathLength:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultigraphBUT
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0   .2   .7
    .2   0   0
    .7   0   0
    ];

thresholds = [0 .5 1];

known_degree = { ...
    [2 1 1]'
    [1 0 1]'
    [0 0 0]'
    };

g = MultigraphBUT('B', B, 'THRESHOLDS', thresholds);

m_outside_g = PathLength('G', g);
assert(isequal(m_outside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':PathLength:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'PathLength');
assert(isequal(m_inside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':PathLength:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexWU
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

known_degree = {
    [2 1 1]'
    [1 2 1]'
    };

g = MultiplexWU('B', B);

m_outside_g = PathLength('G', g);
assert(isequal(m_outside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':PathLength:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'PathLength');
assert(isequal(m_inside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':PathLength:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBU
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   1   1
    1   0   0
    1   0   0
    ];
B22 = [
    0   1   0
    1   0   1
    0   1   0
    ];
B = {B11 B22};

known_degree = {
    [2 1 1]'
    [1 2 1]'
    };

g = MultiplexBU('B', B);

m_outside_g = PathLength('G', g);
assert(isequal(m_outside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':PathLength:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'PathLength');
assert(isequal(m_inside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':PathLength:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBUD
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0   .2   .7
    .2   0   .1
    .7  .1   0
    ];

densities = [0 33 67 100];

known_degree = { ...
    [0 0 0]'
    [0 0 0]'
    [0 0 0]'
    [1 0 1]'
    [1 0 1]'
    [1 0 1]'
    [2 1 1]'
    [2 1 1]'
    [2 1 1]'
    [2 2 2]'
    [2 2 2]'
    [2 2 2]'
    };

g = MultiplexBUD('B', {B B B}, 'DENSITIES', densities);

m_outside_g = PathLength('G', g);
assert(isequal(m_outside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':PathLength:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'PathLength');
assert(isequal(m_inside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':PathLength:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBUT
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0   .2   .7
    .2   0   0
    .7   0   0
    ];

thresholds = [0 .5 1];

known_degree = { ...
    [2 1 1]'
    [2 1 1]'
    [2 1 1]'
    [1 0 1]'
    [1 0 1]'
    [1 0 1]'
    [0 0 0]'
    [0 0 0]'
    [0 0 0]'
    };

g = MultiplexBUT('B', {B B B}, 'THRESHOLDS', thresholds);

m_outside_g = PathLength('G', g);
assert(isequal(m_outside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':PathLength:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'PathLength');
assert(isequal(m_inside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':PathLength:' BRAPH2.FAIL_TEST], ...
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

known_degree = {
    [2 1 1]'
    [1 2 1]'
    };

g = OrdMxWU('B', B);

m_outside_g = PathLength('G', g);
assert(isequal(m_outside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':PathLength:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'PathLength');
assert(isequal(m_inside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':PathLength:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMxBU
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   1   1
    1   0   0
    1   0   0
    ];
B22 = [
    0   1   0
    1   0   1
    0   1   0
    ];
B = {B11 B22};

known_degree = {
    [2 1 1]'
    [1 2 1]'
    };

g = OrdMxBU('B', B);

m_outside_g = PathLength('G', g);
assert(isequal(m_outside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':PathLength:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'PathLength');
assert(isequal(m_inside_g.get('M'), known_degree), ...
    [BRAPH2.STR ':PathLength:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
