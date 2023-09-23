%% ¡header!
PathLength < Measure (m, pathlength) is the graph pathlength.

%%% ¡description!
The pathlength is the average shortest pathlength of one node to all 
other nodes within a layer.

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the % % % .
%%%% ¡default!
'PathLength'

%%% ¡prop!
NAME (constant, string) is the name of the pathlength.
%%%% ¡default!
'PathLength'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the pathlength.
%%%% ¡default!
'The pathlength is the average shortest pathlength of one node to all other nodes within a layer.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the pathlength.
%%%% ¡settings!
'PathLength'

%%% ¡prop!
ID (data, string) is a few-letter code of the pathlength.
%%%% ¡default!
'PathLength ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the pathlength.
%%%% ¡default!
'PathLength label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the pathlength.
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
{'GraphWU' 'GraphBU' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexWU' 'MultiplexBU' 'MultiplexBUD' 'MultiplexBUT' 'MultilayerWU' 'OrdMlWU'}

%%% ¡prop!
M (result, cell) is the cell containing the pathlength.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
A = g.get('A');  % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
N = g.get('NODENUMBER');
L = g.get('LAYERNUMBER');

path_length = cell(L, 1);                    
path_length_rule = m.get('RULE');

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
RULE (parameter, option) is the pathlength algorithm
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
    0   .1  0   0
    .1  0   0  0
    0   0  0   .1
    0   0   .1  0
    ];

