%% ¡header!
DegreeIn < Measure (m, degreein) is the graph degree-in.

%%% ¡description!
The degree-in of a node is the number of inward edges connected to a node within a layer. 
Connection weights are ignored in calculations.

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the degree-in.
%%%% ¡default!
'DegreeIn'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the degree-in.
%%%% ¡default!
'The degree-in of a node is the number of inward edges connected to a node within a layer. Connection weights are ignored in calculations.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the degree-in.

%%% ¡prop!
ID (data, string) is a few-letter code of the degree-in.
%%%% ¡default!
'DegreeIn ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the degree-in.
%%%% ¡default!
'DegreeIn label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the degree-in.
%%%% ¡default!
'DegreeIn notes'

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
{'GraphWD' 'GraphBD' 'MultiplexWD' 'MultiplexBD'}


%%% ¡prop!
M (result, cell) is the cell containing the degree-in value.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
layerNumber = g.get('LAYERNUMBER');
degree_in = cell(layerNumber, 1);

parfor li = 1:1:layerNumber
    Aii = A{li, li};
    Aii = binarize(Aii);  % binarizes the adjacency matrix
    degree_in(li) = {sum(Aii, 1)'};  % calculates the degree-in of a node for layer li
end

value = degree_in;

%% ¡tests!

%%% ¡excluded_props!
[DegreeIn.PFM]

%%% ¡test!
%%%% ¡name!
GraphWD
%%%% ¡code!
B = [
    0   .2  1
    0   0   .8
    1   0   0
    ];

known_in_degree = {[1 1 2]'};

g = GraphWD('B', B);

m_outside_g = DegreeIn('G', g);
assert(isequal(m_outside_g.get('M'), known_in_degree), ...
   [BRAPH2.STR ':DegreeIn:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeIn');
assert(isequal(m_inside_g.get('M'), known_in_degree), ...
    [BRAPH2.STR ':DegreeIn:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
GraphBD
%%%% ¡code!
B = [
    0   1   1
    0   0   0
    1   0   0
    ];

known_in_degree = {[1 1 1]'};

g = GraphBD('B', B);

m_outside_g = DegreeIn('G', g);
assert(isequal(m_outside_g.get('M'), known_in_degree), ...
   [BRAPH2.STR ':DegreeIn:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeIn');
assert(isequal(m_inside_g.get('M'), known_in_degree), ...
    [BRAPH2.STR ':DegreeIn:' BRAPH2.FAIL_TEST], ...
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

known_in_degree = {
                  [1 1 2]'
                  [1 2 2]'
                  };

g = MultiplexWD('B', B);

m_outside_g = DegreeIn('G', g);
assert(isequal(m_outside_g.get('M'), known_in_degree), ...
   [BRAPH2.STR ':DegreeIn:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeIn');
assert(isequal(m_inside_g.get('M'), known_in_degree), ...
    [BRAPH2.STR ':DegreeIn:' BRAPH2.FAIL_TEST], ...
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
                  [1 1 1]'
                  [2 2 1]'
                  };

g = MultiplexBD('B', B);

m_outside_g = DegreeIn('G', g);
assert(isequal(m_outside_g.get('M'), known_in_degree), ...
   [BRAPH2.STR ':DegreeIn:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'DegreeIn');
assert(isequal(m_inside_g.get('M'), known_in_degree), ...
    [BRAPH2.STR ':DegreeIn:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])
