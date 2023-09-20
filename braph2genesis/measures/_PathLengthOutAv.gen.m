%% ¡header!
PathLengthOutAv < PathLengthOut (m, average out-path length) is the graph average out-path length.

%%% ¡description!
The out-path length is the average shortest out-path lengths of one node to all other nodes without a layer.

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the PathLengthOutAv.
%%%% ¡default!
'PathLengthOutAv'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the PathLengthOutAv.
%%%% ¡default!
'The PathLengthOutAv is the average shortest PathLengthOutAv of one node to all other nodes within a layer.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the PathLengthOutAv.

%%% ¡prop!
ID (data, string) is a few-letter code of the PathLengthOutAv.
%%%% ¡default!
'PathLengthOutAv ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the PathLengthOutAv.
%%%% ¡default!
'PathLengthOutAv label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the PathLengthOutAv.
%%%% ¡default!
'PathLengthOutAv notes'

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
M (result, cell) is the cell containing the PathLengthOutAv.
%%%% ¡calculate!
g = m.get('G');  % graph from measure class
A = g.get('A');  % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)
N = g.get('NODENUMBER');
L = g.get('LAYERNUMBER');

out_path_length = calculateValue@PathLengthOut(m, prop);
out_path_length_av = cell(L, 1);
parfor li = 1:1:length(out_path_length_av)
    out_path_length_av(li) = {mean(out_path_length{li})};
end
value = out_path_length_av;

%% ¡tests!

%%% ¡excluded_props!
[PathLengthOutAv.PFM]

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
known_out_path_length_av = {Inf};

g = GraphBD('B', B);

m_outside_g = PathLengthOutAv('G', g);
assert(isequal(m_outside_g.get('M'), known_out_path_length_av), ...
    [BRAPH2.STR ':PathLengthOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'PathLengthOutAv');
assert(isequal(m_inside_g.get('M'), known_out_path_length_av), ...
    [BRAPH2.STR ':PathLengthOutAv:' BRAPH2.FAIL_TEST], ...
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

known_out_path_length_av = {
                    Inf
                    Inf
                    };

g = MultiplexBD('B', B);

m_outside_g = PathLengthOutAv('G', g);
assert(isequal(m_outside_g.get('M'), known_out_path_length_av), ...
    [BRAPH2.STR ':PathLengthOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'PathLengthOutAv');
assert(isequal(m_inside_g.get('M'), known_out_path_length_av), ...
    [BRAPH2.STR ':PathLengthOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])

%%% ¡test!
%%%% ¡name!
OrdMxBD
%%%% ¡probability!
.01
%%%% ¡code!
A11 = [
      0  1  1  1  0;
      1  0  0  0  0;
      1  1  0  1  0;
      1  1  0  0  0;
      0  0  0  0  0
      ];

A22 = [
      0  1  1  1  0;
      1  0  0  0  0;
      1  1  0  1  0;
      1  1  0  0  0;
      0  0  0  0  0
      ];
A = {A11  A22};

known_out_path_length_av = {
                    Inf
                    Inf
                    };

g = OrdMxBD('B', A);
m_outside_g = PathLengthOutAv('G', g);
assert(isequal(m_outside_g.get('M'), known_out_path_length_av), ...
    [BRAPH2.STR ':PathLengthOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_outside_g) ' is not being calculated correctly for ' class(g) '.'])

m_inside_g = g.get('MEASURE', 'PathLengthOutAv');
assert(isequal(m_inside_g.get('M'), known_out_path_length_av), ...
    [BRAPH2.STR ':PathLengthOutAv:' BRAPH2.FAIL_TEST], ...
    [class(m_inside_g) ' is not being calculated correctly for ' class(g) '.'])