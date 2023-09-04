%% ¡header!
GlobalEfficiency < Distance (m, global efficiency) is the graph global efficiency.

%%% ¡description!
The global efficiency is the average inverse shortest path length within each layer. 
It is inversely related to the characteristic path length.

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the global efficiency.
%%%% ¡default!
'GlobalEfficiency'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the global efficiency.
%%%% ¡default!
'The global efficiency is the average inverse shortest path length within each layer. It is inversely related to the characteristic path length.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the global efficiency.

%%% ¡prop!
ID (data, string) is a few-letter code of the degree.
%%%% ¡default!
'GlobalEfficiency ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the global efficiency.
%%%% ¡default!
'GlobalEfficiency label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the global efficiency.
%%%% ¡default!
'GlobalEfficiency notes'

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
{'GraphWU' 'GraphBU' 'MultigraphBUD' 'MultigraphBUT' 'MultiplexWU' 'MultiplexBU' 'MultiplexBUD' 'MultiplexBUT' 'OrdMxWU' 'OrdMxBU' 'OrdMxBUT' 'OrdMxBUD' 'MultilayerWU' 'OrdMlWU' 'MultilayerBUT' 'MultilayerBU' 'MultilayerBUD' 'OrdMlBU' 'OrdMlBUD' 'OrdMlBUT'}


%%% ¡prop!
M (result, cell) is the global efficiency.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
L = g.get('LAYERNUMBER');
N = g.get('NODENUMBER');

distance = calculateValue@Distance(m, prop);

global_efficiency = cell(L, 1);
parfor li = 1:1:L
    inverse_distance = distance{li}.^-1;  % inverse distance
    inverse_distance(1:N(li)+1:end) = 0;
    global_efficiency_layer = (sum(inverse_distance, 2) / (N(li)-1));
    global_efficiency(li) = {global_efficiency_layer};
end
value = global_efficiency;

%% ¡tests!

%%% ¡excluded_props!
[GlobalEfficiency.PFM]

%%% ¡test!
%%%% ¡name!
GraphWU
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0   .1  0   0   0
    .2  0   0   0   0
    0   0   0   .2  0
    0   0   .1  0   0
    0   0   0   0   0
    ];

