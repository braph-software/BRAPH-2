%% ¡header!
GlobalEfficiencyIn < Distance (m, in-global efficiency) is the graph in-global efficiency.

%%% ¡description!
The in-global efficiency is the average inverse shortest in-path length within each layer. 
It is inversely related to the characteristic in-path length.

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the in-global efficiency.
%%%% ¡default!
'GlobalEfficiencyIn'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the GlobalEfficiencyIn.
%%%% ¡default!
'The in-global efficiency is the average inverse shortest in-path length within each layer. It is inversely related to the characteristic in-path length.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the GlobalEfficiencyIn.
%%%% ¡settings!
'GlobalEfficiencyIn'

%%% ¡prop!
ID (data, string) is a few-letter code of the GlobalEfficiencyIn.
%%%% ¡default!
'GlobalEfficiencyIn ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the GlobalEfficiencyIn.
%%%% ¡default!
'GlobalEfficiencyIn label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the GlobalEfficiencyIn.
%%%% ¡default!
'GlobalEfficiencyIn notes'

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
{'GraphWD' 'GraphBD' 'MultiplexWD' 'MultiplexBD' 'OrdMxBD' 'OrdMxWD'};

%%% ¡prop!
M (result, cell) is the in-global efficiency.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
L = g.get('LAYERNUMBER');
N = g.get('NODENUMBER');

distance = calculateValue@Distance(m, prop);

in_global_efficiency = cell(L, 1);
parfor li = 1:1:L
    inverse_distance = distance{li}.^-1;  % inverse distance
    inverse_distance(1:N(li)+1:end) = 0;
    global_efficiency_layer = (sum(inverse_distance, 1) / (N(li)-1));
    in_global_efficiency(li) = {global_efficiency_layer};
end
value = in_global_efficiency;

%% ¡tests!

%%% ¡excluded_props!
[GlobalEfficiencyIn.PFM]

%%% ¡test!
%%%% ¡name!
GraphBD
%%%% ¡code!
B = [
    0   .1  0   0   0
    .2  0   0   0   0
    0   0   0   .2  0
    0   0   .1  0   0
    0   0   0   0   0
    ];

known_in_global_efficiency = {[1/4 1/4 1/4 1/4 0]};

g = GraphBD('B', B);

m_outside_g = GlobalEfficiencyIn('G', g);
assert(isequal(m_outside_g.get('M'), known_in_global_efficiency), ...
   [BRAPH2.STR ':GlobalEfficiencyIn:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiencyIn');
assert(isequal(m_inside_g.get('M'), known_in_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiencyIn:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
GraphWD
%%%% ¡code!
B = [
    0   .1  0   0   0
    .2  0   0   0   0
    0   0   0   .2  0
    0   0   .1  0   0
    0   0   0   0   0
    ];

known_in_global_efficiency = {[.2/4 .1/4 .1/4 .2/4 0]};

g = GraphWD('B', B);

m_outside_g = GlobalEfficiencyIn('G', g);
assert(isequal(m_outside_g.get('M'), known_in_global_efficiency), ...
   [BRAPH2.STR ':GlobalEfficiencyIn:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiencyIn');
assert(isequal(m_inside_g.get('M'), known_in_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiencyIn:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexWD
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
B = {B11  B22};

known_in_global_efficiency = {
                        [.2/4 .1/4 .1/4 .2/4 0]
                        [.2/4 .1/4 .1/4 .2/4 0]
                        };

g = MultiplexWD('B', B);

m_outside_g = GlobalEfficiencyIn('G', g);
assert(isequal(m_outside_g.get('M'), known_in_global_efficiency), ...
   [BRAPH2.STR ':GlobalEfficiencyIn:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiencyIn');
assert(isequal(m_inside_g.get('M'), known_in_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiencyIn:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBD
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
B = {B11  B22};

known_in_global_efficiency = {
                        [1/4 1/4 1/4 1/4 0]
                        [1/4 1/4 1/4 1/4 0]
                        };

g = MultiplexBD('B', B);

m_outside_g = GlobalEfficiencyIn('G', g);
assert(isequal(m_outside_g.get('M'), known_in_global_efficiency), ...
   [BRAPH2.STR ':GlobalEfficiencyIn:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiencyIn');
assert(isequal(m_inside_g.get('M'), known_in_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiencyIn:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMxWD
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
B = {B11  B22};

known_in_global_efficiency = {
                        [.2/4 .1/4 .1/4 .2/4 0]
                        [.2/4 .1/4 .1/4 .2/4 0]
                        };

g = OrdMxWD('B', B);

m_outside_g = GlobalEfficiencyIn('G', g);
assert(isequal(m_outside_g.get('M'), known_in_global_efficiency), ...
   [BRAPH2.STR ':GlobalEfficiencyIn:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiencyIn');
assert(isequal(m_inside_g.get('M'), known_in_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiencyIn:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMxBD
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
B = {B11  B22};

known_in_global_efficiency = {
                        [1/4 1/4 1/4 1/4 0]
                        [1/4 1/4 1/4 1/4 0]
                        };

g = OrdMxBD('B', B);

m_outside_g = GlobalEfficiencyIn('G', g);
assert(isequal(m_outside_g.get('M'), known_in_global_efficiency), ...
   [BRAPH2.STR ':GlobalEfficiencyIn:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiencyIn');
assert(isequal(m_inside_g.get('M'), known_in_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiencyIn:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
