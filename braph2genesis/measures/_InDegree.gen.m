%% ¡header!
InDegree < Measure (m, degree) is the graph in-degree.

%%% ¡description!
The in-degree of a node is the number of inward edges connected to a node within a layer.
Connection weights are ignored in calculations.

%%% ¡shape!
shape = Measure.NODAL;

%%% ¡scope!
scope = Measure.UNILAYER;

%%% ¡parametricity!
parametricity = Measure.NONPARAMETRIC;

%%% ¡compatible_graphs!
GraphWD
GraphBD
MultiplexWD
MultiplexBD

%% ¡props_update!

%%% ¡prop!
M (result, cell) is the in-degree.
%%%% ¡calculate!
g = m.get('G'); % graph from measure class
A = g.get('A'); % cell with adjacency matrix (for graph) or 2D-cell array (for multigraph, multiplex, etc.)

in_degree = cell(g.layernumber(), 1);

for li = 1:1:g.layernumber()
    Aii = A{li, li};
    Aii = binarize(Aii);  % binarizes the adjacency matrix
    in_degree(li) = {sum(Aii, 1)'};  % calculates the in-degree of a node for layer li
end

value = in_degree;

%% ¡tests!

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

m_outside_g = InDegree('G', g);
assert(isequal(m_outside_g.get('M'), known_in_degree), ...
    [BRAPH2.STR ':InDegree:' BRAPH2.BUG_ERR], ...
    'InDegree is not being calculated correctly for GraphBD.')

m_inside_g = g.getMeasure('InDegree');
assert(isequal(m_inside_g.get('M'), known_in_degree), ...
    [BRAPH2.STR ':InDegree:' BRAPH2.BUG_ERR], ...
    'InDegree is not being calculated correctly for GraphBD.')

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

m_outside_g = InDegree('G', g);
assert(isequal(m_outside_g.get('M'), known_in_degree), ...
    [BRAPH2.STR ':InDegree:' BRAPH2.BUG_ERR], ...
    'InDegree is not being calculated correctly for GraphWD.')

m_inside_g = g.getMeasure('InDegree');
assert(isequal(m_inside_g.get('M'), known_in_degree), ...
    [BRAPH2.STR ':InDegree:' BRAPH2.BUG_ERR], ...
    'InDegree is not being calculated correctly for GraphWD.')

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

m_outside_g = InDegree('G', g);
assert(isequal(m_outside_g.get('M'), known_in_degree), ...
    [BRAPH2.STR ':InDegree:' BRAPH2.BUG_ERR], ...
    'InDegree is not being calculated correctly for MultiplexBD.')

m_inside_g = g.getMeasure('InDegree');
assert(isequal(m_inside_g.get('M'), known_in_degree), ...
    [BRAPH2.STR ':InDegree:' BRAPH2.BUG_ERR], ...
    'InDegree is not being calculated correctly for MultiplexBD.')

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

m_outside_g = InDegree('G', g);
assert(isequal(m_outside_g.get('M'), known_in_degree), ...
    [BRAPH2.STR ':InDegree:' BRAPH2.BUG_ERR], ...
    'InDegree is not being calculated correctly for MultiplexWD.')

m_inside_g = g.getMeasure('InDegree');
assert(isequal(m_inside_g.get('M'), known_in_degree), ...
    [BRAPH2.STR ':InDegree:' BRAPH2.BUG_ERR], ...
    'InDegree is not being calculated correctly for MultiplexWD.')