known_global_efficiency = {[1/4 1/4 1/4 1/4 0]'};

g = GraphWU('B', B);

m_outside_g = GlobalEfficiency('G', g);
assert(isequal(m_outside_g.get('M'), known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiency:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiency');
assert(isequal(m_inside_g.get('M'), known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiency:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
GraphBU
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0   1   0   0   0
    1   0   0   0   0
    0   0   0   1   0
    0   0   1   0   0
    0   0   0   0   0
    ];

known_global_efficiency = {[1/4 1/4 1/4 1/4 0]'};

g = GraphBU('B', B);

m_outside_g = GlobalEfficiency('G', g);
assert(isequal(m_outside_g.get('M'), known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiency:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiency');
assert(isequal(m_inside_g.get('M'), known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiency:' BRAPH2.FAIL_TEST], ...
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

known_global_efficiency = { ...
    [0 0 0]'
    [1/2 0 1/2]'
    [2 1/2 1/2]'
    [2 2 2]'
    };

g = MultigraphBUD('B', B, 'DENSITIES', densities);

m_outside_g = GlobalEfficiency('G', g);
assert(isequal(m_outside_g.get('M'), known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiency:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiency');
assert(isequal(m_inside_g.get('M'), known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiency:' BRAPH2.FAIL_TEST], ...
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

known_global_efficiency = { ...
    [2 1/2 1/2]'
    [1/2 0 1/2]'
    [0 0 0]'
    };

g = MultigraphBUT('B', B, 'THRESHOLDS', thresholds);

m_outside_g = GlobalEfficiency('G', g);
assert(isequal(m_outside_g.get('M'), known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiency:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiency');
assert(isequal(m_inside_g.get('M'), known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiency:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexWU
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
      0   .1  0   0   0
      .2  0   0   0   0
      0   0   0   .2  0
      0   0   .1  0   0
      0   0   0   0   0
      ];

B22 = [
      0   .1  0   0   0
      .2  0   0   0   0
      0   0   0   .2  0
      0   0   .1  0   0
      0   0   0   0   0
      ];
B33 = [
      0   .1  0   0   0
      .2  0   0   0   0
      0   0   0   .2  0
      0   0   .1  0   0
      0   0   0   0   0
      ];
B = {B11  B22  B33};

known_global_efficiency = {
      [1/4 1/4 1/4 1/4 0]'
      [1/4 1/4 1/4 1/4 0]'
      [1/4 1/4 1/4 1/4 0]'
      };


g = MultiplexWU('B', B);


m_outside_g = GlobalEfficiency('G', g);
assert(isequal(m_outside_g.get('M'), known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiency:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiency');
assert(isequal(m_inside_g.get('M'), known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiency:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBU
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
      0   1   0   0   0
      1   0   0   0   0
      0   0   0   1   0
      0   0   1   0   0
      0   0   0   0   0
      ];

B22 = [
      0   1   0   0   0
      1   0   0   0   0
      0   0   0   1   0
      0   0   1   0   0
      0   0   0   0   0
      ];
B33 = [
      0   1   0   0   0
      1   0   0   0   0
      0   0   0   1   0
      0   0   1   0   0
      0   0   0   0   0
      ];
B = {B11  B22  B33};

known_global_efficiency = {
                        [1/4 1/4 1/4 1/4 0]'
                        [1/4 1/4 1/4 1/4 0]'
                        [1/4 1/4 1/4 1/4 0]'
                        };


g = MultiplexBU('B', B);


m_outside_g = GlobalEfficiency('G', g);
assert(isequal(m_outside_g.get('M'), known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiency:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiency');
assert(isequal(m_inside_g.get('M'), known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiency:' BRAPH2.FAIL_TEST], ...
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

known_global_efficiency = { ...
    [0 0 0]'
    [0 0 0]'
    [0 0 0]'
    [1/2 0 1/2]'
    [1/2 0 1/2]'
    [1/2 0 1/2]'
    [2 1/2 1/2]'
    [2 1/2 1/2]'
    [2 1/2 1/2]'
    [2 2 2]'
    [2 2 2]'
    [2 2 2]'
    };

g = MultiplexBUD('B', {B B B}, 'DENSITIES', densities);

m_outside_g = GlobalEfficiency('G', g);
assert(isequal(m_outside_g.get('M'), known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiency:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiency');
assert(isequal(m_inside_g.get('M'), known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiency:' BRAPH2.FAIL_TEST], ...
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

known_global_efficiency = {
    [2 1/2 1/2]'
    [2 1/2 1/2]'
    [2 1/2 1/2]'
    [1/2 0 1/2]'
    [1/2 0 1/2]'
    [1/2 0 1/2]'
    [0 0 0]'
    [0 0 0]'
    [0 0 0]'
    };

g = MultiplexBUT('B', {B B B}, 'THRESHOLDS', thresholds);

m_outside_g = GlobalEfficiency('G', g);
assert(isequal(m_outside_g.get('M'), known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiency:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiency');
assert(isequal(m_inside_g.get('M'), known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiency:' BRAPH2.FAIL_TEST], ...
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

known_global_efficiency = {
    [2 1/2 1/2]'
    [1/2 2 1/2]'
    };

g = OrdMxWU('B', B);

m_outside_g = GlobalEfficiency('G', g);
assert(isequal(m_outside_g.get('M'), known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiency:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiency');
assert(isequal(m_inside_g.get('M'), known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiency:' BRAPH2.FAIL_TEST], ...
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

known_global_efficiency = {
    [2 1/2 1/2]'
    [1/2 2 1/2]'
    };

g = OrdMxBU('B', B);

m_outside_g = GlobalEfficiency('G', g);
assert(isequal(m_outside_g.get('M'), known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiency:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiency');
assert(isequal(m_inside_g.get('M'), known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiency:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMxBUT
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0   .2   .7
    .2   0   0
    .7   0   0
    ];

thresholds = [0 .5 1];

known_global_efficiency = { ...
    [2 1/2 1/2]'
    [2 1/2 1/2]'
    [2 1/2 1/2]'
    [1/2 0 1/2]'
    [1/2 0 1/2]'
    [1/2 0 1/2]'
    [0 0 0]'
    [0 0 0]'
    [0 0 0]'
    };

g = OrdMxBUT('B', {B B B}, 'THRESHOLDS', thresholds);

m_outside_g = GlobalEfficiency('G', g);
assert(isequal(m_outside_g.get('M'), known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiency:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiency');
assert(isequal(m_inside_g.get('M'), known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiency:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMxBUD
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0   .2   .7
    .2   0   .1
    .7  .1   0
    ];

densities = [0 33 67 100];

known_global_efficiency = { ...
    [0 0 0]'
    [0 0 0]'
    [0 0 0]'
    [1/2 0 1/2]'
    [1/2 0 1/2]'
    [1/2 0 1/2]'
    [2 1/2 1/2]'
    [2 1/2 1/2]'
    [2 1/2 1/2]'
    [2 2 2]'
    [2 2 2]'
    [2 2 2]'
    };

g = OrdMxBUD('B', {B B B}, 'DENSITIES', densities);

m_outside_g = GlobalEfficiency('G', g);
assert(isequal(m_outside_g.get('M'), known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiency:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiency');
assert(isequal(m_inside_g.get('M'), known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiency:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultilayerWU
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   .2  1
    .2  0   0
    1   0   0
    ];
B22 = [
    0   1   0  .2  
    1   0   .3  .1
    0  .3   0   0
   .2  .1   0   0
    ];
B12 = rand(size(B11,1),size(B22,2));
B21 = B12';
B= {B11 B12;
    B21 B22};

known_global_efficiency = {
    [2 1/2 1/2]'
    [1 3 1/3 1]'
    };

g = MultilayerWU('B', B);

m_outside_g = GlobalEfficiency('G', g);
assert(isequal(m_outside_g.get('M'), known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiency:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiency');
assert(isequal(m_inside_g.get('M'), known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiency:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])


%%% ¡test!
%%%% ¡name!
OrdMlWU
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   .2  1
    .2  0   0
    1   0   0
    ];
B22 = [
    0   1   0  .2  
    1   0   .3  .1
    0  .3   0   0
   .2  .1   0   0
    ];
B12 = rand(size(B11, 1),size(B22, 2));
B21 = B12';
B= {B11 B12;
    B21 B22};

known_global_efficiency = {
    [2 1/2 1/2]'
    [1 3 1/3 1]'
    };

g = OrdMlWU('B', B);

m_outside_g = GlobalEfficiency('G', g);
assert(isequal(m_outside_g.get('M'), known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiency:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiency');
assert(isequal(m_inside_g.get('M'), known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiency:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultilayerBUT
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0    0.6
    0.6  0
    ];
B22 = [
    0   .2   .7
    .2   0   0
    .7   0   0
    ];
B33 = [
    0   1   0  .2  
    1   0   .3  .1
    0  .3   0   0
   .2  .1   0   0
    ];

thresholds = [0 .5 0.8];

known_global_efficiency = { ...
    [1 1]'
    [2 1/2 1/2]'
    [1 3 1/3 1]'
    [1 1]'
    [1/2 0 1/2]'
    [1/3 1/3 0 0]'
    [0 0]'
    [0 0 0]'
    [1/3 1/3 0 0]'
    };

B12 = rand(size(B11,1),size(B22,2));
B13 = rand(size(B11,1),size(B33,2));
B23 = rand(size(B22,1),size(B33,2));
B21 = B12';
B32 = B23';
B31 = B13';

B= {B11 B12 B13;
    B21 B22 B23;
    B31 B32 B33};

g = MultilayerBUT('B', B, 'THRESHOLDS', thresholds);

m_outside_g = GlobalEfficiency('G', g);
assert(isequal(m_outside_g.get('M'), known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiency:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiency');
assert(isequal(m_inside_g.get('M'), known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiency:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultilayerBU
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   1   1
    1   0   0
    1   0   0
    ];
B22 = [
    0   1   0	1
    1   0   1	1
    0   1   0	0
    1   1   0 	0
    ];
B12 = rand(size(B11,1),size(B22,2));
B21 = B12';
B= {B11 B12;
    B21 B22};

known_global_efficiency = {
    [2 1/2 1/2]'
    [1 3 1/3 1]'
    };

g = MultilayerBU('B', B);

m_outside_g = GlobalEfficiency('G', g);
assert(isequal(m_outside_g.get('M'), known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiency:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiency');
assert(isequal(m_inside_g.get('M'), known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiency:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultilayerBUD
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   .2   .7
    .2   0   .1
    .7  .1   0
    ];

B22 = [    
    0   .2   .7 .5
    .2   0   .1 .5
    .7  .1   0  .5
    .5  .5  .5  0
    ];
B12 = rand(size(B11,1),size(B22,2));
B21 = B12';
B= {B11 B12;
    B21 B22};

densities = [0 33 67 100];

known_global_efficiency = { ...
    [0 0 0]'
    [0 0 0 0]'
    [1/2 0 1/2]'
    [1/3 0 1/3 0]'
    [2 1/2 1/2]'
    [1 1/3 1 3]'
    [2 2 2]'
    [3 3 3 3]'
    };

g = MultilayerBUD('B', B, 'DENSITIES', densities);

m_outside_g = GlobalEfficiency('G', g);
assert(isequal(m_outside_g.get('M'), known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiency:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiency');
assert(isequal(m_inside_g.get('M'), known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiency:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMlBU
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   1   1
    1   0   0
    1   0   0
    ];
B22 = [
    0   1   0	1
    1   0   1   1
    0   1   0   0
    1   1   0   0
    ];
B12 = rand(size(B11,1),size(B22,2));
B21 = B12';
B= {B11 B12;
    B21 B22};

known_global_efficiency = {
    [2 1/2 1/2]'
    [1 3 1/3 1]'
    };

g = OrdMlBU('B', B);

m_outside_g = GlobalEfficiency('G', g);
assert(isequal(m_outside_g.get('M'), known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiency:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiency');
assert(isequal(m_inside_g.get('M'), known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiency:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMlBUD
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   .2   .7
    .2   0   .1
    .7  .1   0
    ];

B22 = [    
    0   .2   .7 .5
    .2   0   .1 .5
    .7  .1   0  .5
    .5  .5  .5  0
    ];
B12 = rand(size(B11,1),size(B22,2));
B21 = B12';
B= {B11 B12;
    B21 B22};

densities = [0 33 67 100];

known_global_efficiency = { ...
    [0 0 0]'
    [0 0 0 0]'
    [1/2 0 1/2]'
    [1/3 0 1/3 0]'
    [2 1/2 1/2]'
    [1 1/3 1 3]'
    [2 2 2]'
    [3 3 3 3]'
    };

g = OrdMlBUD('B', B, 'DENSITIES', densities);

m_outside_g = GlobalEfficiency('G', g);
assert(isequal(m_outside_g.get('M'), known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiency:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiency');
assert(isequal(m_inside_g.get('M'), known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiency:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMlBUT
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
    0   .2   .7
    .2   0   .1
    .7  .1   0
    ];

B22 = [    
    0   .2   .7 .4
    .2   0   .1 .4
    .7  .1   0  .4
    .4  .4  .4  0
    ];
B12 = rand(size(B11,1),size(B22,2));
B21 = B12';
B= {B11 B12;
    B21 B22};

thresholds = [0 .5 1];

known_global_efficiency = { ...
    [2 2 2]'
    [3 3 3 3]'
    [1/2 0 1/2]'
    [1/3 0 1/3 0]'
    [0 0 0]'
    [0 0 0 0]'
    };

g = OrdMlBUT('B', B, 'THRESHOLDS', thresholds);

m_outside_g = GlobalEfficiency('G', g);
assert(isequal(m_outside_g.get('M'), known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiency:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiency');
assert(isequal(m_inside_g.get('M'), known_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiency:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
