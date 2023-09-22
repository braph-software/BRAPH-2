%% ¡header!
PathLengthInAv < PathLengthIn (m, average in-path length) is the graph average in-path length.

%%% ¡description!
The average in-path length of a graph is the average of the sum of the in-path lengths within each layer. 

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the average in-path length.
%%%% ¡default!
'PathLengthInAv'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the average in-path length.
%%%% ¡default!
'The average in-path length is the average shortest in-path length of one node to all other nodes within a layer.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the average in-path length.

%%% ¡prop!
ID (data, string) is a few-letter code of the average in-path length.
%%%% ¡default!
'PathLengthInAv ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the average in-path length.
%%%% ¡default!
'PathLengthInAv label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the average in-path length.
%%%% ¡default!
'PathLengthInAv notes'

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
{'GraphBD' 'GraphWD' 'MultiplexBD' 'MultiplexWD' 'MultilayerBD' 'OrdMlBD'}

%%% ¡prop!
M (result, cell) is the cell containing the average in-path length.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
A = g.get('A');  % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
N = g.get('NODENUMBER');
L = g.get('LAYERNUMBER');

in_path_length = calculateValue@PathLengthIn(m, prop);
in_path_length_av = cell(L, 1);
parfor li = 1:1:length(in_path_length_av)
    in_path_length_av(li) = {mean(in_path_length{li})};
end
value = in_path_length_av;

%% ¡tests!

%%% ¡excluded_props!
[PathLengthInAv.PFM]

%%% ¡test!
%%%% ¡name!
GraphBD
%%%% ¡probability!
.01
%%%% ¡code!
B = [
    0  1  1  1  0;
    1  0  0  0  0;
    1  1  0  1  0;
    1  1  0  0  0;
    0  0  0  0  0
    ];

known_in_path_length_av = {Inf};

g = GraphBD('B', B);

m_outside_g = PathLengthInAv('G', g);
assert(isequal(m_outside_g.get('M'), known_in_path_length_av), ...
    [BRAPH2.STR ':PathLengthInAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'PathLengthInAv');
assert(isequal(m_inside_g.get('M'), known_in_path_length_av), ...
    [BRAPH2.STR ':PathLengthInAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
MultiplexBD
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
      0  1  1  1  0;
      1  0  0  0  0;
      1  1  0  1  0;
      1  1  0  0  0;
      0  0  0  0  0
      ];

B22 = [
      0  1  1  1  0;
      1  0  0  0  0;
      1  1  0  1  0;
      1  1  0  0  0;
      0  0  0  0  0
       ];
B = {B11 B22};

known_in_path_length = {
                    Inf
                    Inf
                    };

g = MultiplexBD('B', B);

m_outside_g = PathLengthInAv('G', g);
assert(isequal(m_outside_g.get('M'), known_in_path_length), ...
    [BRAPH2.STR ':PathLengthInAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'PathLengthInAv');
assert(isequal(m_inside_g.get('M'), known_in_path_length), ...
    [BRAPH2.STR ':PathLengthInAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMlBD
%%%% ¡probability!
.01
%%%% ¡code!
B11 = [
      0  1  1  1  0;
      1  0  0  0  0;
      1  1  0  1  0;
      1  1  0  0  0;
      0  0  0  0  0
      ];

B22 = [
      0  1  1  1  0;
      1  0  0  0  0;
      1  1  0  1  0;
      1  1  0  0  0;
      0  0  0  0  0
      ];
B12 = rand(size(B11,1),size(B22,2));
B21 = B12';
B = {B11 B12;
     B21 B22};

known_in_path_length = {
                    Inf
                    Inf
                    };

g = OrdMlBD('B', B);

m_outside_g = PathLengthInAv('G', g);
assert(isequal(m_outside_g.get('M'), known_in_path_length), ...
    [BRAPH2.STR ':PathLengthInAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'PathLengthInAv');
assert(isequal(m_inside_g.get('M'), known_in_path_length), ...
    [BRAPH2.STR ':PathLengthInAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])