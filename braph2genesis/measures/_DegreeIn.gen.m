%% ¡header!
DegreeIn < Measure (m, in-degree) is the graph in-degree.

%%% ¡description!
The in-degree (DegreeIn) of a node is the number of inward edges connected to a node within a layer. 
Connection weights are ignored in calculations.

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the in-degree.
%%%% ¡default!
'DegreeIn'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the in-degree.
%%%% ¡default!
'The in-degree (DegreeIn) of a node is the number of inward edges connected to a node within a layer. Connection weights are ignored in calculations.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the in-degree.
%%%% ¡settings!
'DegreeIn'

%%% ¡prop!
ID (data, string) is a few-letter code of the in-degree.
%%%% ¡default!
'DegreeIn ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the in-degree.
%%%% ¡default!
'DegreeIn label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the in-degree.
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
{'GraphWD' 'GraphBD' 'MultiplexWD' 'MultiplexBD' 'OrdMxWD' 'OrdMxBD' 'OrdMlWD'} ;%TBE % % % add any missing tests

%%% ¡prop!
M (result, cell) is the cell containing the in-degree value.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
L = g.get('LAYERNUMBER');
in_degree = cell(L, 1);

parfor li = 1:1:L
    Aii = A{li, li};
    Aii = binarize(Aii);  % binarizes the adjacency matrix
    in_degree(li) = {sum(Aii, 1)'};  % calculates the in-degree of a node for layer li
end

value = in_degree;

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