known_path_length = {[30 30 30 30]'};

g = GraphWU('B', B);

m_outside_g = PathLength('G', g);
assert(isequal(m_outside_g.get('M'), known_path_length), ...
    [BRAPH2.STR ':PathLength:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'PathLength');
assert(isequal(m_inside_g.get('M'), known_path_length), ...
    [BRAPH2.STR ':PathLength:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
GraphBU
%%%% ¡code!
B = [
    0   .1  0   0
    .2  0   .1  0
    0   .1  0   .2
    0   0   .1  0
    ];

known_path_length = {[18/11 18/15 18/15 18/11]'};

g = GraphBU('B', B);
path_length = PathLength('G', g).get('M');

m_outside_g = PathLength('G', g);
assert(isequal(m_outside_g.get('M'), known_path_length), ...
    [BRAPH2.STR ':PathLength:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'PathLength');
assert(isequal(m_inside_g.get('M'), known_path_length), ...
    [BRAPH2.STR ':PathLength:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultigraphBUD
%%%% ¡probability!
.01
%%%% ¡code!
B = [
     0   .1  0   0
    .2  0   .1  0
    0   .1  0   .2
    0   0   .1  0
    ];

densities = [33 67 100];

known_path_length = { ...
    [3   3   3   3]'
    [1.64   1.2   1.2  1.64]'
    [1 1 1 1]'
    };

g = MultigraphBUD('B', B, 'DENSITIES', densities);

m_outside_g = PathLength('G', g);
pl_answer = cellfun(@(x) round(x, 2), m_outside_g.get('M'), 'UniformOutput', false);
assert(isequal(pl_answer, known_path_length), ...
    [BRAPH2.STR ':PathLength:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'PathLength');
pl_answer = cellfun(@(x) round(x, 2), m_inside_g.get('M'), 'UniformOutput', false);
assert(isequal(pl_answer, known_path_length), ...
    [BRAPH2.STR ':PathLength:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultigraphBUT
%%%% ¡probability!
.01
%%%% ¡code!
B = [
     0   .1  0   0
    .2  0   .1  0
    0   .1  0   .2
    0   0   .1  0
    ];

thresholds = [0 1];

known_path_length = { ...
    [18/11 18/15 18/15 18/11]'
    [Inf   Inf   Inf   Inf]'
    };

g = MultigraphBUT('B', B, 'THRESHOLDS', thresholds);

m_outside_g = PathLength('G', g);
assert(isequal(m_outside_g.get('M'), known_path_length), ...
    [BRAPH2.STR ':PathLength:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'PathLength');
assert(isequal(m_inside_g.get('M'), known_path_length), ...
    [BRAPH2.STR ':PathLength:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexWU
%%%% ¡probability!
.01
%%%% ¡code!
A11 = [
    0   .1  0   0
    .1  0   0  0
    0   0  0   .1
    0   0   .1  0
    ];

A22 = [
    0   .1  0   0
    .1  0   0  0
    0   0  0   .1
    0   0   .1  0
    ];

B = {A11  A22};

known_path_length = {
    [30 30 30 30]'
    [30 30 30 30]'
    };

g = MultiplexWU('B', B);

m_outside_g = PathLength('G', g);
assert(isequal(m_outside_g.get('M'), known_path_length), ...
    [BRAPH2.STR ':PathLength:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'PathLength');
assert(isequal(m_inside_g.get('M'), known_path_length), ...
    [BRAPH2.STR ':PathLength:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBU
%%%% ¡probability!
.01
%%%% ¡code!
A11 = [
      0   .1  0   0
      .2  0   .1  0
      0   .1  0   .2
      0   0   .1  0
      ];

A22 = [
      0   .1  0   0
      .2  0   .1  0
      0   .1  0   .2
      0   0   .1  0
      ];
B = {A11  A22};

known_path_length = {
    [18/11 18/15 18/15 18/11]'
    [18/11 18/15 18/15 18/11]'
    };

g = MultiplexBU('B', B);

m_outside_g = PathLength('G', g);
assert(isequal(m_outside_g.get('M'), known_path_length), ...
    [BRAPH2.STR ':PathLength:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'PathLength');
assert(isequal(m_inside_g.get('M'), known_path_length), ...
    [BRAPH2.STR ':PathLength:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBUD
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0   .1  0   0
    .2  0   .1  0
    0   .1  0   .2
    0   0   .1  0
    ];

densities = [33 67 100];

known_path_length = { ...
    [3   3   3   3]'
    [3   3   3   3]'
    [3   3   3   3]'
    [1.64   1.2   1.2  1.64]'
    [1.64   1.2   1.2  1.64]'
    [1.64   1.2   1.2  1.64]'
    [1 1 1 1]'
    [1 1 1 1]'
    [1 1 1 1]'
    };

g = MultiplexBUD('B', {B B B}, 'DENSITIES', densities);

m_outside_g = PathLength('G', g);
pl_answer = cellfun(@(x) round(x, 2), m_outside_g.get('M'), 'UniformOutput', false);
assert(isequal(pl_answer, known_path_length), ...
    [BRAPH2.STR ':PathLength:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'PathLength');
pl_answer = cellfun(@(x) round(x, 2), m_inside_g.get('M'), 'UniformOutput', false);
assert(isequal(pl_answer, known_path_length), ...
    [BRAPH2.STR ':PathLength:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBUT
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0   .1  0   0
    .2  0   .1  0
    0   .1  0   .2
    0   0   .1  0
    ];

thresholds = [0 1];

known_path_length = { ...
    [1.64   1.2   1.2  1.64]'
    [1.64   1.2   1.2  1.64]'
    [1.64   1.2   1.2  1.64]'
    [Inf   Inf   Inf   Inf]'
    [Inf   Inf   Inf   Inf]'
    [Inf   Inf   Inf   Inf]'
    };

g = MultiplexBUT('B', {B B B}, 'THRESHOLDS', thresholds);

m_outside_g = PathLength('G', g);
pl_answer = cellfun(@(x) round(x, 2), m_outside_g.get('M'), 'UniformOutput', false);
assert(isequal(pl_answer, known_path_length), ...
    [BRAPH2.STR ':PathLength:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'PathLength');
pl_answer = cellfun(@(x) round(x, 2), m_inside_g.get('M'), 'UniformOutput', false);
assert(isequal(pl_answer, known_path_length), ...
    [BRAPH2.STR ':PathLength:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultilayerWU
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   .1  0   0
    .1  0   0  0
    0   0  0   .1
    0   0   .1  0
    ];

B22 = [
    0   .1  0   0
    .1  0   0  0
    0   0  0   .1
    0   0   .1  0
    ];

B = {B11  B22};
B12 = rand(size(B11, 1),size(B22, 2));
B21 = B12';
B= {B11 B12;
    B21 B22};

known_path_length = {
    [30 30 30 30]'
    [30 30 30 30]'
    };

g = MultilayerWU('B', B);

m_outside_g = PathLength('G', g);
pl_answer = cellfun(@(x) round(x, 2), m_outside_g.get('M'), 'UniformOutput', false);
assert(isequal(pl_answer, known_path_length), ...
    [BRAPH2.STR ':PathLength:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'PathLength');
pl_answer = cellfun(@(x) round(x, 2), m_inside_g.get('M'), 'UniformOutput', false);
assert(isequal(pl_answer, known_path_length), ...
    [BRAPH2.STR ':PathLength:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMlWU
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   .1  0   0
    .1  0   0  0
    0   0  0   .1
    0   0   .1  0
    ];

B22 = [
    0   .1  0   0
    .1  0   0  0
    0   0  0   .1
    0   0   .1  0
    ];

B = {B11  B22};
B12 = rand(size(B11, 1),size(B22, 2));
B21 = B12';
B= {B11 B12;
    B21 B22};

known_path_length = {
    [30 30 30 30]'
    [30 30 30 30]'
    };

g = OrdMlWU('B', B);

m_outside_g = PathLength('G', g);
pl_answer = cellfun(@(x) round(x, 2), m_outside_g.get('M'), 'UniformOutput', false);
assert(isequal(pl_answer, known_path_length), ...
    [BRAPH2.STR ':PathLength:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'PathLength');
pl_answer = cellfun(@(x) round(x, 2), m_inside_g.get('M'), 'UniformOutput', false);
assert(isequal(pl_answer, known_path_length), ...
    [BRAPH2.STR ':PathLength:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])