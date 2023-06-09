%% ¡header!
DegreeOutAv < DegreeOut (m, degreeoutav) is the graph degreeoutav.

%%% ¡description!
The average degreeoutav of a graph is the average of all number of outward edges connected to a node within a layer. 

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the degreeoutav.
%%%% ¡default!
'DegreeOutAv'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the degreeoutav.
%%%% ¡default!
'The average degreeoutav of a graph is the average of all number of outward edges connected to a node within a layer.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the degreeoutav.

%%% ¡prop!
ID (data, string) is a few-letter code of the degreeoutav.
%%%% ¡default!
'DegreeOutAv ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the degreeoutav.
%%%% ¡default!
'DegreeOutAv label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the degreeoutav.
%%%% ¡default!
'DegreeOutAv notes'

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
{'GraphWD' 'GraphBD' 'MultiplexWD' 'MultiplexBD'}

%%% ¡prop!
M (result, cell) is the cell containing the degree-outav.
%%%% ¡calculate!
out_degree = calculateValue@DegreeOut(m, prop);	
g = m.get('G'); % graph from measure class
layerNumber = g.get('LAYERNUMBER');
degree_out_av = cell(layerNumber, 1);

parfor li = 1:1:layerNumber
    degree_out_av(li) = {mean(out_degree{li})};
end

value = degree_out_av;

%% ¡tests!

%%% ¡excluded_props!
[DegreeOutAv.PFM]

%%% ¡test!
%%%% ¡name!
GraphWD
%%%% ¡code!
B = [
    0   .2  1
    0   0   .8
    1   0   0
    ];

know_out_degree_av = {mean([2 1 1])};

g = GraphWD('B', B);

m_outside_g = DegreeOutAv('G', g);
assert(isequal(m_outside_g.get('M'), know_out_degree_av), ...
   [BRAPH2.STR ':DegreeOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeOutAv');
assert(isequal(m_inside_g.get('M'), know_out_degree_av), ...
    [BRAPH2.STR ':DegreeOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
GraphBD
%%%% ¡code!
B = [
    0   1  1
    0   0   1
    1   0   0
    ];

know_out_degree_av = {mean([2 1 1])};

g = GraphBD('B', B);

m_outside_g = DegreeOutAv('G', g);
assert(isequal(m_outside_g.get('M'), know_out_degree_av), ...
   [BRAPH2.STR ':DegreeOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeOutAv');
assert(isequal(m_inside_g.get('M'), know_out_degree_av), ...
    [BRAPH2.STR ':DegreeOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

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

known_out_degree_av = {
                      mean([2 1 1]')
                      mean([2 2 1]')
                      };

g = MultiplexWD('B', B);

m_outside_g = DegreeOutAv('G', g);
assert(isequal(m_outside_g.get('M'), known_out_degree_av), ...
   [BRAPH2.STR ':DegreeOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeOutAv');
assert(isequal(m_inside_g.get('M'), known_out_degree_av), ...
    [BRAPH2.STR ':DegreeOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBD
%%%% ¡code!
B11 = [
      0  1  1
      0  0  0
      1  0  0
      ];
B22 = [
       0  1  0
       1  0  1
       1  1  0
       ];
B = {B11 B22};

known_in_degree = { 
                  mean([2 0 1]')
                  mean([1 2 2]')
                  };

g = MultiplexBD('B', B);

m_outside_g = DegreeOutAv('G', g);
assert(isequal(m_outside_g.get('M'), known_in_degree), ...
   [BRAPH2.STR ':DegreeOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeOutAv');
assert(isequal(m_inside_g.get('M'), known_in_degree), ...
    [BRAPH2.STR ':DegreeOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])