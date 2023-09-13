%% ¡header!
GlobalEfficiencyOutAv < GlobalEfficiencyOut (m, average out-global efficiency) is the graph average out-global efficiency.

%%% ¡description!
The average out-global efficiency is the average inverse shortest in-path length within each layer. 

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the GlobalEfficiencyOutAv.
%%%% ¡default!
'GlobalEfficiencyOutAv'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the GlobalEfficiencyOutAv.
%%%% ¡default!
'The average out-global efficiency is the average inverse shortest in-path length within each layer.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the GlobalEfficiencyOutAv.
%%%% ¡settings!
'GlobalEfficiencyOutAv'

%%% ¡prop!
ID (data, string) is a few-letter code of the GlobalEfficiencyOutAv.
%%%% ¡default!
'GlobalEfficiencyOutAv ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the GlobalEfficiencyOutAv.
%%%% ¡default!
'GlobalEfficiencyOutAv label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the GlobalEfficiencyOutAv.
%%%% ¡default!
'GlobalEfficiencyOutAv notes'

%%% ¡prop!
SHAPE (constant, scalar) is the measure shape __Measure.GLOBAL__.
%%%% ¡default!
Measure.GLOBAL

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
M (result, cell) is the average out-global efficiency.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
L = g.get('LAYERNUMBER');

out_global_efficiency = calculateValue@GlobalEfficiencyOut(m, prop);

out_global_efficiency_av = cell(L, 1);
parfor li = 1:1:L
    out_global_efficiency_av(li) = {mean(out_global_efficiency{li})};
end
value = out_global_efficiency_av;

%% ¡tests!

%%% ¡excluded_props!
[GlobalEfficiencyOutAv.PFM]

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

known_out_global_efficiencyAV = {mean([1/4 1/4 1/4 1/4 0])};

g = GraphBD('B', B);

m_outside_g = GlobalEfficiencyOutAv('G', g);
assert(isequal(m_outside_g.get('M'), known_out_global_efficiencyAV), ...
   [BRAPH2.STR ':GlobalEfficiencyOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiencyOutAv');
assert(isequal(m_inside_g.get('M'), known_out_global_efficiencyAV), ...
    [BRAPH2.STR ':GlobalEfficiencyOutAv:' BRAPH2.FAIL_TEST], ...
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

known_out_global_efficiencyAV = {mean([.1/4 .2/4 .2/4 .1/4 0])};

g = GraphWD('B', B);

m_outside_g = GlobalEfficiencyOutAv('G', g);
assert(isequal(m_outside_g.get('M'), known_out_global_efficiencyAV), ...
   [BRAPH2.STR ':GlobalEfficiencyOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiencyOutAv');
assert(isequal(m_inside_g.get('M'), known_out_global_efficiencyAV), ...
    [BRAPH2.STR ':GlobalEfficiencyOutAv:' BRAPH2.FAIL_TEST], ...
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

known_out_global_efficiencyAV = {
                        mean([.1/4 .2/4 .2/4 .1/4 0])
                        mean([.1/4 .2/4 .2/4 .1/4 0])
                        };

g = MultiplexWD('B', B);

m_outside_g = GlobalEfficiencyOutAv('G', g);
assert(isequal(m_outside_g.get('M'), known_out_global_efficiencyAV), ...
   [BRAPH2.STR ':GlobalEfficiencyOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiencyOutAv');
assert(isequal(m_inside_g.get('M'), known_out_global_efficiencyAV), ...
    [BRAPH2.STR ':GlobalEfficiencyOutAv:' BRAPH2.FAIL_TEST], ...
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

known_out_global_efficiencyAV = {
                        mean([1/4 1/4 1/4 1/4 0])
                        mean([1/4 1/4 1/4 1/4 0])
                        };

g = MultiplexBD('B', B);

m_outside_g = GlobalEfficiencyOutAv('G', g);
assert(isequal(m_outside_g.get('M'), known_out_global_efficiencyAV), ...
   [BRAPH2.STR ':GlobalEfficiencyOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiencyOutAv');
assert(isequal(m_inside_g.get('M'), known_out_global_efficiencyAV), ...
    [BRAPH2.STR ':GlobalEfficiencyOutAv:' BRAPH2.FAIL_TEST], ...
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

known_out_global_efficiencyAV = {
                        mean([.1/4 .2/4 .2/4 .1/4 0])
                        mean([.1/4 .2/4 .2/4 .1/4 0])
                        };

g = OrdMxWD('B', B);

m_outside_g = GlobalEfficiencyOutAv('G', g);
assert(isequal(m_outside_g.get('M'), known_out_global_efficiencyAV), ...
   [BRAPH2.STR ':GlobalEfficiencyOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiencyOutAv');
assert(isequal(m_inside_g.get('M'), known_out_global_efficiencyAV), ...
    [BRAPH2.STR ':GlobalEfficiencyOutAv:' BRAPH2.FAIL_TEST], ...
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

known_out_global_efficiencyAV = {
                        mean([1/4 1/4 1/4 1/4 0])
                        mean([1/4 1/4 1/4 1/4 0])
                        };

g = OrdMxBD('B', B);

m_outside_g = GlobalEfficiencyOutAv('G', g);
assert(isequal(m_outside_g.get('M'), known_out_global_efficiencyAV), ...
   [BRAPH2.STR ':GlobalEfficiencyOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'GlobalEfficiencyOutAv');
assert(isequal(m_inside_g.get('M'), known_out_global_efficiencyAV), ...
    [BRAPH2.STR ':GlobalEfficiencyOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
