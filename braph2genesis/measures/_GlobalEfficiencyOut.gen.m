%% ¡header!
GlobalEfficiencyOut < Distance (m, out-global efficiency) is the graph out-global efficiency.

%%% ¡description!
The out-global efficiency is the average inverse shortest in-path length within each layer. 
It is inversely related to the characteristic in-path length.

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the GlobalEfficiencyOut.
%%%% ¡default!
'GlobalEfficiencyOut'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the GlobalEfficiencyOut.
%%%% ¡default!
'The out-global efficiency is the average inverse shortest in-path length within each layer. It is inversely related to the characteristic in-path length.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the GlobalEfficiencyOut.
%%%% ¡settings!
'GlobalEfficiencyOut'

%%% ¡prop!
ID (data, string) is a few-letter code of the GlobalEfficiencyOut.
%%%% ¡default!
'GlobalEfficiencyOut ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the GlobalEfficiencyOut.
%%%% ¡default!
'GlobalEfficiencyOut label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the GlobalEfficiencyOut.
%%%% ¡default!
'GlobalEfficiencyOut notes'

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
{'GraphWD' 'GraphBD' 'MultiplexWD' 'MultiplexBD' 'OrdMxBD' 'OrdMxWD'} ;%TBE % % % add multilayerWD multilayerBD ordmlwd ordmlbd tests

%%% ¡prop!
M (result, cell) is the out-global efficiency.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
L = g.get('LAYERNUMBER');
N = g.get('NODENUMBER');

distance = calculateValue@Distance(m, prop);

out_global_efficiency = cell(L, 1);
parfor li = 1:1:L
    inverse_distance = distance{li}.^-1;  % inverse distance
    inverse_distance(1:N(li)+1:end) = 0;
    global_efficiency_layer = (sum(inverse_distance, 2) / (N(li)-1));
    out_global_efficiency(li) = {global_efficiency_layer};
end
value = out_global_efficiency;

%% ¡tests!

%%% ¡excluded_props!
[GlobalEfficiencyOut.PFM]

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

known_out_global_efficiency = {[1/4 1/4 1/4 1/4 0]'};

g = GraphBD('B', B);

m_outside_g = GlobalEfficiencyOut('G', g);
assert(isequal(m_outside_g.get('M'), known_out_global_efficiency), ...
   [BRAPH2.STR ':GlobalEfficiencyOut:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiencyOut');
assert(isequal(m_inside_g.get('M'), known_out_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiencyOut:' BRAPH2.FAIL_TEST], ...
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

known_out_global_efficiency = {[.1/4 .2/4 .2/4 .1/4 0]'};

g = GraphWD('B', B);

m_outside_g = GlobalEfficiencyOut('G', g);
assert(isequal(m_outside_g.get('M'), known_out_global_efficiency), ...
   [BRAPH2.STR ':GlobalEfficiencyOut:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiencyOut');
assert(isequal(m_inside_g.get('M'), known_out_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiencyOut:' BRAPH2.FAIL_TEST], ...
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

known_out_global_efficiency = {
                        [.1/4 .2/4 .2/4 .1/4 0]'
                        [.1/4 .2/4 .2/4 .1/4 0]'
                        };

g = MultiplexWD('B', B);

m_outside_g = GlobalEfficiencyOut('G', g);
assert(isequal(m_outside_g.get('M'), known_out_global_efficiency), ...
   [BRAPH2.STR ':GlobalEfficiencyOut:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiencyOut');
assert(isequal(m_inside_g.get('M'), known_out_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiencyOut:' BRAPH2.FAIL_TEST], ...
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

known_out_global_efficiency = {
                        [1/4 1/4 1/4 1/4 0]'
                        [1/4 1/4 1/4 1/4 0]'
                        };

g = MultiplexBD('B', B);

m_outside_g = GlobalEfficiencyOut('G', g);
assert(isequal(m_outside_g.get('M'), known_out_global_efficiency), ...
   [BRAPH2.STR ':GlobalEfficiencyOut:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiencyOut');
assert(isequal(m_inside_g.get('M'), known_out_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiencyOut:' BRAPH2.FAIL_TEST], ...
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

known_out_global_efficiency = {
                        [.1/4 .2/4 .2/4 .1/4 0]'
                        [.1/4 .2/4 .2/4 .1/4 0]'
                        };

g = OrdMxWD('B', B);

m_outside_g = GlobalEfficiencyOut('G', g);
assert(isequal(m_outside_g.get('M'), known_out_global_efficiency), ...
   [BRAPH2.STR ':GlobalEfficiencyOut:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiencyOut');
assert(isequal(m_inside_g.get('M'), known_out_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiencyOut:' BRAPH2.FAIL_TEST], ...
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

known_out_global_efficiency = {
                        [1/4 1/4 1/4 1/4 0]'
                        [1/4 1/4 1/4 1/4 0]'
                        };

g = OrdMxBD('B', B);

m_outside_g = GlobalEfficiencyOut('G', g);
assert(isequal(m_outside_g.get('M'), known_out_global_efficiency), ...
   [BRAPH2.STR ':GlobalEfficiencyOut:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiencyOut');
assert(isequal(m_inside_g.get('M'), known_out_global_efficiency), ...
    [BRAPH2.STR ':GlobalEfficiencyOut:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])